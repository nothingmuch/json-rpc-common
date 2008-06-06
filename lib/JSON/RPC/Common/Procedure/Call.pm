#!/usr/bin/perl

package JSON::RPC::Common::Procedure::Call;
use Moose;

use Carp qw(croak);

use namespace::clean -except => [qw(meta)];

sub inflate {
	my ( $class, $data ) = @_;

	croak "Inflate takes a hash reference" unless ref $data eq 'HASH';

	my $subclass = $class->_version_class($data);
	
	Class::MOP::load_class($subclass);
	
	$subclass->new(%$data);
}

sub _version_class {
	my ( $class, $data ) = @_;

	my $version = $class->_get_version($data);

	my @numbers = ( $version =~ /(\d+)/g ) ;

	return join( "::", $class, join("_", Version => @numbers) );
}

sub _get_version {
	my ( $class, $data ) = @_;

	if ( exists $data->{jsonrpc} ) {
		return $data->{jsonrpc}; # presumably 2.0
	} elsif ( exists $data->{version} ) {
		return $data->{version}; # presumably 1.1
	} else {
		return "1.0";
	}
}

has [ qw(result_response_class error_response_class) ] => (
	isa => "ClassName",
	is  => "rw",
	required => 1,
);

has version => (
	isa => "Str",
	is  => "ro",
	required => 1,
);

has method => (
	isa => "Str",
	is  => "ro",
	required => 1,
);

has id => (
	isa => "Undef|Value|ArrayRef|HashRef",
	is  => "ro",
	predicate => "has_id",
);

has params => (
	isa => "Ref",
	is  => "ro",
	required => 1,
);

sub is_service { 0 }

sub is_notification {
	my $self = shift;
	return not $self->has_id;
}

sub params_list {
	my $self = shift;
	my $p = $self->params;

	if ( ref $p eq 'HASH' ) {
		return %$p;
	} elsif ( ref $p eq 'ARRAY' ) {
		return @$p;
	} else {
		return $p; # FIXME error?
	}
}

sub call {
	my ( $self, $invocant, @args ) = @_;

	die "No invocant provided" unless blessed($invocant);

	my $method = $self->method;

	local $@;

	my @res = eval { $invocant->$method( $self->param_list, @args ) };

	if ($@) {
		$self->return_error(message => $@);
	} else {
		$self->return_result(@res);
	}
}

sub return_error {
	my ( $self, @args ) = @_;

	$self->result_response_class->new(
		error => $self->error_response_class->new(@args),
		( $self->has_id ? ( id => $self->id ) : () ),
	);
}

sub return_result {
	my ( $self, @res ) = @_;

	my $res = @res == 1 ? $res[0] : \@res;

	$self->result_response_class->new(
		result => $res,
		( $self->has_id ? ( id => $self->id ) : () ),
	);
}

__PACKAGE__->meta->make_immutable;

__PACKAGE__

__END__

=pod

=head1 NAME

JSON::RPC::Common::Procedure::Call - JSON RPC Procedure Call base class.

=head1 SYNOPSIS

	use JSON::RPC::Common::Procedure::Call;

	my $req = JSON::RPC::Common::Procedure::Call->inflate({ ... });

	warn "HALLO JSONRPC VERSION " . $req->version;

=head1 DESCRIPTION

=head1 ATTRIBUTES

All attributes are read only unless otherwise specified.

=over 4

=item version

=item id

The request ID.

Used to correlate a request to a response.

=item method

The name of the method to invoke.

=item params

Returns a reference to the parameters hash or array.

=item result_response_class

=item error_response_class

The classes to instantiate the response objects.

These vary per subclass.

=back

=head1 METHODS

=over 4

=item inflate

A factory constructor. Delegates to C<new> on a subclass based on the protocol
version.

=item new

The actual constructor.

Not intended for use on this class, use a subclass instead.

=item params_list

Dereferences C<params> regardless of representation.

Returns a list of positionals or a key/value list.

=item is_notification

Whether this request is a notification (a method that does not need a response).

=item is_service

Whether this request is a JSON-RPC 1.1 service method (e.g.
C<system.describe>).

This method is always false for 1.0 and 2.0.

=back

=cut



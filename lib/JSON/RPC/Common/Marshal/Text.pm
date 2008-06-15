#!/usr/bin/perl

package JSON::RPC::Common::Marshal::Text;
use Moose;

use JSON ();
use JSON::RPC::Common::Procedure::Call;
use JSON::RPC::Common::Procedure::Return;

use namespace::clean -except => [qw(meta)];

has json => (
	isa => "Object",
	is  => "rw",
	handles => [qw(encode decode)],
	lazy_build => 1,
);

sub _build_json {
	JSON->new;
}

has call_class => (
	isa => "ClassName",
	is  => "rw",
	default => "JSON::RPC::Common::Procedure::Call",
	handles => { "inflate_call" => "inflate" },
);

has return_class => (
	isa => "ClassName",
	is  => "rw",
	default => "JSON::RPC::Common::Procedure::Return",
	handles => { "inflate_return" => "inflate" },
);

sub call_to_json {
	my ( $self, $call ) = @_;
	$self->encode( $call->deflate );
}

sub return_to_json {
	my ( $self, $ret ) = @_;
	$self->encode( $ret->deflate );
}

sub json_to_call {
	my ( $self, $json ) = @_;
	$self->inflate_call( $self->decode($json) );
}

sub json_to_return {
	my ( $self, $json ) = @_;
	$self->inflate_return( $self->decode($json) );
}

__PACKAGE__->meta->make_immutable();

__PACKAGE__

__END__

=pod

=head1 NAME

JSON::RPC::Common::Marshal::Text - JSON text marshalling for
L<JSON::RPC::Common>.

=head1 SYNOPSIS

	use JSON::RPC::Common::Marshal::Text;

	my $m = JSON::RPC::Common::Marshal::Text->new;

	my $return_obj = $m->json_to_return($json_text);

=head1 DESCRIPTION

This object serializes L<JSON::RPC::Common::Procedure::Call> and
L<JSON::RPC::Common::Procedure::Return> objects into JSON text using the
L<JSON> module.

=head1 ATTRIBUTES

=over 4

=item json

The L<JSON> object to use. A default one will be created if not specified.

=item call_class

=item return_class

The classes to call C<inflate> on.

Defaults to L<JSON::RPC::Common::Procedure::Call> and
L<JSON::RPC::Common::Procedure::Return>.

=back

=head1 METHODS

=over 4

=item call_to_json

=item json_to_call

=item return_to_json

=item json_to_return

These methods do the conversion from objects to json and vice versa.

=back

=cut


#!/usr/bin/perl

package JSON::RPC::Common::Procedure::Call::Version_1_0;
use Moose;

use JSON::RPC::Common::Procedure::Return::Version_1_0;

use namespace::clean -except => [qw(meta)];

extends qw(JSON::RPC::Common::Procedure::Call);

has '+version' => (
	# default => "1.0", # broken, Moose::Meta::Method::Accessor gens numbers if looks_like_number
	default => sub { "1.0" },
);

has '+params' => (
	isa => "ArrayRef",
	required => 1,
);

has '+id' => (
	required => 1,
);

has '+result_response_class' => (
	default => "JSON::RPC::Common::Procedure::Return::Version_1_0",
);

has '+error_response_class' => (
	default => "JSON::RPC::Common::Procedure::Return::Version_1_0::Error",
);

sub is_notification {
	my $self = shift;
	return not defined $self->id;
}

sub deflate_params {
	my $self = shift;
	return ( params => $self->params );
}

sub deflate_id {
	my $self = shift;
	return ( id => $self->id ); # never omitted, can be null instead
}

__PACKAGE__->meta->make_immutable;

__PACKAGE__

__END__

=pod

=head1 NAME

JSON::RPC::Common::Procedure::Call::Version_1_0 - JSON-RPC 1.0 request

=head1 SYNOPSIS

	use JSON::RPC::Common::Procedure::Call;

	my $req = JSON::RPC::Common::Procedure::Call->inflate({
		# 1.0 doesn't specify the version
		id     => "oink",
		params => [ 1 .. 3 ],
	});

=head1 DESCRIPTION

This class implements requests according to the JSON-RPC 1.0 spec:
L<http://json-rpc.org/wiki/specification>.

JSON-RPC 1.0 requests are considered notifications if the C<id> is null.

=cut



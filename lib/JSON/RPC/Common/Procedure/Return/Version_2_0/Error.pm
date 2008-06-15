#!/usr/bin/perl

package JSON::RPC::Common::Procedure::Return::Version_2_0::Error;
use Moose;

use JSON::RPC::Common::TypeConstraints qw(JSONValue);

use namespace::clean -except => [qw(meta)];

extends qw(JSON::RPC::Common::Procedure::Return::Error);

has '+message' => (
	required => 1,
);

has '+code' => (
	required => 1,
);

sub deflate {
	my $self = shift;

	return {
		code    => $self->code,
		message => $self->message,
		( $self->has_data ? ( data => $self->data ) : () ),
	};
}

__PACKAGE__->meta->make_immutable;

__PACKAGE__

__END__

=pod

=head1 NAME

JSON::RPC::Common::Procedure::Return::Version_2_0::Error - JSON-RPC 2.0 error
class.

=head1 SYNOPSIS

	my $return_with_error = $call->return_error("foo");

=head1 DESCRIPTION

This class implements 2.0 error objects.

C<code> and C<message> are mandatory.

See L<JSON::RPC::Common::Procedure::Return::Error>.

=cut



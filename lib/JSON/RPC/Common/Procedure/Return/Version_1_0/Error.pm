#!/usr/bin/perl

package JSON::RPC::Common::Procedure::Return::Version_1_0::Error;
use Moose;
# ABSTRACT: JSON-RPC 1.0 error class.

use JSON::RPC::Common::TypeConstraints qw(JSONDefined);

use namespace::clean -except => [qw(meta)];

extends qw(JSON::RPC::Common::Procedure::Return::Error);

has '+data' => (
	isa => JSONDefined,
);

sub make_data {
	my $self = shift;

	return {
		message => ( $self->has_message ? $self->message : "Unknown error" ),
		code    => $self->code, # might be null
	};
}

sub deflate {
	my $self = shift;

	if ( $self->has_data ) {
		return $self->data;
	} else {
		return $self->make_data;
	}
}

__PACKAGE__->meta->make_immutable();

__PACKAGE__

=pod

=head1 SYNOPSIS

	my $return_with_error = $call->return_error("foo");

=head1 DESCRIPTION

JSON-RPC 1.0 doesn't actually specify what the hell goes in the error field, so
in order to make 1.0+2.0 server implementations easy this class is provided as
a compatibility layer.

Inflating a string instantiates an error with an unset code and the string as
the message.

See L<JSON::RPC::Common::Procedure::Return::Error>

=cut



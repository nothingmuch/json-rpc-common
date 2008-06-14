#!/usr/bin/perl

package JSON::RPC::Common::Procedure::Return::Version_1_1::Error;
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

has name => (
	is      => "rw",
	default => "JSONRPCError", # fucking idiots
);

sub deflate {
	my $self = shift;

	return {
		name    => $self->name,
		message => $self->message,
		code    => $self->code,
		( $self->has_data ? ( error => $self->data ) : () ),
	},
}

__PACKAGE__->meta->make_immutable;

__PACKAGE__

__END__

=pod

=head1 NAME

JSON::RPC::Common::Procedure::Return::Version_1_1::Error - 

=head1 SYNOPSIS

	use JSON::RPC::Common::Procedure::Return::Version_1_1::Error;

=head1 DESCRIPTION

=cut



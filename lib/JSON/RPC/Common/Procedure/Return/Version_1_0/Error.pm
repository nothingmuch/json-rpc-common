#!/usr/bin/perl

package JSON::RPC::Common::Procedure::Return::Version_1_0::Error;
use Moose;

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

__END__

=pod

=head1 NAME

JSON::RPC::Common::Procedure::Return::Version_1_0::Error - 

=head1 SYNOPSIS

	use JSON::RPC::Common::Procedure::Return::Version_1_0::Error;

=head1 DESCRIPTION

=cut



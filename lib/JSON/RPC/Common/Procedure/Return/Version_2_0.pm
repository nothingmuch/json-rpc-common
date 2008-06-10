#!/usr/bin/perl

package JSON::RPC::Common::Procedure::Return::Version_2_0;
use Moose;

use namespace::clean -except => [qw(meta)];

use JSON::RPC::Common::Procedure::Return::Version_2_0::Error ();

extends qw(JSON::RPC::Common::Procedure::Return);

sub deflate {
	my $self = shift;

	return {
		jsonrpc => "2.0",
		( $self->has_error
			? ( error => $self->error )
			: ( result  => $self->result ) ),
		( $self->has_id ? ( id => $self->id ) : () ),
	};
}

__PACKAGE__->meta->make_immutable;

__PACKAGE__

__END__

=pod

=head1 NAME

JSON::RPC::Common::Procedure::Return::Version_2_0 - 

=head1 SYNOPSIS

	use JSON::RPC::Common::Procedure::Return::Version_2_0;

=head1 DESCRIPTION

=cut



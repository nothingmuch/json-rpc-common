#!/usr/bin/perl

package JSON::RPC::Common::Procedure::Return::Version_1_0;
use Moose;

use JSON::RPC::Common::Procedure::Return::Version_1_0::Error;

use namespace::clean -except => [qw(meta)];

extends qw(JSON::RPC::Common::Procedure::Return);

sub deflate {
	my $self = shift;

	return {
		result => ( $self->error ? undef : $self->result ),
		error  => $self->deflate_error, # can be null
		id => $self->id, # can be null
	};
}

__PACKAGE__->meta->make_immutable;

__PACKAGE__

__END__

=pod

=head1 NAME

JSON::RPC::Common::Procedure::Return::Version_1_0 - 

=head1 SYNOPSIS

	use JSON::RPC::Common::Procedure::Return::Version_1_0;

=head1 DESCRIPTION

=cut




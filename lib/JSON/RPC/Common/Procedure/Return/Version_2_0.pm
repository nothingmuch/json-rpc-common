#!/usr/bin/perl

package JSON::RPC::Common::Procedure::Return::Version_2_0;
use Moose;

use JSON::RPC::Common::Procedure::Return::Version_2_0::Error;

use namespace::clean -except => [qw(meta)];

extends qw(JSON::RPC::Common::Procedure::Return);

has '+version' => (
	# default => "2.0", # broken, Moose::Meta::Method::Accessor gens numbers if looks_like_number
	default => sub { "2.0" },
	# init_arg => "jsonrpc", # illegal inherit arg. bah. it's meaningless, so we don't care
);

has '+error_response_class' => (
	default => "JSON::RPC::Common::Procedure::Return::Version_2_0::Error",
);

sub deflate {
	my $self = shift;

	return {
		jsonrpc => "2.0",
		( $self->has_error
			? ( error => $self->deflate_error )
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



#!/usr/bin/perl

package JSON::RPC::Common::Procedure::Return::Version_1_1;
use Moose;

use JSON::RPC::Common::Procedure::Return::Version_1_1::Error;

use namespace::clean -except => [qw(meta)];

extends qw(JSON::RPC::Common::Procedure::Return);

has '+version' => (
	# default => "1.1", # broken, Moose::Meta::Method::Accessor gens numbers if looks_like_number
	default => sub { "1.1" },
);

has '+error_response_class' => (
	default => "JSON::RPC::Common::Procedure::Return::Version_1_1::Error",
);

sub deflate {
	my $self = shift;

	return {
		version => "1.1",
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

JSON::RPC::Common::Procedure::Return::Version_1_1 - 

=head1 SYNOPSIS

	use JSON::RPC::Common::Procedure::Return::Version_1_1;

=head1 DESCRIPTION

=cut




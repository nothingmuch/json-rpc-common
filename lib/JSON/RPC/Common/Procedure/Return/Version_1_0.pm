#!/usr/bin/perl

package JSON::RPC::Common::Procedure::Return::Version_1_0;
use Moose;

use JSON::RPC::Common::Procedure::Return::Version_1_0::Error;

use namespace::clean -except => [qw(meta)];

extends qw(JSON::RPC::Common::Procedure::Return);

has '+version' => (
	# default => "1.0", # broken, Moose::Meta::Method::Accessor gens numbers if looks_like_number
	default => sub { "1.0" },
);

has '+error_response_class' => (
	default => "JSON::RPC::Common::Procedure::Return::Version_1_0::Error",
);

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




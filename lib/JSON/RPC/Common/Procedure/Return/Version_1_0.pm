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

has '+error_class' => (
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

JSON::RPC::Common::Procedure::Return::Version_1_0 - JSON-RPC 1.0 error class.

=head1 SYNOPSIS

	my $return_with_error = $call->return_error("foo");

=head1 DESCRIPTION

See L<JSON::RPC::Common::Procedure::Return::Error>

=cut




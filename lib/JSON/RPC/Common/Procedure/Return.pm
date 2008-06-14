#!/usr/bin/perl

package JSON::RPC::Common::Procedure::Return;
use Moose;

use Carp qw(croak);

use JSON::RPC::Common::TypeConstraints qw(JSONValue);
use JSON::RPC::Common::Procedure::Return::Error;

use namespace::clean -except => [qw(meta)];

with qw(JSON::RPC::Common::Message);

has result => (
	isa => "Any",
	is  => "rw",
	predicate => "has_result",
);

has id => (
	isa => JSONValue,
	is  => "rw",
	predicate => "has_id",
);

has error => (
	isa => "JSON::RPC::Common::Procedure::Return::Error",
	is  => "rw",
	predicate => "has_error",
);

sub deflate {
	my $self = shift;

	my $version = $self->version;

	$version = "undefined" unless defined $version;

	croak "Deflating a procedure return of the class " . ref($self) . " is not supported (version is $version)";
}

sub deflate_error {
	my $self = shift;

	if ( my $error = $self->error ) {
		return $error->deflate;
	} else {
		return undef;
	}
}

__PACKAGE__->meta->make_immutable;

__PACKAGE__

__END__

=pod

=head1 NAME

JSON::RPC::Common::Procedure::Return - 

=head1 SYNOPSIS

	use JSON::RPC::Common::Procedure::Return;

=head1 DESCRIPTION

=cut




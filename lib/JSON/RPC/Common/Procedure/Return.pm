#!/usr/bin/perl

package JSON::RPC::Common::Procedure::Return;
use Moose;

use Carp qw(croak);

use namespace::clean -except => [qw(meta)];

use JSON::RPC::Common::Procedure::Return::Error ();

has result => (
	isa => "Any",
	is  => "ro",
);

has id => (
	isa => "Undef|Value|ArrayRef|HashRef",
	is  => "ro",
	predicate => "has_id",
);

has error => (
	isa => "JSON::RPC::Common::Procedure::Return::Error",
	is  => "ro",
	predicate => "has_error",
);

sub deflate {
	my $self = shift;

	my $version = $self->version;

	croak "Deflating a procedure return of the class " . ref($self) . " is not supported (version is " . ( defined $version ? $version : "undefined" ) . ")";
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




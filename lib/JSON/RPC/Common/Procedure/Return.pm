#!/usr/bin/perl

package JSON::RPC::Common::Procedure::Return;
use Moose;

use namespace::clean -except => [qw(meta)];

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
	isa => "Undef|HashRef",
	is  => "ro",
	predicate => "has_error",
);

sub deflate { die "abstract" }

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




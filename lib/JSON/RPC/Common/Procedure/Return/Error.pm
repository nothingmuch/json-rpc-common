#!/usr/bin/perl

package JSON::RPC::Common::Procedure::Return::Error;
use Moose;

use namespace::clean -except => [qw(meta)];

has message => (
	is => "ro",
	predicate => "has_code",
);

has code => (
	isa => "Int",
	predicate => "has_code",
);

__PACKAGE__->meta->make_immutable();

__PACKAGE__

__END__

=pod

=head1 NAME

JSON::RPC::Common::Procedure::Return::Error - 

=head1 SYNOPSIS

	use JSON::RPC::Common::Procedure::Return::Error;

=head1 DESCRIPTION

=cut



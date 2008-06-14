#!/usr/bin/perl

package JSON::RPC::Common::Procedure::Return::Error;
use Moose;

use JSON::RPC::Common::TypeConstraints qw(JSONValue);

use namespace::clean -except => [qw(meta)];

sub inflate_args {
	my ( $class, @args ) = @_;

	if ( @args % 2 == 1 ) {
		unshift @args, "message";
	}

	my %args = @args;

	my %constructor_args;

	foreach my $arg ( qw(message code) ) {
		$constructor_args{$arg} = delete $args{$arg} if exists $args{$arg};
	}

	$constructor_args{data} = \%args;

	$class->new(%constructor_args);
}

has data => (
	isa => JSONValue,
	is  => "rw",
	predicate => "has_data",
);

has message => (
	isa => "Str",
	is  => "rw",
	predicate => "has_message",
);

has code => (
	isa => "Int",
	is  => "rw",
	predicate => "has_message",
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



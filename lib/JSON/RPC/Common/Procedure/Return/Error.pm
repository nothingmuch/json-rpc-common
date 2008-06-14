#!/usr/bin/perl

package JSON::RPC::Common::Procedure::Return::Error;
use Moose;

use JSON::RPC::Common::TypeConstraints qw(JSONValue);

use namespace::clean -except => [qw(meta)];

sub new_dwim {
	my ( $class, @args ) = @_;

	if ( @args == 1 ) {
		if ( blessed($args[0]) and $args[0]->isa($class) ) {
			return $args[0];
		}
	}

	$class->inflate(@args);
}

sub inflate {
	my ( $class, @args ) = @_;

	my $data;
	if (@args == 1) {
		if (defined $args[0] and (ref($args[0])||'') eq 'HASH') {
			$data = { %{ $args[0] } };
		}
	} else {
		if ( @args % 2 == 1 ) {
			unshift @args, "message";
		}
		$data = { @args };
	}

	my %constructor_args;

	foreach my $arg ( qw(message code) ) {
		$constructor_args{$arg} = delete $data->{$arg} if exists $data->{$arg};
	}

	$constructor_args{data} = (join(" ", keys %$data) eq 'data' ? $data->{data} : $data);

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

# FIXME delegate to a dictionary
sub http_status { 500 }

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



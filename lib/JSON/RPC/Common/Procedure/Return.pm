#!/usr/bin/perl

package JSON::RPC::Common::Procedure::Return;
use Moose;

use Carp qw(croak);

use JSON::RPC::Common::TypeConstraints qw(JSONValue);
use JSON::RPC::Common::Procedure::Return::Error;

use namespace::clean -except => [qw(meta)];

with qw(JSON::RPC::Common::Message);

around new_from_data => sub {
	my $next = shift;
	my ( $class, %args ) = @_;

	if ( exists $args{error} ) {
		$args{error} = $class->inflate_error(delete $args{error}, %args);
	}

	return $class->$next(%args);
};

has version => (
	isa => "Str",
	is  => "rw",
	predicate => "has_version",
);

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

has error_response_class => (
	isa => "ClassName",
	is  => "rw",
	default => "JSON::RPC::Common::Procedure::Return::Error",
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

sub inflate_error {
	my ( $self, $error ) = @_;

	my $error_class = ref $self
		? $self->error_class
		: $self->meta->find_attribute_by_name("error_response_class")->default;

	$error_class->inflate(%$error);
}

sub set_error {
	my ( $self, @args ) = @_;

	$self->error( $self->create_error(@args) );
}

sub create_error {
	my ( $self, @args ) = @_;
	$self->error_response_class->new_dwim(@args);
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




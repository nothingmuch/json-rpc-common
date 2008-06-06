#!/usr/bin/perl

package JSON::RPC::Common::Marshal::HTTP;
use Moose;

use Carp qw(croak);

use URI::QueryParam;

use namespace::clean -except => [qw(meta)];

extends qw(JSON::RPC::Common::Marshal::Text);

has prefer_encoded_get => (
	isa => "Bool",
	is  => "rw",
	default => 1,
);

has expand => (
	isa => "Bool",
	is  => "rw",
	default => 0,
);

has expander => (
	isa => "ClassName|Object",
	lazy_build => 1,
	handles => [qw(expand_hash)],
);

sub _build_expander {
	require CGI::Expand;
	return "CGI::Expand";
}

sub request_to_call {
	my ( $self, $request, @args ) = @_;

	my $req_method = lc( "request_to_call_" . $request->method );

	if ( my $code = $self->can($req_method) ) {
		$self->$code($request, @args);
	} else {
		croak "Unsupported HTTP request method " . $request->method;
	}
}

sub request_to_call_get {
	my ( $self, $request, @args ) = @_;

	my $uri = $request->uri;

	my %rpc;

	my $params = $uri->query_form_hash;

	if ( exists $params->{params} and $self->prefer_encoded_get ) {
		return $self->request_to_call_get_encoded( $request, $params, @args );
	} else {
		return $self->request_to_call_get_query( $request, $params, @args );
	}
}

# the sane way, 1.1-alt
sub request_to_call_get_encoded {
	my ( $self, $request, $params, @args ) = @_;

	# the 'params' URI param is encoded as JSON, inflate it
	my %rpc = %$params;
	$_ = $self->decode($_) for $rpc{params};

	$self->inflate_call(\%rpc);
}

# the less sane but occasionally useful way, 1.1-wd
sub request_to_call_get_query {
	my ( $self, $request, $params, @args  ) = @_;

	my %rpc = ( params => $params );

	foreach my $key (qw(version jsonrpc method id)) {
		if ( exists $params->{$key} ) {
			$rpc{$key} = delete $params->{$key};
		}
	}

	# increases usefulness
	$rpc{params} = $self->process_query_params($params, $request, @args);

	$self->inflate_call(\%rpc);
}

sub process_query_params {
	my ( $self, $params, $request, @args ) = @_;

	if ( $self->expand ) {
		return $self->expand_hash($params);
	} else {
		return $params;
	}
}

sub request_to_call_post {
	my ( $self, $request ) = @_;
	$self->json_to_call( $request->content );
}

__PACKAGE__->meta->make_immutable();

__PACKAGE__

__END__

=pod

=head1 NAME

JSON::RPC::Common::Marshall::HTTP - 

=head1 SYNOPSIS

	use JSON::RPC::Common::Marshall::HTTP;

=head1 DESCRIPTION

=cut



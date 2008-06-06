#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

BEGIN {
	plan skip_all => "HTTP::Request required for this test"  unless eval { require HTTP::Request };
	plan skip_all => "HTTP::Response required for this test" unless eval { require HTTP::Response };
	plan 'no_plan';
}

use ok 'JSON::RPC::Common::Marshal::HTTP';

{
	my $m_http = JSON::RPC::Common::Marshal::HTTP->new;

	my %reqs = (
		"get with params" => HTTP::Request->new( GET =>  '/rpc?version=1.1&method=foo&id=4&oink=3&oink=2&bar=elk' ),
		"encoded get"     => HTTP::Request->new( GET =>  '/rpc?version=1.1&method=foo&id=4&params={"oink":[3,2],"bar":"elk"}' ),
		"post"            => HTTP::Request->new( POST => '/rpc', undef, q|{"version":"1.1","method":"foo","id":4,"params":{"oink":[3,2],"bar":"elk"}}| ),
	);

	foreach my $req ( keys %reqs ) {
		my $req_obj = $reqs{$req};

		ok( my $call = $m_http->request_to_call($req_obj), "$req into proc call" );;

		isa_ok( $call, "JSON::RPC::Common::Procedure::Call" );

		is( $call->version, "1.1", "version" );
		is( $call->method, "foo", "method" );
		is( $call->id, 4, "id" );
		is_deeply( $call->params, { oink => [ 3, 2 ], bar => "elk" }, "params" );
	}
}

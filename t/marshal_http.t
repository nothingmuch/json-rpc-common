#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

BEGIN {
	plan skip_all => "HTTP::Request required for this test"  unless eval { require HTTP::Request };
	plan skip_all => "HTTP::Response required for this test" unless eval { require HTTP::Response };
	plan 'no_plan';
}

use MIME::Base64 qw(encode_base64);

use ok 'JSON::RPC::Common::Marshal::HTTP';

{
	my $m_http = JSON::RPC::Common::Marshal::HTTP->new;

	my %reqs = (
		"get with params" => HTTP::Request->new( GET =>  '/rpc?version=1.1&method=foo&id=4&oink=3&oink=2&bar=elk' ),
		"b64 encoded get" => HTTP::Request->new( GET =>  '/rpc?version=1.1&method=foo&id=4&params=' . encode_base64('{"oink":[3,2],"bar":"elk"}') ),
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

{
	my $m_http = JSON::RPC::Common::Marshal::HTTP->new;

	my $http_res = HTTP::Response->new( 200, "YATTA", undef, '{"jsonrpc":"2.0","result":"cookie","id":3}' );

	my $res_obj = $m_http->response_to_result($http_res);

	is( $res_obj->version, "2.0", "version 2.0");
	ok( !$res_obj->has_error, "no error" );
	is( $res_obj->result, "cookie", "result" );
	is( $res_obj->id, 3, "id" );
}

{
	my $m_http = JSON::RPC::Common::Marshal::HTTP->new;

	my $http_res = HTTP::Response->new( 500, "OH NOES", undef, '{"jsonrpc":"2.0","error":{"message":"bork","code":3,"data":"horses"},"id":5}' );

	my $res_obj = $m_http->response_to_result($http_res);

	is( $res_obj->version, "2.0", "version 2.0");
	ok( !$res_obj->has_result, "no result" );
	is( $res_obj->id, 5, "id" );
	ok( $res_obj->has_error, "has error" );
	my $error = $res_obj->error;
	isa_ok( $error, "JSON::RPC::Common::Procedure::Return::Error" );
	isa_ok( $error, "JSON::RPC::Common::Procedure::Return::Version_2_0::Error" );
	is( $error->code, 3, "error code" );
	is( $error->message, "bork", "error message" );
	is_deeply( $error->data, "horses", "error data" );
}

{
	my $m_http = JSON::RPC::Common::Marshal::HTTP->new;

	my $http_res = HTTP::Response->new( 500, "OH NOES", undef, '{}' );

	my $res_obj = $m_http->response_to_result($http_res);

	ok( !$res_obj->has_result, "no result" );
	ok( !$res_obj->has_id, "no id" );
	ok( $res_obj->has_error, "has error" );
	my $error = $res_obj->error;
	isa_ok( $error, "JSON::RPC::Common::Procedure::Return::Error" );
	is( $error->message, "OH NOES", "error message" );
	is_deeply( $error->data, { response => $http_res }, "error data" );
}

SKIP: {
	plan skip "CGI::Expand is required", 2 unless eval { require CGI::Expand };

	my $m_http = JSON::RPC::Common::Marshal::HTTP->new( expand => 1 );

	my $req = HTTP::Request->new( GET => '/rpc?version=1.1&method=foo&id=4&oink.1=3&oink.0=2&bar.foo=elk' );

	my $call = $m_http->request_to_call( $req );

	isa_ok( $call, "JSON::RPC::Common::Procedure::Call" );

	# note "oink" params are reversed
	is_deeply( $call->params, { oink => [ 2, 3 ], bar => { foo => "elk" } }, "expanded params" );
}

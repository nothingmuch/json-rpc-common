#!/usr/bin/perl

use strict;
use warnings;

use POE;
use POE::Component::Server::HTTP;

use HTTP::Status;

use JSON;
use JSON::RPC::Common::Procedure::Call;

my $aliases = POE::Component::Server::HTTP->new(
	Port => 8000,
	ContentHandler => {
		'/smd' => \&smd,
		'/rpc' => \&json_rpc,
	},
);
sub json_rpc {
	my ($http_request, $http_response) = @_;

	# get the JSON req and deserialize it
	my $json_text = $http_request->content;
	my $json_data = from_json($json_text);

	# decode the request into an object
	my $json_rpc_req = JSON::RPC::Common::Procedure::Call->inflate( $json_data );

	# fake some sort of return value without actually calling anything
	my $json_rpc_res = $json_rpc_req->return_result({
		time => scalar localtime,
		echo => {
			params => [ $json_rpc_req->params_list ],
			method  => $json_rpc_req->method,
		},
	});

	# to invoke the request as a method of some object:
	# my $json_rpc_res = $json_rpc_req->call( $some_object );

	# serialize the response
	my $json_res_data = $json_rpc_res->deflate;
	my $json_res_text = to_json($json_res_data);

	# and write it back to the HTTP client
	$http_response->code(RC_OK);
	$http_response->content($json_res_text);

	return RC_OK;
}

# example SMD interface
# RPC::JSON needs this, but JSON::RPC::Client doesn't
sub smd {
	my ($request, $response) = @_;

	$response->code(RC_OK);

    $response->content(
        to_json {
            SMDVersion  => ".1",
            objectName  => "testClass",
            serviceType => "JSON-RPC",
            serviceURL  => "http://localhost:8000/rpc",
            methods     => [
                {
                    name       => "oink",
                    parameters => [ { name => "foo", type => "STRING" } ]
                }
            ]
        }
    );

	return RC_OK;
}

POE::Kernel->run;


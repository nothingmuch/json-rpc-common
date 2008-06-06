#!/usr/bin/perl

package JSON::RPC::Common;

our $VERSION = "0.01";

__PACKAGE__

__END__

=pod

=head1 NAME

JSON::RPC::Common - Transport agnostic JSON RPC helper objects

=head1 SYNOPSIS

	use JSON::RPC::Common::Procedure::Call;

	my $req = from_json($request_body);

	my $call = JSON::RPC::Common::Procedure::Call->inflate($req);

	warn $call->version;

	my $res = $call->return_result("value");

	print to_json($res->deflate);

=head1 DESCRIPTION

This module provides abstractions for JSON-RPC 1.0, 1.1 (both variations) and
2.0 (formerly 1.2) Procedure Call and Procedure Return objects (formerly known
as request and result), along with errors.

This module does not concern itself with the transport layer at all, so the
JSON-RPC 1.1 and the alternative specification, which are very different on
that level are implemented with the same class.

=cut



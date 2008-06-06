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

=head1 RANT

While JSON-RPC 1.0 and JSON-RPC 2.0 are beautifully simple, the JSON-RPC 1.1
working draft, definitely not. It is much more complex as a protocol, and also
demands a lot more complexity from the responders on the server side.

Unfortunately it appears that JSON-RPC 1.1 is the most popular variant.

Since the client essentially chooses the version of the RPC to be used, for
public APIs I reccomend that all versions be supported, but be aware that a
1.1-WD server "MUST" implement service description in order to be in
compliance.

If you control the client I see absolutely no reason for this, and encourage
you to adhere to 1.0, 1.1-alt or 2.0 instead. It would be much nicer if they
were the de facto standard.

Anyway, enough bitching.

=head1 CLASSES

There are various classes provided by L<JSON::RPC::Common>.

They are designed for high high reusability. All the classes are transport and
representation agnostic except for L<JSON::RPC::Common::Serializer> and
L<JSON::RPC::Common::Serializer::HTTP> which are completely optional.

=head2 L<JSON::RPC::Common::Procedure::Call>

This class and its subclasses implement Procedure Calls (requests) for JSON-RPC
1.0, 1.1WD, 1.1-alt and 2.0.

=head2 L<JSON::RPC::Common::Procedure::Return>

This class and its subclasses implement Procedure Returns (results) for
JSON-RPC 1.0, 1.1WD, 1.1-alt and 2.0.

=head2 L<JSON::RPC::Common::Procedure::Return::Error>

This class and its subclasses implement Procedure Return error objects for
JSON-RPC 1.0, 1.1WD, 1.1-alt and 2.0.

=head1 L<JSON::RPC::Common::Handler>

A generic dispatch table based handler, useful for when you don't want to just
blindly call methods on certain objects.

=head2 L<JSON::RPC::Common::Errors>

This class provides dictionaries of error codes for JSON-RPC 1.1 and
1.1-alt/2.0.

=head2 L<JSON::RPC::Common::Serializer>

A filter object that uses L<JSON> to serialize procedure calls and returns to
JSON text, including JSON-RPC standard error handling for deserialization
failure.

=head2 L<JSON::RPC::Common::Serializer::HTTP>

Similar to L<JSON::RPC::Common::Serializer>, but accepts L<HTTP::Request>
objects and returns L<HTTP::Response> objects. Also knows how to handle
JSON-RPC 1.1 C<GET> encoded requests.

=head1 TODO

=over 4

=item *

An object model for JSON-RPC 1.1 service description

=item *

A

=back

=head1 SEE ALSO

=over 4

=item JSON-RPC 1.0 specification

L<http://json-rpc.org/wiki/specification>

=item JSON-RPC 1.1 working draft

L<http://json-rpc.org/wd/JSON-RPC-1-1-WD-20060807.html>

=item JSON-RPC 1.1 alternative specification proposal

L<http://groups.google.com/group/json-rpc/web/json-rpc-1-1-alt>

=item JSON-RPC 2.0 specification proposal

L<http://groups.google.com/group/json-rpc/web/json-rpc-1-2-proposal>

=item Simplified encoding of JSON-RPC over HTTP

L<http://groups.google.com/group/json-rpc/web/json-rpc-over-http>

=back

=cut



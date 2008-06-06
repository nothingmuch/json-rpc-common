#!/usr/bin/perl

package JSON::RPC::Common::Procedure::Call::Version_2_0;
use Moose;

use JSON::RPC::Common::Procedure::Return::Version_2_0;

use namespace::clean -except => [qw(meta)];

extends qw(JSON::RPC::Common::Procedure::Call);

sub new {
	my ( $self, %data ) = @_;
	$data{version} = delete $data{jsonrpc};
	$self->SUPER::new(%data);
}

has '+params' => (
	isa => "ArrayRef|HashRef",
);

has '+result_response_class' => (
	default => "JSON::RPC::Common::Procedure::Return::Version_2_0",
);

has '+error_response_class' => (
	default => "JSON::RPC::Common::Procedure::Return::Version_2_0::Error",
);

__PACKAGE__->meta->make_immutable;

__PACKAGE__

__END__

=pod

=head1 NAME

JSON::RPC::Common::Procedure::Call::Version_2_0 - JSON-RPC 2.0 Procedure Call

=head1 SYNOPSIS

	use JSON::RPC::Common::Procedure::Call;

	my $req = JSON::RPC::Common::Procedure::Call->inflate({
		jsonrpc => "2.0",
		id      => "oink",
		params  => { foo => "bar" },
	});

=head1 DESCRIPTION

This class implements JSON-RPC Procedure Call objects according to the 2.0
specification proposal:
L<http://groups.google.com/group/json-rpc/web/json-rpc-1-2-proposal>.

JSON RPC 2.0 reinstate notifications, and allow the same format for parameters.

Requests are considered notifications only when the C<id> field is missing, not
when it's null.

=cut


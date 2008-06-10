#!/usr/bin/perl

package JSON::RPC::Common::Procedure::Return::Version_2_0::Error;
use Moose;

use namespace::clean -except => [qw(meta)];

extends qw(JSON::RPC::Common::Procedure::Return::Error);

__PACKAGE__->meta->make_immutable;

__PACKAGE__

__END__

=pod

=head1 NAME

JSON::RPC::Common::Procedure::Return::Version_2_0::Error - 

=head1 SYNOPSIS

	use JSON::RPC::Common::Procedure::Return::Version_2_0::Error;

=head1 DESCRIPTION

=cut



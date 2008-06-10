#!/usr/bin/perl

package JSON::RPC::Common::TypeConstraints;

use strict;
use warnings;

use MooseX::Types -declare => [qw(JSONValue JSONContainer)];

subtype JSONValue, as 'Undef|Value|ArrayRef|HashRef';

subtype JSONContainer, as 'ArrayRef|HashRef';

__PACKAGE__

__END__

=pod

=head1 NAME

JSON::RPC::Common::TypeConstraints - 

=head1 SYNOPSIS

	use JSON::RPC::Common::TypeConstraints;

=head1 DESCRIPTION

=cut



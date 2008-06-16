#!/usr/bin/perl

package JSON::RPC::Common::TypeConstraints;

use strict;
use warnings;

use MooseX::Types -declare => [qw(JSONDefined JSONValue JSONContainer)];

subtype JSONDefined, as "Value|ArrayRef|HashRef";

subtype JSONValue, as 'Undef|Value|ArrayRef|HashRef';

subtype JSONContainer, as 'ArrayRef|HashRef';

__PACKAGE__

__END__

=pod

=head1 NAME

JSON::RPC::Common::TypeConstraints - Type constraint library

=head1 SYNOPSIS

	use JSON::RPC::Common::TypeConstraints qw(JSONValue);

=head1 DESCRIPTION

See L<MooseX::Types>

=head1 TYPES

=over 4

=item JSONDefined

C<Value|ArrayRef|HashRef>

=item JSONValue

C<Undef|Value|ArrayRef|HashRef>

=item JSONContainer

C<ArrayRef|HashRef>

=back

=cut



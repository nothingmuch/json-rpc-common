#!/usr/bin/perl

package JSON::RPC::Common::Message;
use Moose::Role;

requires 'deflate';

sub inflate {
	my ( $class, @args ) = @_;

	my $data;
	if (@args == 1) {
		if (defined $args[0]) {
			no warnings 'uninitialized';
			(ref($args[0]) eq 'HASH')
			|| confess "Single parameters to inflate() must be a HASH ref";
			$data = $args[0];
		}
	}
	else {
		$data = { @args };
	}

	my $subclass = $class->_version_class($data);

	Class::MOP::load_class($subclass);

	$subclass->new_from_data(%$data);
}

sub new_from_data { shift->new(@_) }

sub _get_version {
	my ( $class, $data ) = @_;

	if ( exists $data->{jsonrpc} ) {
		return $data->{jsonrpc}; # presumably 2.0
	} elsif ( exists $data->{version} ) {
		return $data->{version}; # presumably 1.1
	} else {
		return "1.0";
	}
}

sub _version_class {
	my ( $class, $data ) = @_;

	my $version = $class->_get_version($data);

	my @numbers = ( $version =~ /(\d+)/g ) ;

	return join( "::", $class, join("_", Version => @numbers) );
}

__PACKAGE__

__END__

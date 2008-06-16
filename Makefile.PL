#!/usr/bin/perl -w

use strict;

use ExtUtils::MakeMaker;

WriteMakefile(
	NAME         => 'JSON::RPC::Common',
	VERSION_FROM => 'lib/JSON/RPC/Common.pm',
	INSTALLDIRS  => 'site',
	SIGN         => 1,
	PL_FILES     => { },
	PREREQ_PM    => {
		'Test::use::ok' => 0,
		'Test::Exception' => 0,
		'Moose' => '0.48',
		'MooseX::Types' => 0,
		'namespace::clean' => '0.08',
		'JSON' => 0,
		'HTTP::Request' => 0,
		'URI::QueryParam' => 0,
		'MIME::Base64' => 0,
	},
);


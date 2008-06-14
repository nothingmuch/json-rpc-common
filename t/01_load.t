#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';

use ok 'JSON::RPC::Common::Procedure::Call';
use ok 'JSON::RPC::Common::Procedure::Return';
use ok 'JSON::RPC::Common::Procedure::Return::Error';

use ok 'JSON::RPC::Common::TypeConstraints';

use ok 'JSON::RPC::Common::Procedure::Call::Version_1_0';
use ok 'JSON::RPC::Common::Procedure::Return::Version_1_0';
use ok 'JSON::RPC::Common::Procedure::Return::Version_1_0::Error';

use ok 'JSON::RPC::Common::Procedure::Call::Version_1_1';
use ok 'JSON::RPC::Common::Procedure::Return::Version_1_1';
use ok 'JSON::RPC::Common::Procedure::Return::Version_1_1::Error';

use ok 'JSON::RPC::Common::Procedure::Call::Version_2_0';
use ok 'JSON::RPC::Common::Procedure::Return::Version_2_0';
use ok 'JSON::RPC::Common::Procedure::Return::Version_2_0::Error';

use ok 'JSON::RPC::Common::Marshal::Text';
use ok 'JSON::RPC::Common::Marshal::HTTP';

use ok 'JSON::RPC::Common';


use strict;
use warnings;

use Commons::Link;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
my $obj = Commons::Link->new;
isa_ok($obj, 'Commons::Link');

use strict;
use warnings;

use Commons::Link;
use Test::More 'tests' => 5;
use Test::NoWarnings;

# Test.
my $obj = Commons::Link->new;
my $ret = $obj->link('Michal from Czechia.jpg');
is($ret, 'http://upload.wikimedia.org/wikipedia/commons/a/a4/Michal_from_Czechia.jpg',
	'Link defined by image name.');

# Test.
$obj = Commons::Link->new;
$ret = $obj->link('File:Michal from Czechia.jpg');
is($ret, 'http://upload.wikimedia.org/wikipedia/commons/a/a4/Michal_from_Czechia.jpg',
	"Link defined by image name. With prefix 'File:'");

# Test.
$obj = Commons::Link->new;
$ret = $obj->link('Image:Michal from Czechia.jpg');
is($ret, 'http://upload.wikimedia.org/wikipedia/commons/a/a4/Michal_from_Czechia.jpg',
	"Link defined by image name. With prefix 'Image:'");

# Test.
$obj = Commons::Link->new;
$ret = $obj->link('michal from Czechia.jpg');
is($ret, 'http://upload.wikimedia.org/wikipedia/commons/a/a4/Michal_from_Czechia.jpg',
	"Link defined by image name. First character is small.");

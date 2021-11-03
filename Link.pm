package Commons::Link;

use strict;
use warnings;

use Class::Utils qw(set_params);
use File::Spec::Functions qw(catfile);
use Digest::MD5 qw(md5_hex);
use Readonly;
use Unicode::UTF8 qw(decode_utf8 encode_utf8);

Readonly::Scalar our $BASE_URI => q{http://upload.wikimedia.org/wikipedia/commons/};

our $VERSION = 0.01;

sub new {
	my ($class, @params) = @_;

	# Create object.
	my $self = bless {}, $class;

	# UTF-8 mode.
	$self->{'utf-8'} = 1;

	# Process parameters.
	set_params($self, @params);

	return $self;
}

sub link {
	my ($self, $file) = @_;

	$self->_cleanup(\$file);
	
	# Digest characters.
	my ($a, $b) = $self->_compute_ab($file);

	my $url = $BASE_URI.catfile($a, $b, $file);

	return $url;
}

sub _cleanup {
	my ($self, $file_sr) = @_;

	# Rewrite all spaces to '_'.
	${$file_sr} =~ s/ /_/g;

	# Remove 'File:' or 'Image:' prefixes.
	${$file_sr} =~ s/^(File|Image)://ig;

	# Upper case
	${$file_sr} =~ s/^(\w)/uc($1)/e;

	return;
}

sub _compute_ab {
	my ($self, $file) = @_;

	# MD5 only on bytes not utf8 chars.
	my $digest;
	if ($self->{'utf-8'}) {
		my $tmp = encode_utf8($file);
		$digest = lc(md5_hex($tmp));
	} else {
		$digest = lc(md5_hex($file));
	}

	my $a = substr $digest, 0, 1;
	my $b = substr $digest, 0, 2;

	return ($a, $b);
}

1;

__END__


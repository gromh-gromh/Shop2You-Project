# Класс наследник io_cgi с реализацией паттерна одиночка

#!/usr/bin/perl -w
package Utils::EgorovCGI;
use strict;
use warnings;
use lib '.';
require './Utils/io_cgi.pl';


our $singleton = undef;

sub new
{
  my $this = shift;

  return $singleton if defined $singleton;

  $singleton = 'io_cgi'->new($this);

  return $singleton;
}

1;

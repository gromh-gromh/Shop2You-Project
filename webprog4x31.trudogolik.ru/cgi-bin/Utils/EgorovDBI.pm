# Модуль, реализующий паттерн одинчку для объекта обработчика запросов к базе данных

#!/usr/bin/perl -w
package Utils::EgorovDBI;
use strict;
use lib '.';
use DBI;

our $singleton = undef;

sub new
{
  my $this = shift;

  return $singleton if defined $singleton;

  my $self = {_dbh => undef};
  $singleton = bless $self, $this;

  return $singleton;
}

# Функция, устанавливающая подключение к бд
sub connect
{
  my $this = shift;
  
  my $attr = {PrintError => 0, RaiseError => 0};
  my $data_source = "DBI:mysql:webprog4x31_tgbot:localhost";
  my $username = "";
  my $password = "";
  my $dbh = DBI->connect($data_source, $username, $password, $attr);
  $dbh->do('SET NAMES cp1251');
  $this->{_dbh} = $dbh;

  return;
}

# Функция, возвращающая объекта обработчика
sub get_dbh
{
  my $this = shift;
  
  return $this->{_dbh};
}

1;

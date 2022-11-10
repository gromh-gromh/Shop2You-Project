#!/usr/bin/perl -w
use strict;
use warnings;
use DBI;
use Data::Dumper;
use lib './';
use Utils::EgorovDBI;
use Utils::EgorovCGI;

# Основная функция в которой заключена логика работы диспетчера
sub main
{
  eval
  {
    my ($class, $event) = load_cgi();
    my $dbh = open_db();

    eval "require $class";
    my $object = $class->new();
    $object->$event();

    $dbh->disconnect();
  };
  if ($@)
  {
    my $error_text = $@;
    print "Content-Type: text/html\n\n", $error_text;
  }
}

# Открытие подключения к бд
sub open_db
{
  my $dbi = Utils::EgorovDBI->new();
  $dbi->connect();
  my $dbh = $dbi->get_dbh();

  return $dbh;
}

# Выгрузка cgi параметров
sub load_cgi
{
  my $io_cgi = Utils::EgorovCGI->new();
  $io_cgi->get_params();
  my $class = $io_cgi->param('class');
  my $event = $io_cgi->param('event');

  return ($class, $event);
}

main();

# Модуль для работы с информацией про домашние задания

package Model::Homework;
use lib "./";
use Utils::EgorovDBI;
use strict;
use Data::Dumper;

sub new
{
  my $this = shift;
  
  my $self = {};
  bless $self, $this;

  return $self;
}

# Получение информации о домашних заданиях из бд в виде массива хэшей
sub select_table
{
  my $this = shift;

  my $dbi = Utils::EgorovDBI->new();
  my $dbh = $dbi->get_dbh();
  my $sql_request = 'SELECT id, title, deadline, description FROM webprog4x31_homework_id ORDER BY id';
  my $homework_table = $dbh->selectall_arrayref($sql_request, { Slice => {} });

  return $homework_table;
}

# Внесение информации о домашних заданиях в бд
sub insert_homework
{
  my $this = shift;
  my ($title, $deadline, $description) = @_;

  my $dbi = Utils::EgorovDBI->new();
  my $dbh = $dbi->get_dbh();
  my $sql_request = 'INSERT INTO webprog4x31_homework_id SET title=?, deadline=?, description=?';
  $dbh->do($sql_request, undef, ($title, $deadline, $description));

  return;
}

# Удаление информации о домашних заданиях из бд
sub delete_homework
{
  my $this = shift;
  my ($homework_id) = @_;

  my $dbi = Utils::EgorovDBI->new();
  my $dbh = $dbi->get_dbh();
  my $sql_request = 'DELETE FROM webprog4x31_homework_id WHERE id=?';
  $dbh->do($sql_request, undef, ($homework_id));

  return;
}
1;
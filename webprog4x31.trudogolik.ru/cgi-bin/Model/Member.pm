# Модуль для работы с информацией в бд про участников

package Model::Member;
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

# Получение информации об участниках из бд в виде массива хэшей
sub select_table
{
  my $this = shift;
  my ($group_id) = @_;

  my $dbi = Utils::EgorovDBI->new();
  my $dbh = $dbi->get_dbh();
  my $sql_request = 'SELECT id, first_name, last_name, group_id, tag, average_grade FROM webprog4x31_member WHERE group_id=? ORDER BY id';
  my $member_table = $dbh->selectall_arrayref($sql_request, { Slice => {} }, ($group_id));

  return $member_table;
}

# Внесение информации об участнике в бд
sub insert_member
{
  my $this = shift;
  my ($first_name, $last_name, $group_id, $tag) = @_;

  my $dbi = Utils::EgorovDBI->new();
  my $dbh = $dbi->get_dbh();
  my $sql_request = 'INSERT INTO webprog4x31_member SET first_name=?, last_name=?, group_id=?, tag=?, average_grade=0';
  $dbh->do($sql_request, undef, ($first_name, $last_name, $group_id, $tag));

  return;
}

# Удаление информации о выбранной группе из бд
sub delete_member
{
  my $this = shift;
  my ($member_id) = @_;

  my $dbi = Utils::EgorovDBI->new();
  my $dbh = $dbi->get_dbh();
  my $sql_request = 'DELETE FROM webprog4x31_member WHERE id=?';
  $dbh->do($sql_request, undef, ($member_id));

  return;
}
1;
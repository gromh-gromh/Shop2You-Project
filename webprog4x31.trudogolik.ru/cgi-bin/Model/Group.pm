# Модуль для работы с информацией в бд про группы

package Model::Group;
use lib "../";
use Utils::EgorovDBI;
use strict;

sub new
{
  my $this = shift;
  
  my $self = {};
  bless $self, $this;

  return $self;
}

# Получение информации о группах из бд в виде массива хэшей
sub select_table
{
  my $this = shift;

  my $dbi = Utils::EgorovDBI->new();
  my $dbh = $dbi->get_dbh();
  my $sql_request = 'SELECT id, title, admin_id FROM webprog4x31_group ORDER BY id';
  my $group_table = $dbh->selectall_arrayref($sql_request, { Slice => {} });

  return $group_table;
}

# Внесение информации о группе в бд
sub insert_group
{
  my $this = shift;
  my ($title, $admin_id) = @_;

  my $dbi = Utils::EgorovDBI->new();
  my $dbh = $dbi->get_dbh();
  my $sql_request = 'INSERT INTO webprog4x31_group SET title=?, admin_id=?';
  $dbh->do($sql_request, undef, ($title, $admin_id));

  return;
}

# Удаление информации о выбранной группе из бд
sub delete_group
{
  my $this = shift;
  my ($group_id) = @_;

  my $dbi = Utils::EgorovDBI->new();
  my $dbh = $dbi->get_dbh(); 
  my $sql_request = 'DELETE FROM webprog4x31_group WHERE id=?';
  $dbh->do($sql_request, undef, ($group_id));

  return;
}
1;
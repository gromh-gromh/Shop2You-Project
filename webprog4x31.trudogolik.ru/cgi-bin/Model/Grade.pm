# Модуль для работы с информацией в бд про участников

package Model::Grade;
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

# Получение информации об оценке из бд в виде массива хэшей
sub select_table
{
  my $this = shift;
  my ($member_id) = @_;

  my $dbi = Utils::EgorovDBI->new();
  my $dbh = $dbi->get_dbh();
  my $sql_request = 'SELECT id, homework_id, date, grade FROM webprog4x31_grade WHERE member_id=? ORDER BY id';
  my $grade_table = $dbh->selectall_arrayref($sql_request, { Slice => {} }, ($member_id));

  return $grade_table;
}

# Изменеие информации об оценке в бд
sub update_grade
{
  my $this = shift;
  my ($grade_id, $grade) = @_;

  my $dbi = Utils::EgorovDBI->new();
  my $dbh = $dbi->get_dbh();
  my $sql_request = 'UPDATE webprog4x31_grade SET grade=? WHERE id=?';
  $dbh->do($sql_request, undef, ($grade, $grade_id));

  return;
}

1;
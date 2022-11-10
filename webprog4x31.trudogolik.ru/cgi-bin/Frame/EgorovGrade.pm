# Класс для обработки запросов по участникам

#!/usr/bin/perl -w
package Frame::EgorovGrade;
use strict;
use warnings;
use HTML::Template;
use lib './';
use Model::Grade;
use Utils::EgorovCGI;

sub new
{
  my $this = shift;
  
  my $self = {};
  bless $self, $this;

  return $self;
}

# Вывод таблицы с оценками
sub show_list
{
  my $this = shift;
  
  # Получение cgi параметров
  my $cgi = Utils::EgorovCGI->new();
  my $member_id = $cgi->param('member_id');
  my $group_id = $cgi->param('group_id');

  # Получение информации из бд
  my $grade_model = Model::Grade->new();
  my $grade_table = $grade_model->select_table($member_id);

  # Распечатка полученной информации в созданном шаблоне
  my $template = HTML::Template->new(filename => './Templates/grade_template.html');
  $template->param(table_rows => $grade_table);
  $template->param(group_id => $group_id);
  $template->param(member_id => $member_id);
  print "Content-Type: text/html\n\n", $template->output;

  return;
}

# Изменение оценки
sub change
{
  my $this = shift;

  # Получение cgi параметров
  my $cgi = Utils::EgorovCGI->new();
  my $grade_id = $cgi->param('grade_id');
  my $grade = $cgi->param('grade');

  # Внесение информации в бд
  my $grade_model = Model::Grade->new();
  $grade_model->update_grade($grade_id, $grade);

  #Перенаправление на исходную страницу со списком групп
  $this->show_list();

  return;
}
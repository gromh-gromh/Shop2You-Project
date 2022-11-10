# Класс для обработки запросов по участникам

#!/usr/bin/perl -w
package Frame::EgorovMember;
use strict;
use warnings;
use HTML::Template;
use lib './';
use Model::Member;
use Utils::EgorovCGI;
use Data::Dumper;

sub new
{
  my $this = shift;
  
  my $self = {};
  bless $self, $this;

  return $self;
}

# Вывод таблицы с участниками
sub show_list
{
  my $this = shift;
  
  # Получение cgi параметров
  my $cgi = Utils::EgorovCGI->new();
  my $group_id = $cgi->param('group_id');

  # Получение информации из бд
  my $member_model = Model::Member->new();
  my $member_table = $member_model->select_table($group_id);

  # Распечатка полученной информации в созданном шаблоне
  my $template = HTML::Template->new(filename => './Templates/member_template.html');
  $template->param(table_rows => $member_table);
  $template->param(group_id => $group_id);
  print "Content-Type: text/html\n\n", $template->output;

  return;
}

# Добавление участника
sub add
{
  my $this = shift;

  # Получение cgi параметров
  my $cgi = Utils::EgorovCGI->new();
  my $group_id = $cgi->param('group_id');
  my $first_name = $cgi->param('first_name');
  my $last_name = $cgi->param('last_name');
  my $tag = $cgi->param('tag');

  # Внесение информации в бд
  my $member_model = Model::Member->new();
  $member_model->insert_member($first_name, $last_name, $group_id, $tag);

  #Перенаправление на исходную страницу со списком групп
  $this->show_list();

  return;
}

# Удление участника
sub remove
{
  my $this = shift;

  # Получение cgi параметров
  my $cgi = Utils::EgorovCGI->new();
  my $member_id = $cgi->param('member_id');
  my $group_id = $cgi->param('group_id');

  # Запрос к бд на удаление
  my $member_model = Model::Member->new();
  $member_model->delete_member($member_id);

  # Перенаправление на исходную страницу со списком групп
  $this->show_list();
}
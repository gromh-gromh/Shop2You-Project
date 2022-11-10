# Класс для обработки запросов по группам

#!/usr/bin/perl -w
package Frame::EgorovGroup;
use strict;
use warnings;
use HTML::Template;
use lib './';
use Model::Group;
use Utils::EgorovCGI;

sub new
{
  my $this = shift;
  
  my $self = {};
  bless $self, $this;

  return $self;
}

# Вывод таблицы с группами
sub show_list
{
  my $this = shift;

  # Получение информации из бд
  my $group_model = Model::Group->new();
  my $group_table = $group_model->select_table();

  # Распечатка полученной информации в созданном шаблоне
  my $template = HTML::Template->new(filename => './Templates/group_template.html');
  $template->param(TABLE_ROWS => $group_table);
  print "Content-Type: text/html\n\n", $template->output;

  return;
}

# Добавление группы
sub add
{
  my $this = shift;

  # Получение cgi параметров
  my $cgi = Utils::EgorovCGI->new();
  my $title = $cgi->param('title');
  my $admin_id = $cgi->param('admin_id');

  # Внесение информации в бд
  my $group_model = Model::Group->new();
  $group_model->insert_group($title, $admin_id);

  #Перенаправление на исходную страницу со списком групп
  $this->show_list();

  return;
}

# Удаление группы
sub remove
{
  my $this = shift;

  # Получение cgi параметров
  my $cgi = Utils::EgorovCGI->new();
  my $group_id = $cgi->param('group_id');

  # Запрос к бд на удаление
  my $group_model = Model::Group->new();
  $group_model->delete_group($group_id);

  # Перенаправление на исходную страницу со списком групп
  $this->show_list();
}
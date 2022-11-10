# Класс для обработки запросов по домашним заданиям

#!/usr/bin/perl -w
package Frame::EgorovHomework;
use strict;
use warnings;
use HTML::Template;
use lib './';
use Model::Homework;
use Utils::EgorovCGI;
use Data::Dumper;

sub new
{
  my $this = shift;
  
  my $self = {};
  bless $self, $this;

  return $self;
}

# Вывод таблицы с домашними заданиями
sub show_list
{
  my $this = shift;

  # Получение информации из бд
  my $homework_model = Model::Homework->new();
  my $homework_table = $homework_model->select_table();

  # Распечатка полученной информации в созданном шаблоне
  my $template = HTML::Template->new(filename => './Templates/homework_template.html');
  $template->param(table_rows => $homework_table);
  print "Content-Type: text/html\n\n", $template->output;

  return;
}

# Добавление домашнего задания
sub add
{
  my $this = shift;

  # Получение cgi параметров
  my $cgi = Utils::EgorovCGI->new();
  my $title = $cgi->param('title');
  my $deadline = $cgi->param('deadline');
  my $description = $cgi->param('description');

  # Внесение информации в бд
  my $homework_model = Model::Homework->new();
  $homework_model->insert_homework($title, $deadline, $description);

  #Перенаправление на исходную страницу со списком групп
  $this->show_list();

  return;
}

# Удление домашнего задания
sub remove
{
  my $this = shift;

  # Получение cgi параметров
  my $cgi = Utils::EgorovCGI->new();
  my $homework_id = $cgi->param('homework_id');

  # Запрос к бд на удаление
  my $homework_model = Model::Homework->new();
  $homework_model->delete_homework($homework_id);

  # Перенаправление на исходную страницу со списком групп
  $this->show_list();

  return;
}

1;

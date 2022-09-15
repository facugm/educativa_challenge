#!/usr/local/bin/perl
use strict;
use warnings;
use DBI;
use LWP::UserAgent ();
use JSON;

my $dbh = DBI->connect( "DBI:mysql:edu_challenge_db", 'edu_challenge_user', '3duc4');

my $stmt = $dbh->prepare("SELECT u.id_usuario, c.id_curso, u.nombre, u.apellido, c.nombre
							FROM usuarios_cursos uc
							INNER JOIN usuarios u ON u.id_usuario = uc.id_alumno
							INNER JOIN cursos c ON c.id_curso = uc.id_curso
							ORDER BY u.id_usuario, c.id_curso"
    );
my $id_alumno_ingresado = shift @ARGV;
my $id_curso_ingresado = shift @ARGV;

my @profesores = $dbh->selectall_array("SELECT c.id_docente, c.id_curso FROM cursos c;");

my $i=0;
foreach (@profesores) {
	if (@$_[0] == $id_alumno_ingresado and @$_[1] == $id_curso_ingresado) {print "La persona a ingresar es el docente del curso seleccionado"};
}
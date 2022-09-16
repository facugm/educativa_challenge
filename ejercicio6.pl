#!/usr/local/bin/perl
use strict;
use warnings;
use DBI;
use LWP::UserAgent ();
use JSON;

my $dbh = DBI->connect( "DBI:mysql:edu_challenge_db", 'edu_challenge_user', '3duc4');
$dbh->{RaiseError} = 1;

my $id_alumno_ingresado = shift @ARGV;
my $id_curso_ingresado = shift @ARGV;

my $flag = 1;

my $repetido = $dbh->prepare("SELECT id_alumno FROM usuarios_cursos WHERE id_curso = ?");
$repetido->execute($id_curso_ingresado);
my $cur;
$repetido->bind_col(1,\$cur);
while ( $repetido->fetch ) {
	if($cur == $id_alumno_ingresado) { print "Usuario ya inscripto\n"; $flag = 0;}
}

my @profesores = $dbh->selectall_array("SELECT c.id_docente, c.id_curso FROM cursos c;");
foreach (@profesores) {
	if (@$_[0] == $id_alumno_ingresado and @$_[1] == $id_curso_ingresado) {print "La persona a ingresar es el docente del curso seleccionado\n"; $flag = 0;}
}

my $cupo_disp = $dbh->prepare("SELECT COUNT(uc.id_alumno), c.cupo FROM usuarios_cursos uc INNER JOIN cursos c ON uc.id_curso = c.id_curso WHERE uc.id_curso = ?");
$cupo_disp->execute($id_curso_ingresado);
my @cupos = $cupo_disp->fetchrow_array;
if ($cupos[0] == $cupos[1]) {print "Curso lleno\n"; $flag = 0;}


if($flag) {
my $cargar_alumno = $dbh->prepare("INSERT INTO usuarios_cursos(id_curso,id_alumno) VALUES(?,?)");
$cargar_alumno->execute($id_curso_ingresado,$id_alumno_ingresado);
print "Alumno $id_alumno_ingresado cargado al curso $id_curso_ingresado correctamente\n";
}


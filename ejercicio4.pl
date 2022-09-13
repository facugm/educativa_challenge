#!/usr/local/bin/perl
use strict;
use warnings;
use DBI;

# Me conecto a la DB creada x consola
my %attr = (PrintError=>0, RaiseError=>1);
my $dbh = DBI->connect("DBI:mysql:edu_challenge_db",'edu_challenge_user','3duc4', \%attr);
# Guardo la query a ejecutar en un array
my @query = ("CREATE TABLE IF NOT EXISTS usuarios (
                id_usuario INT UNSIGNED NOT NULL PRIMARY KEY,
                nombre VARCHAR(255) NOT NULL,
                apellido VARCHAR(255) NOT NULL
                )",
            "CREATE TABLE IF NOT EXISTS cursos (
                id_curso INT UNSIGNED NOT NULL PRIMARY KEY,
                nombre VARCHAR(255) NOT NULL,
                cupo INT UNSIGNED NOT NULL,
                id_docente INT UNSIGNED NOT NULL
                )",
            "CREATE TABLE IF NOT EXISTS usuarios_cursos (
                id_curso INT UNSIGNED NOT NULL,
                id_alumno INT UNSIGNED NOT NULL,
                CONSTRAINT fk_curso FOREIGN KEY (id_curso) REFERENCES cursos (id_curso),
                CONSTRAINT fk_alumno FOREIGN KEY (id_alumno) REFERENCES usuarios (id_usuario)
            )");
# Ejecuto cada una de las querys
foreach my $sql(@query) {
    $dbh->do($sql);
}
print "Todas las tablas fueron creadas correctamente.\n";
# Cierro la conexion con la DB
$dbh->disconnect();
#!/usr/local/bin/perl
use strict;
use warnings;
use DBI;
use LWP::UserAgent ();
use JSON;

my $dbh = DBI->connect( "DBI:mysql:edu_challenge_db", 'edu_challenge_user', '3duc4', \%attr );
my $stmt = $dbh->prepare(
    "INSERT IGNORE INTO u.id_usuario, c.id_curso, u.nombre, u.apellido, c.nombre
							FROM usuarios_cursos uc
							INNER JOIN usuarios u ON u.id_usuario = uc.id_alumno
							INNER JOIN cursos c ON c.id_curso = uc.id_curso
							ORDER BY u.id_usuario, c.id_curso"
    );
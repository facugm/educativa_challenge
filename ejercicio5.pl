#!/usr/local/bin/perl
use strict;
use warnings;
use DBI;
use LWP::UserAgent ();
use JSON;

my %attr = (PrintError=>0, RaiseError=>1);
my $dbh = DBI->connect("DBI:mysql:edu_challenge_db",'edu_challenge_user','3duc4', \%attr);

my $ua1 = LWP::UserAgent->new();
my $ua2 = LWP::UserAgent->new();

$ua1->env_proxy;
$ua2->env_proxy;

my $response1 = $ua1->get('http://packages.educativa.com/samples/usuarios.json');
my $ref1 = decode_json($response1->decoded_content);
 
my $response2 = $ua2->get('http://packages.educativa.com/samples/cursos.json');
my $ref2 = decode_json($response2->decoded_content);

my $inicializacion = "DELETE FROM usuarios_cursos";
my $sql = "INSERT IGNORE INTO usuarios(id_usuario,nombre,apellido)
	   VALUES(?,?,?)";
my $sql2 = "REPLACE INTO usuarios_cursos(id_curso,id_alumno)
		VALUES(?,?)";
my $stmt = $dbh->prepare($inicializacion);
$stmt->execute();
$stmt = $dbh->prepare($sql);
my $stmt2= $dbh->prepare($sql2);
my @users = @{$ref1->{usuarios}};
my $i=0;
while ($i < scalar @users){
    $stmt->execute("$users[$i]->{id}","$users[$i]->{nombre}", "$users[$i]->{apellido}");
	foreach (@{$users[$i]->{id_curso}}) {
       $stmt2->execute("$_","$users[$i]->{id}");
    }
    $i++;
}

my @cursos = @{$ref2->{cursos}};
my $j=0;
$sql = "INSERT IGNORE INTO cursos(id_curso,nombre,cupo,id_docente)
	   VALUES(?,?,?,?)";
$stmt = $dbh->prepare($sql);
while ($j < scalar @cursos) {
	$stmt->execute("$cursos[$j]->{id}","$cursos[$j]->{nombre}", "$cursos[$j]->{cupo}","$cursos[$j]->{id_docente}");
	$j++;
}

$stmt->finish();
$dbh->disconnect();

# query de seleccion. Falta integrarlo a perl con bind_col
# SELECT c.nombre, c.cupo, c.id_docente, u.nombre, u.apellido
# FROM usuarios_cursos uc
# INNER JOIN usuarios u ON u.id_usuario = uc.id_alumno
# INNER JOIN cursos c ON c.id_curso = uc.id_curso
# ORDER BY u.id_usuario, c.id_curso;
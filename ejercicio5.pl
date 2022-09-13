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

my $sql = "INSERT INTO usuarios(id_usuario,nombre,apellido)
	   VALUES(?,?,?)";
my $stmt = $dbh->prepare($sql);
if ($stmt->execute('00',"Prueba","TEST")) { print "Datos ingresados correctamente";}
else {print "No se pudieron ingresar los datos"};
$stmt->finish();
$dbh->disconnect();
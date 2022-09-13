#!/usr/local/bin/perl
use strict;
use warnings;
use LWP::UserAgent ();
use JSON;

my $ua1 = LWP::UserAgent->new();
my $ua2 = LWP::UserAgent->new();

$ua1->env_proxy;
$ua2->env_proxy;
 # Traigo el JSON de los endpoints y guardo las referencias a ellos en otras variables
my $response1 = $ua1->get('http://packages.educativa.com/samples/usuarios.json');
my $ref1 = decode_json($response1->decoded_content);
 
my $response2 = $ua2->get('http://packages.educativa.com/samples/cursos.json');
my $ref2 = decode_json($response2->decoded_content);
# Creo array de usuarios a partir de la referencia obtenida
my @users = @{$ref1->{usuarios}};
my $i=0;
print "ALUMNOS:\nId\tNombre\tApellido Id_Cursos\n";
# Imprimo valores de cada hash almacenados en cada una de las posiciciones del array users
while ($i < scalar @users){
    print "$users[$i]->{id}\t$users[$i]->{nombre}\t$users[$i]->{apellido} "."@{$users[$i]->{id_curso}}\n";
    $i++;
}
# Idem pero con la referencia de los cursos obtenida del 2do endpoint
my @cursos = @{$ref2->{cursos}};
my $j=0;
print "\nCURSOS:\nId\tNombre\tId_docente\tCupos\n";
while ($j < scalar @cursos) {
    print "$cursos[$j]->{id}\t$cursos[$j]->{nombre}\t$cursos[$j]->{id_docente}\t$cursos[$j]->{cupo}\n";
    $j++;
}

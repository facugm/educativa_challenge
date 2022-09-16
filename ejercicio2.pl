#!/usr/local/bin/perl
use strict;
use warnings;

my %d_nombres;
my $index  = 1;
my @nombre = (
    "Jacinta Flores",
    "Juan Carlos Feletti",
    "Pedro Lugones",
    "Ana Maria Galindez",
    "Juana Bermudez",
    "Rafael Ernesto Brahms",
    "Beatriz Valente",
    "Ulma Fabiana Goya",
    "Martina Nicolesi",
    "Betania Miraflores",
    "Fermin Olivetti",
    "Ana Luz Narosky",
    "Graciana Arruabarrena",
    "Joel Perez",
    "Valentina Feller",
    "Hector Tadeo Siemens",
    "Natalia Martinevsky",
    "Ernesto Nicolini",
    "Pia Paez",
    "Fermin Obdulio Camilo Galindez",
    "Delfina Beirut",
    "Walter Mantinoli",
    "Celina Celia Samid",
    "Ulises Malo",
    "Juana Varela",
    "Melquiades Jose Li",
    "Radamel Servini",
    "Filemon Salsatti",
    "Celeste Faim",
    "Valerio Martin Rosseti",
    "Jeremias Farabutti",
    "Veronica Nefertiti",
    "Ana Delia Pereyra",
    "Hermenilda Carla Rutini",
    "Valerio Tunuyan",
    "Silvia Solano",
    "Beatriz Bevacqua",
    "Manuel Martinez",
    "Berto Carlos Kigali",
    "Juan Manuel Miraflores",
    "Nicolas Kligorsky",
    "Maria Laura Berotti"
);

# Popeo el apellido y lo concateno al mismo nombre junto a una coma
foreach my $i (@nombre) {
    my @temp = split( " ", $i );
    $i = ( pop @temp ) . ", " . join " ", @temp;
}

# Ordeno los nombres alfabeticamente
@nombre = sort (@nombre);

# Genero un diccionario de claves numericas ascendentes con los nombres
foreach my $i (@nombre) {
    $d_nombres{$index} = $i;
    print "$index => $d_nombres{$index}\n";
    $index++;
}

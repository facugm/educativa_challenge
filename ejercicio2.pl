#!/usr/local/bin/perl
use strict;
use warnings;
my %d_nombres;
my $index = 1;
my @nombre = ("Jacinta Flores", "Juan Carlos Feletti", "Pedro Lugones", "Ana Maria Galindez");
# Popeo el apellido y lo concateno al mismo nombre junto a una coma
foreach my $i (@nombre) {
my @temp = split (" ",$i);
$i= (pop @temp).", ".join " ", @temp;
}
# Ordeno los nombres alfabeticamente
@nombre = sort (@nombre);
# Genero un diccionario de claves numericas ascendentes con los nombres
foreach my $i (@nombre) {
$d_nombres{$index}=$i;
print "$index => $d_nombres{$index}\n";
$index ++;
}
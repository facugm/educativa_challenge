#!/usr/local/bin/perl
use strict;
use warnings;

my @prueba;
$prueba[0] = "hola";
$prueba[0] = $prueba[0]." mundo";
# if($prueba[0] !~ m/(\w+)\s+(\w+)\s+(\w+)/) {
#	print "nopibe";
# }
my @nombre;
$nombre[0] = "Facundo García Mata";
my @aver = split (" ",$nombre[0]);
my @quep = pop @aver;
unshift @aver, ",";
unshift @aver, (pop @quep);
print @aver;
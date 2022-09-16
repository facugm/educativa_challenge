#!/usr/local/bin/perl
use strict;
use warnings;

my $cadena =
'Jacinta_Flores$Juan_Carlos_Feletti$Pedro_Lugones$Ana_Maria_Galindez$Juana_Bermudez$Rafael_Ernesto_Brahms$Beatriz_Valente$Ulma_Fabiana_Goya$Martina_Nicolesi$Betania_Miraflores$Fermin_Olivetti$Ana_Luz_Narosky$Graciana_Arruabarrena$Joel_Perez$Valentina_Feller$Hector_Tadeo_Siemens$Natalia_Martinevsky$Ernesto_Nicolini$Pia_Paez$Fermin_Obdulio_Camilo_Galindez$Delfina_Beirut$Walter_Mantinoli$Celina_Celia_Samid$Ulises_Malo$Juana_Varela$Melquiades_Jose_Li$Radamel_Servini$Filemon_Salsatti$Celeste_Faim$Valerio_Martin_Rosseti$Jeremias_Farabutti$Veronica_Nefertiti$Ana_Delia_Pereyra$Hermenilda_Carla_Rutini$Valerio_Tunuyan$Silvia_Solano$Beatriz_Bevacqua$Manuel_Martinez$Berto_Carlos_Kigali$Juan_Manuel_Miraflores$Nicolas_Kligorsky$Maria_Laura_Berotti';

# Reemplaza los '_' por ' ' dentro del mismo string
$cadena =~ tr/'_'/' '/;

# Reemplaza los '$' por '&' dentro del mismo string
$cadena =~ tr/$/&/;

# "Corta" el string en cada & y mete esa cadena en el array nombres
my @nombres = split( '&', $cadena );

# Muestra en pantalla el array nombres
foreach my $i (@nombres) {
    print "$i\n";
}

#!/usr/local/bin/perl
use strict;
use warnings;
use LWP::UserAgent ();
use JSON;
use Data::Dumper;

my $ua = LWP::UserAgent->new();
$ua->env_proxy;
 
my $response = $ua->get('http://packages.educativa.com/samples/usuarios.json');
my $ref = decode_json($response->decoded_content);
my @users = @{$ref->{usuarios}};
my %prueba = %{$users[0]};
print %prueba;
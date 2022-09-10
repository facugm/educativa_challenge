#!/usr/local/bin/perl
use strict;
use warnings;
use LWP::UserAgent ();
 
my $ua = LWP::UserAgent->new(timeout => 10);
$ua->env_proxy;
 
my $response = $ua->get('http://packages.educativa.com/samples/usuarios.json');
 
if ($response->is_success) {
    print $response->decoded_content;
}
else {
    die $response->status_line;
}
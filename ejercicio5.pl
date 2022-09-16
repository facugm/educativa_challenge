#!/usr/local/bin/perl
use strict;
use warnings;
use DBI;
use LWP::UserAgent ();
use JSON;

# Conexion a DB y endpoints
my $dbh = DBI->connect( "DBI:mysql:edu_challenge_db", 'edu_challenge_user', '3duc4');
my $ua1 = LWP::UserAgent->new();
my $ua2 = LWP::UserAgent->new();
$ua1->env_proxy;
$ua2->env_proxy;
my $response1 =  $ua1->get('http://packages.educativa.com/samples/usuarios.json');
my $ref1      = decode_json( $response1->decoded_content );
my $response2 = $ua2->get('http://packages.educativa.com/samples/cursos.json');
my $ref2      = decode_json( $response2->decoded_content );

# Borro los datos de la tabla usuarios_cursos para evitar que se dupliquen cada vez que se corre este script
inicializar($dbh);

# Preparo las querys a ejecutar
my $stmt = $dbh->prepare(
    "INSERT IGNORE INTO usuarios(id_usuario,nombre,apellido)
						VALUES(?,?,?)"
);
my $stmt2 = $dbh->prepare(
    "REPLACE INTO usuarios_cursos(id_curso,id_alumno)
						VALUES(?,?)"
);

# Preparo datos del endpoint a insertar
my @users = @{ $ref1->{usuarios} };
my $i     = 0;

# En cada posicion ejecuta la primer query con los datos del JSON usuarios
while ( $i < scalar @users ) {
    $stmt->execute( "$users[$i]->{id}", "$users[$i]->{nombre}",
        "$users[$i]->{apellido}" );
    foreach ( @{ $users[$i]->{id_curso} } ) {
        $stmt2->execute( "$_", "$users[$i]->{id}" );
    }
    $i++;
}

# Preparo datos del 2do endpoint a insertar
my @cursos = @{ $ref2->{cursos} };
my $j      = 0;

# Preparo query
$stmt = $dbh->prepare(
    "INSERT IGNORE INTO cursos(id_curso,nombre,cupo,id_docente)
	   				VALUES(?,?,?,?)"
);

# En cada posicion ejecuta la primer query con los datos del JSON cursos
while ( $j < scalar @cursos ) {
    $stmt->execute(
        "$cursos[$j]->{id}",   "$cursos[$j]->{nombre}",
        "$cursos[$j]->{cupo}", "$cursos[$j]->{id_docente}"
    );
    $j++;
}

# Imprimo datos en pantalla
imprimir($dbh);

$stmt->finish();
$dbh->disconnect();

sub inicializar {
    my $db             = shift @_;
    my $inicializacion = "DELETE FROM usuarios_cursos";
    my $stmt           = $db->prepare($inicializacion);
    $stmt->execute();
}

sub imprimir {
    my $db = shift @_;
    my ( $id_usuario, $id_curso, $user_nombre, $user_apellido, $curso_nombre );

    my $stmt = $db->prepare(
        "SELECT u.id_usuario, c.id_curso, u.nombre, u.apellido, c.nombre
							FROM usuarios_cursos uc
							INNER JOIN usuarios u ON u.id_usuario = uc.id_alumno
							INNER JOIN cursos c ON c.id_curso = uc.id_curso
							ORDER BY u.id_usuario, c.id_curso"
    );
    $stmt->execute();

    $stmt->bind_columns(\$id_usuario,\$id_curso,\$user_nombre,\$user_apellido,\$curso_nombre);
    print "id_user | id_curso | nombre y apellido usuario  | nombre curso  |\n";
    while ( $stmt->fetch ) {
        print "$id_usuario\t| $id_curso        | $user_nombre $user_apellido \t\t| $curso_nombre\t|\n";
    }
}

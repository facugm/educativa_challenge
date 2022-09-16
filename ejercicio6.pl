#!/usr/local/bin/perl
use strict;
use warnings;
use DBI;
use LWP::UserAgent ();
use JSON;
use Switch;

my $dbh =
  DBI->connect( "DBI:mysql:edu_challenge_db", 'edu_challenge_user', '3duc4' );
$dbh->{RaiseError} = 1;

my $opcion              = shift @ARGV;
my $id_alumno_ingresado = shift @ARGV;
my $id_curso_ingresado  = shift @ARGV;

switch ($opcion) {
    case 1 { imprimir($dbh); }
    case 2 { ingresar( $dbh, $id_alumno_ingresado, $id_curso_ingresado ); }
    case 3 { borrar( $dbh, $id_alumno_ingresado, $id_curso_ingresado ); }
    else {
        print
"Debe indicar una de las siguientes opciones:\n1) Mostrar lista de inscripciones\n2) Inscribir usuario (indicando id de alumno y luego de curso)\n3) Eliminar inscripción (indicando id de alumno y luego de curso)\n";
    }
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

    $stmt->bind_columns(
        \$id_usuario,    \$id_curso, \$user_nombre,
        \$user_apellido, \$curso_nombre
    );
    print "id_user | id_curso | nombre y apellido usuario  | nombre curso  |\n";
    while ( $stmt->fetch ) {
        print
"$id_usuario\t| $id_curso        | $user_nombre $user_apellido \t\t| $curso_nombre\t|\n";
    }
}

sub ingresar {
    my $flag  = 1;
    my $db    = shift @_;
    my $alum  = shift @_;
    my $curso = shift @_;

# Traigo lista de alumnos inscriptos al curso y chequeo si ya está inscripto en él
    my $repetido =
      $db->prepare("SELECT id_alumno FROM usuarios_cursos WHERE id_curso = ?");
    $repetido->execute($curso);
    my $cur;
    $repetido->bind_col( 1, \$cur );
    while ( $repetido->fetch ) {
        if ( $cur == $alum ) { print "Usuario ya inscripto\n"; $flag = 0; }
    }

# Traigo lista de profesores y chequeo que alumno a inscribir no sea el docente del curso deseado
    my @profesores =
      $db->selectall_array("SELECT c.id_docente, c.id_curso FROM cursos c;");
    foreach (@profesores) {
        if ( @$_[0] == $alum and @$_[1] == $curso ) {
            print
              "La persona a ingresar es el docente del curso seleccionado\n";
            $flag = 0;
        }
    }

# Traigo conteo de gente inscripta y nro de cupo del curso a inscribir y comparo si son iguales
    my $cupo_disp = $db->prepare(
"SELECT COUNT(uc.id_alumno), c.cupo FROM usuarios_cursos uc INNER JOIN cursos c ON uc.id_curso = c.id_curso WHERE uc.id_curso = ?"
    );
    $cupo_disp->execute($curso);
    my @cupos = $cupo_disp->fetchrow_array;
    if ( $cupos[0] == $cupos[1] ) { print "Curso lleno\n"; $flag = 0; }

# Si todas las condiciones anteriores se cumplen, el usuario es inscripto en el curso deseado
    if ($flag) {
        my $cargar_alumno = $db->prepare(
            "INSERT INTO usuarios_cursos(id_curso,id_alumno) VALUES(?,?)");
        $cargar_alumno->execute( $curso, $alum );
        print "Alumno $alum cargado al curso $curso correctamente\n";
    }
}

sub borrar {
    my $db    = shift @_;
    my $alum  = shift @_;
    my $curso = shift @_;

    my $eliminar = $db->prepare(
        "DELETE FROM usuarios_cursos WHERE id_curso = ? AND id_alumno = ?");

    # Si no se borró nada, notifica al usuario
    if ( $eliminar->execute( $curso, $alum ) != 0E0 ) {
        print "Alumno $alum eliminado del curso $curso\n";
    }
    else {
        print
"ERROR: Imposible de borrar. Alumno $alum no está inscripto en el curso $curso\n";
    }
}

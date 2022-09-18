# García Mata Facundo - Educativa: Entrevistas Área Tecnología

En este repositorio se encuentra el código fuente correspondiente a cada uno de los ejercicios del [challenge](./challenge.pdf).
A continuación se detallan las dependencias necesarias y las instrucciones para ejecutarlos.

## Instalaciones

**Primero y principal:**
```sh
sudo apt-get install perl
sudo apt-get install mysql-server
```
Luego, para instalar los módulos de Perl más fácilmente:
```sh
sudo cpan App::cpanminus
```
Módulos:
```sh
sudo cpanm LWP
sudo cpanm JSON
sudo cpanm DBI
sudo apt-get install libmysqlclient-dev; sudo cpan -f DBD::mysql
sudo cpanm Switch
```

## Ejecución
<font size="3"> **Los siguientes códigos deben ejecutarse en consola** </font> 
### Ejercicio 1
```sh
perl ejercicio1.pl
```
### Ejercicio 2
```sh
perl ejercicio2.pl
```
### Ejercicio 3
```sh
perl ejercicio3.pl
```
### Ejercicio 4
Tal como se detalla en el [instructivo](./challenge.pdf), primero se debe crear una base de datos en MySQL llamada "edu_challenge_db"
```sh
sudo mysql -u root # Puede ser necesario según distro de Linux
CREATE DATABASE edu_challenge_db CHARACTER SET utf8;
CREATE USER 'edu_challenge_user'@'localhost' IDENTIFIED BY '3duc4';
GRANT ALL PRIVILEGES ON edu_challenge_db.* TO 'edu_challenge_user'@'localhost';
```
Y recién ahí ejectuar:
```sh
perl ejercicio4.pl
```
### Ejercicio 5
Tener en cuenta que por cada vez que se ejecuta este archivo la tabla "usuarios_cursos" es eliminada y vuelta a crear para evitar duplicados
```sh
perl ejercicio5.pl
```
### Ejercicio 6
Las opciones del menú se despliegan al ejecutar:
```sh
perl ejercicio6.pl
```

# Apuntes Sublenguajes SQL - DQL

 - [Introducción a SQL](#introducción-a-sql)
 
 - [Conceptos Importantes](#conceptos-importantes)
 
 - [Utilidades Varias](#utilidades-varias) 
 
 - [Ejemplos Consultas Complejas](#ejemplos-consultas-complejas)

***
***

Solo hay 1 lenguaje SQL. Sin embargo, hay 6 sublenguajes.

## Sublenguajes:

### DQL (Data Query Language):  
      
Opera sobre los datos de la BD, no sobre los objetos

> Comandos:
		
	SELECT (Antes estaba en el DML)

### DML (Data Manipulation Language):

Opera sobre los datos de la BD, no sobre los objetos

> Comandos:

	INSERT
	UPDATE
	DELETE

### DDL (Data Definition Language):

Opera sobre los objetos de la BD, como tablas, filas, columnas, etc.

> Comandos:
		
	CREATE
	ALTER
	DROP

### TCL (Transaction Control Language):

> Comandos:

	COMMIT
	ROLLBACK

### DCL (Data Control Language):

> Comandos:
		
	GRANT
	REVOKE

### SCL (Session Control Language):

> Comandos:
		
	ALTER SESSION 

***
***
***

# ---> PARTE SUCIA <---

DDL:

- CREATE: 

	Bases de Datos (CREATE DATABASE myDB | CREATE SCHEMA myOtherDB)
       		     Se diferencian por los permisos al momento de crearla

		Ej: CREATE (DATABASE | SCHEMA) [IF NOT EXISTS] <nomBD> [CHARACTER SET <nomeDoCharset>]

	Tablas (CREATE TABLE tabName)

		https://www.postgresql.org/docs/8.4/ddl-constraints.html#DDL-CONSTRAINTS-FK --> DOCUMENTAR PK Y FK
		
		Opciones para ON DELETE:

		NO ACTION: no realiza ninguna accion sobre los datos. Se mantienen

		CASCADE: los datos se borran

		SET NULL: se pone a nulo ¿?

		SET DEFAULT: cuando desaparece se asignan los datos a un sitio ficticio pero que existe

	    - MATCH FULL: todos los campos, tanto de la tabla  con la clave principal como de la tabla con la clave foranea no pueden estar a null

	     - MATCH PARCIAL: permite tener uno de los campos de la tabla a null

	Usuarios


- Restricciones:

	CONSTRAINT ---> Tipos de restricciones

		- PRIMARY KEY:

		- FOREIGN KEY:
	
		- UNIQUE (atributo): permite que todos los valores sean diferentes

		- CHECK predicado (atributo): realizar comprobaciones

			opciones posibles a mayores (not deferrable es el valor predeterminado):

				- NOT DEFERRABLE: comprueba en el momento en el que se intenta hacer la accion

				- DEFERRABLE INITIALLY DEFFERRABLE: comprueba al final


- DROP:

	Bases de Datos: DROP SCHEMA [IF EXISTS] myBD

	Tabla: DROP TABLE [IF EXISTS] nomTabla [CASCADE (borra las tablas hijas) | RESTRICT (no puedes borrar la tabla porque tiene tablas hijas relacionadas con la tabla que se intenta borrar)]


- ALTER:

	ALTER TABLE nomTabla

		ADD [COLUMN] <atributo> valor

		DROP COLUMN <atributo> [CASCADE | RESTRICT]

		ADD <restriccion> ---> CONSTRAINT anteriores

		DROP <restriccion>
       		    

DML:


- INSERT: 

	INSERT INTO nombre_tabla [(atributo1, atributo2, ...)] VALUES (valor1, valor2, ...) | SELECT ... {tiene que tener: el mismo numero de columnas y mismo orden a la hora de seleccionarlas; mismo dominios (tipos de datos: integer, etc.); }



- UPDATE:

	UPDATE nombre_tabla SET atributo1 = valor1, atributo2 = valor2, ... [WHERE <predicado>]



- DELETE:

	DELETE FROM nombre_tabla [WHERE <predicado>]



-- Tipos de Datos:

	Numericos: integer, decimal (preciso), real (no preciso)

	Texto: char (longitud fija limitada), varchar (longitud variable limitada), text (longitud variable ilimitada)

	Tiempo: date, time, timestamp (date + time)

	Otros: ture 1, false 0, money, uuid, json
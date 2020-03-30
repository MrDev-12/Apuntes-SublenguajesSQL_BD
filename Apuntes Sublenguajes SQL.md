
# Apuntes Sublenguajes SQL

 - [Tipos de Sublenguajes](#Tipos-de-Sublenguajes)
 
   - [DDL - Data Definition Language](#DDL---Data-Definition-Language)

      - [Crear Bases de Datos](#Crear-Bases-de-Datos)

      - [Crear Tablas](#Crear-Tablas)

        - [Declaración de Atributos](#Declaración-de-Atributos)

        - [Restricciones:](#Restricciones)
  
          - [Clave Primaria](#Clave-Primaria)
          - [Clave Foránea](#Clave-Foránea)
          - [UNIQUE](#UNIQUE)
          - [CHECK](#CHECK)
          - [ASSERTION](#ASSERTION)

      - [Modificar Tablas](#Modificar-Tablas)

      - [Eliminar Tablas / Bases de Datos](#Eliminar-Tablas-/-Bases-de-Datos)  

   - [DML - Data Manipulation Language](#DML---Data-Manipulation-Language)

      - [Insertar Datos](#Insertar-Datos)

      - [Actualizar Datos](#Actualizar-Datos)

      - [Eliminar Datos](#Eliminar-Datos)

 - [Ejemplos de Ejercicios Modelo](https://github.com/MrDev-12/Apuntes-SublenguajesSQL_BD/tree/master/ejercicios_modelo)

 - **Referencias Externas**:

   - [Documentación PostgreSQL](https://www.postgresql.org/docs/current/index.html)

   - [Explicación y Ejemplos - W3Schools](https://www.w3schools.com/sql/default.asp)


***
***


## Tipos de Sublenguajes

Solo existe **1 lenguaje SQL**, sin embargo, este lenguajes cuenta con **6 sublenguajes**.


### **DQL (Data Query Language)**:  
      
Opera sobre los datos de la Base de Datos y sirve para obtener los datos deseados.

- **Comandos**:
		
  - ***SELECT*** (Antes estaba en el DML)

### **DDL (Data Definition Language)**:

Opera sobre los objetos de la Base de Datos, como tablas, filas, columnas, etc.

- **Comandos**:
		
  - ***CREATE***
  - ***ALTER***
  - ***DROP***

### **DML (Data Manipulation Language)**:

Opera sobre los datos de la Base de Datos, **no** sobre los objetos.

- **Comandos**:

  - ***INSERT***
  - **UPDATE**
  - **DELETE**

### **TCL (Transaction Control Language)**:

Permite administrar diferentes transacciones que ocurren dentro de una Base de Datos.

- **Comandos**:

  - ***COMMIT***
  - ***ROLLBACK***

### **DCL (Data Control Language)**:

Se encarga de controlar el acceso a los datos contenidos en la Base de Datos.

- **Comandos**:
		
  - ***GRANT***
  - ***REVOKE***

### **SCL (Session Control Language)**:

Se encarga de controlar dinamicamente las propiedades de una sesión de usuario.

- **Comandos**:
		
  - ***ALTER SESSION*** 


***
***


## DDL - Data Definition Language

Opera sobre los objetos de la Base de Datos, permitiéndonos crear tablas, establecer claves, etc.

***


### **Crear Bases de Datos**

Para crear Bases de Datos utilizaremos la siguiente sintaxis:  

```SQL
CREATE (DATABASE | SCHEMA) [IF NOT EXISTS] <nombreBD> [CHARACTER SET <nombreDelCharset>];
```

La utilización de ***DATABASE*** o ***SCHEMA*** se diferencia principalmente por los permisos en el momento de crear la Base de Datos.

- **Opciones**:

  - ***IF NOT EXISTS***: comprueba si la Base de Datos a crear existe o no.
  - ***CHARACTER SET***: determina el conjunto de caracteres que se va a utilizar.


> **Ejemplos**:

```SQL
CREATE DATABASE pruebaBD;
```

```SQL
CREATE DATABASE IF NOT EXISTS pruebaBD2;
```

***


### **Crear Tablas**

Para crear Tablas utilizaremos la siguiente sintaxis:  

```SQL
CREATE TABLE <nombreTabla> (

	<atributo1> tipoDato,
	<atributo2> tipoDato

);
```

En el momento de la creación de la Tabla, se pueden definir **RESTRICCIONES** en los atributos.  

Dichas restricciones, se explicarán más adelante y veremos como definirlas a la hora de crear la Tabla.


> **Ejemplo**:

```SQL
CREATE TABLE Alumnos (

	nombre VARCHAR(255),
	telefono CHAR(9)

);
```

***


### **Declaración de Atributos**

Para declarar Atributos utilizaremos la siguiente sintaxis:  

```SQL
<atributo1> tipoDato [PRIMARY KEY] [UNIQUE] [NOT NULL]
```

En el momento de declarar el Atributo, se le pueden aplicar ciertas **RESTRICCIONES**, sin embargo, en mi opinión, es preferible definirlas a parte y asi mantener cierta organización.

Es decir, en lugar de definirlos de esta forma:

```SQL
CREATE TABLE Alumnos (

	nombre VARCHAR(255),
	DNI CHAR(9) PRIMARY KEY

);
```

Mejor definirlos de esta otra forma:

```SQL
CREATE TABLE Alumnos (

	nombre VARCHAR(255),
	DNI CHAR(9),

	CONSTRAINT PK_Alumnos
		PRIMARY KEY (DNI)

);
```

Esta última estructura se explicará más adelante, cuando se vean las **RESTRICCIONES**.  


### **Tipos de Datos**

A la hora de declarar un Atributo, tenemos que indicar el tipo de dato que va a almacenar.  

Existen gran cantidad de tipos de datos, pero los **más usados** son los siguientes:

- **Numéricos**:
  
  - ***INTEGER***
  - ***DECIMAL*** (preciso)
  - ***REAL*** (no preciso)

- **Texto**:
  
  - ***CHAR*** (longitud fija limitada)
  - ***VARCHAR*** (longitud variable limitada)
  - ***TEXT*** (longitud variable ilimitada)

- **Tiempo**:
  
  - ***DATE***
  - ***TIME***
  - ***TIMESTAMP*** (DATE + TIME)

- **Otros**:
  
  - ***BOOLEAN*** ( true = 1 / false = 0 )
  - ***MONEY***
  - ***UUID*** (identificador único)
  - ***JSON***

Por otra parte, podemos crear nuestros propios **Dominios de dato** haciendo uso de los tipos de datos anteriores.

De esta manera, indicamos el Dominio de dato creado en lugar de especificar el mismo tipo de dato en diferentes atributos.

> **Ejemplo**:

```SQL
CREATE DOMAIN Tipo_DNI CHAR(9);
```

```SQL
CREATE TABLE Alumnos (

	nombre VARCHAR(255),
	DNI Tipo_DNI

);
```

***


### **Restricciones**

Las Restricciones se suelen definir **al final** de la creación de la tabla, después de declarar los atributos.

> **Ejemplo**:

```SQL
CREATE TABLE Alumnos (

	nombre VARCHAR(255),
	DNI CHAR(9),

	CONSTRAINT PK_Alumnos
		PRIMARY KEY (DNI)

);
```

Sin embargo, es **Opcional** indicarle un nombre a la restricción.

> **Ejemplo**:

```SQL
CREATE TABLE Alumnos (

	nombre VARCHAR(255),
	DNI CHAR(9),

	PRIMARY KEY (DNI)

);
```


### **Clave Primaria**

Para establecer la Clave Primaria utilizaremos la siguiente sintaxis:

```SQL
[CONSTRAINT <nombreRestricción>]
	PRIMARY KEY (<nombreAtributo>)
```

Si la clave primaria es una clave compuesta, tendremos que indicar los atributos separados por comas, **NUNCA** creando otra restriccion de clave primaria.

```SQL
[CONSTRAINT <nombreRestricción>]
	PRIMARY KEY (<nombreAtributo1>, <nombreAtributo2>)
```


### **Clave Foránea**

Para establecer la Clave Foránea utilizaremos la siguiente sintaxis:

```SQL
[CONSTRAINT <nombreRestricción>]
	FOREIGN KEY (<nombreAtributo>)
	REFERENCES <tablaAjena>(<nombreAtributoAjeno>)
	[ON DELETE CASCADE | NO ACTION | SET NULL | SET DEFAULT]
	[ON UPDATE CASCADE | NO ACTION | SET NULL | SET DEFAULT]
	[MATCH FULL | MATCH PARTIAL]
```

Por defecto, si no especificamos ***ON DELETE*** ni ***ON UPDATE***, toman por defecto el valor ***NO ACTION***.

- **Opciones Principales**:

  - ***ON DELETE***: indica que acción se realizará sobre los datos almacenados en caso de que se **ELIMINE** la ***Clave Principal*** a la que referencia la ***Clave Foránea***.
  - ***ON UPDATE***: indica que acción se realizará sobre los datos almacenados en caso de que se **MODIFIQUE** la ***Clave Principal*** a la que referencia la ***Clave Foránea***.

  - ***MATCH FULL***: indica que todos los datos, tanto de la tabla con la ***Clave Primaria*** como de la tabla con la ***Clave Foránea*** **NO** pueden estar a **NULL**, teniendo así que coincidir los datos de ambas tablas.
  - ***MATCH PARTIAL***: permite tener datos de las tablas a **NULL**.


- **Opciones ON DELETE / ON UPDATE**:

  - ***CASCADE***: si se borran o modifican los datos de la ***Clave Primaria*** referenciada, se borran o modifican los datos de la ***Clave Foránea***.

  - ***NO ACTION***: no se realiza ninguna acción sobre los datos. Se mantienen los datos.

  - ***SET NULL***: si se borran o modifican los datos de la ***Clave Primaria*** referenciada, se establecen a **NULL** los datos de la ***Clave Foránea***.

  - ***SET DEFAULT***: si se borran o modifican los datos de la ***Clave Primaria*** referenciada, se establecen a un **valor por defecto** los datos de la ***Clave Foránea***.


### **UNIQUE**

Permite que todos los valores sean diferenentes, únicos.  

Se suele utilizar para las **Claves Candidatas**.

Para establecer una restricción UNIQUE utilizaremos la siguiente sintaxis:

```SQL
[CONSTRAINT <nombreRestricción>]
	UNIQUE (<nombreAtributo>)
```


### **CHECK**

Permite realizar comprobaciones haciendo uso de un **PREDICADO**, de manera que si se cumplen las condiciones descritas, se realiza la acción deseada.

Para establecer una restricción CHECK utilizaremos la siguiente sintaxis:

```SQL
[CONSTRAINT <nombreRestricción>]
	CHECK (predicado)
```

> **Ejemplo**:

```SQL
CONSTRAINT precioPositivo
	CHECK (precio > 0)
```

- **Opciones**:

  - ***NOT DEFERRABLE***: no se permite aplazar la ejecución del CHECK, de manera que se realiza en el momento. Es la **opción por defecto**.

  - ***DEFERRABLE INITIALLY DEFERRABLE***: permite aplazar la ejecución del CHECK, de manera que se realiza al final.


### **ASSERTION**

Se crea de maneta independiente a las tablas, permitiendo acceder a los atributos de cualquier tabla.

Para establecer una restricción ASSERTION utilizaremos la siguiente sintaxis:

```SQL
CREATE ASSERTION <nombreRestricción>
	CHECK (predicado)
```

***


### **Modificar Tablas**

Muchas estructuras de sintaxis que se utilizaban en el momento de ***Crear una Tabla***, pueden utilizarse en el momento de modificación, como establecer **Restricciones** o los **Tipos de Datos**.

A la hora de modificar Tablas, podemos realizar diferentes acciones dependiendo lo que queramos realizar:

- **Añadir Columnas**:

	```SQL
	ALTER TABLE <nombreTabla>

		ADD [COLUMN] <atributo> tipoDato;
	```

- **Modificar Columnas**:

	```SQL
	ALTER TABLE <nombreTabla>

		ALTER COLUMN <atributo> TYPE nuevoTipoDato;
	```

- **Eliminar Columnas**:

	```SQL
	ALTER TABLE <nombreTabla>

		DROP COLUMN <atributo> [CASCADE | RESTRICT];
	```

	- **Opciones**:
	
    	- ***CASCADE***: borra todos los datos, tanto Restriccions como datos referenciados.
    	- ***RESTRICT***: no permite borrar la columna si tiene dependencias. Es la **opción por defecto**.

- **Añadir Restricciones**:

	La estructura y las distintas variantes de las **Restricciones** son las mismas que las explicadas anteriormente.

	```SQL
	ALTER TABLE <nombreTabla> 

		ADD [CONSTRAINT <nombreRestricción>] PRIMARY KEY | FOREIGN KEY | CHECK ...;
	```

- **Eliminar Restricciones**:

	```SQL
	ALTER TABLE <nombreTabla>

		DROP CONSTRAINT <nombreRestricción>;
	```

***


### **Eliminar Tablas / Bases de Datos**

Para eliminar Bases de Datos utilizaremos la siguiente sintaxis:

```SQL
DROP DATABASE | SCHEMA [IF EXISTS] <nombreBD>;
```

Para eliminar Tablas utilizaremos la siguiente sintaxis:

```SQL
DROP TABLE [IF EXISTS] <nombreTabla> [CASCADE | RESTRICT];
```

- **Opciones**:
	
    - ***CASCADE***: borra todos los datos en cascada, incluyendo las dependencias.
    - ***RESTRICT***: no permite borrar la tabla si tiene dependencias. Es la **opción por defecto**.


***
***


## DML - Data Manipulation Language

Opera sobre los datos de la Base de Datos, **no** sobre los objetos.

***

### **Insertar Datos**

Para insertar datos en una Tabla utilizaremos la siguiente sintaxis:  

```SQL
INSERT INTO <nombreTabla> [ (<atributo1>, <atributo2>, ...) ]
	VALUES (<valor1>, <valor2>, ...) | SELECT ...;
```

Se pueden introducir **múltiples filas** haciendo uso de un solo comando:

```SQL
INSERT INTO <nombreTabla> [ (<atributo1>, <atributo2>, ...) ]
	VALUES (<valor1a>, <valor2a>), 
		   (<valor1b>, <valor2b>),
		   (<valor1c>, <valor2c>);
```

Si introducimos valores a partir de un **SELECT**, éste tendrá que tener el mismo número de columnas, el mismo orden a la hora de seleccionarlas y los mismos tipos de datos que la tabla destino.

> **Ejemplo**:

```SQL
INSERT INTO productos (num_producto, nombre, precio)
  SELECT num_producto, nombre, precio
  FROM productos_nuevos
    WHERE fecha_salida = 'hoy';
```

***

### **Actualizar Datos**

Para actualizar datos en una Tabla utilizaremos la siguiente sintaxis:  

```SQL
UPDATE <nombreTabla> SET <atributo1> = <valor1>,
						 <atributo2> = <valor2>,
						 <atributo3> = <valor3>,
						 ...
	[WHERE <predicado>];
```

Se pueden establecer condiciones con **WHERE**, de manera que, si se cumple dicha condición, se realizará la Actualización de los Datos indicados.

> **Ejemplo**:

```SQL
UPDATE productos SET precio = '50',
					 oferta = 'si',
    WHERE meses_en_stock > '5';
```

***

### **Eliminar Datos**

Para eliminar datos en una Tabla utilizaremos la siguiente sintaxis:  

```SQL
DELETE FROM <nombreTabla> [WHERE <predicado>];
```

Si no se establecen condiciones con **WHERE**, se borrarían todos los datos de la tabla indicada.

Por este motivo, hay que acordarse de utilizar un WHERE.

Se pueden introducir **múltiples filas** haciendo uso de un solo comando:

> **Ejemplo**:

```SQL
DELETE FROM productos WHERE caducado = 'si';
```

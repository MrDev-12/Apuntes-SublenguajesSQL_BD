
# Apuntes SQL - DQL

 - [Introducción a SQL](#introducción-a-sql)
 
 - [Conceptos Importantes](#conceptos-importantes)
 
 - [Utilidades Varias](#utilidades-varias) 
 
 - [Ejemplos Consultas Complejas](#ejemplos-consultas-complejas)

***
***


## Introducción a SQL

**SQL** es un lenguaje de consultas que permite el acceso y la manipulación de Bases de Datos.

Estes apuntes se centran en el sublenguaje de **DQL** de SQL, el cual permite indicar qué datos queremos que se muestren.

**Estructura de una Sentencia SQL DQL**: 

 1.- **FROM**: se indica la tabla/s de la cual se va a obtener los datos.  
 2.- **WHERE**: se indica una condición.  
 3.- **ORDER BY**, **GROUP BY**, **HAVING**, etc.  
 4.- **SELECT**: se indica los datos a mostrar.

***
***


## Conceptos Importantes


### SELECT

Permite seleccionar los datos que queramos de la base de datos.  
Los datos devueltos son almacenados en una tabla de resultados.

> **Ejemplos**:

```SQL
SELECT population
FROM world;
```

```SQL
SELECT name, area
FROM world;
```

***

### SELECT DISTINCT

Permite seleccionar los datos que queramos de la base de datos y que se muestren una única vez en la tabla de resultados.

> **Ejemplo**:

```SQL
SELECT DISTINCT continent
FROM world;
```

***

### FROM

Se usa para indicar la tabla de la cual vamos a recopilar los datos.

> **Ejemplos**:

```SQL
SELECT population, gdp
FROM world;
```

```SQL
SELECT name
FROM empleados;
```

***

### WHERE

Se utiliza para filtrar los resultados obtenidos con el SELECT.  
Hace uso de condiciones para filtrar lo que se desee.

> **Ejemplos**:

```SQL
SELECT name
FROM world
WHERE population > 1000;
```

```SQL
SELECT name
FROM world
WHERE name = 'Canada';
```

***

### Operadores AND, OR y NOT

Se utilizan dentro del WHERE.

---> **AND**: muestra los datos que cumplan las condiciones separadas por el AND.

---> **OR**: muestra los datos que cumplan cualquiera de las condiciones separadas por el OR o ambas.

---> **NOT**: muestra los datos si las condiciones NO se cumplen.

> **Ejemplos**:

```SQL
SELECT population
FROM world
WHERE population < 5000 AND continent = 'Africa';
```

```SQL
SELECT population
FROM world
WHERE continent = 'Africa' OR continent = 'Europe';
```

```SQL
SELECT population
FROM world
WHERE NOT continent = 'Africa';
```

***
***

## Utilidades Varias

### AS

Sirve para ponerle un alias a una columna.  
Se suele utilizar para identificar de manera más fácil el tipo de datos que contine la columna.

> **Ejemplo**:

```SQL
SELECT name, (preciohora * horas) AS 'Sueldo'
FROM empleados
WHERE horas > 5;
```

***

### IN

Sirve para especificar multiples valores.  
Es un operador que permite evitar el uso de **multiples OR**.

> **Ejemplo**:

```SQL
SELECT name
FROM world
WHERE continent IN ('Africa', 'Europa', 'Asia');
```

***

### BETWEEN

Sirve para seleccionar valores entre un rango definido.  
El rango de valores incluye los definidos en la condición.

> **Ejemplo**:

```SQL
SELECT name
FROM world
WHERE population BETWEEN 1000 AND 2000;
```

***

### LIKE

Sirve para filtrar los datos que cumplen un patron predeterminado.  
Hay dos signos que se utilizan con el LIKE:

- **%**: representa cero, uno o múltiples caracteres.
- **_**: representa un único carácter.

> **Ejemplos**:

*Países terminados en O*

```SQL
SELECT name
FROM world
WHERE name LIKE '%o';
```

*Países que contienen una O*

```SQL
SELECT name
FROM world
WHERE name LIKE '%o%';
```

*Países cuyo nombre tiene 5 caracteres*

```SQL
SELECT name
FROM world
WHERE name LIKE '____';
```

***

### ORDER BY

Sirve para ordenar los resultados de manera ascendente (**ASC**) o descendente (**DESC**).

> **Ejemplos**:

```SQL
SELECT name, population
FROM world
ORDER BY population ASC;
```

```SQL
SELECT name, population
FROM world
ORDER BY population DESC;
```

***

### CONCAT

Sirve para combinar dos o mas cadenas.

> **Ejemplos**:

*Mostrar NombreApellido*

```SQL
SELECT CONCAT(name, lastname) AS 'NombreApellido'
FROM users;
```

*Mostras los paises que tienen 'City' en el nombre*

```SQL
SELECT name
FROM world
WHERE name = CONCAT(name, ' City');
```

***

### REPLACE

Sirve para remplazar unos caracteres por otros.

- **Sintaxis**: (Campo, *'Caracter a reemplazar'*, *'Caracter por el que remplazar'*)

> **Ejemplo**:

```SQL
SELECT name, REPLACE (name, 'a', 'e') AS 'Reemplazo'
FROM world;
```

***

### ROUND

Sirve para redondear un número a la cantidad de decimales que especifiquemos.

> **Ejemplo**:

*Redondear a 2 decimales el coste final*

```SQL
SELECT name, ROUND(cost*iva, 2) AS 'Coste Final'
FROM products;
```

```SQL
SELECT name
FROM world
WHERE name = 'Canada';
```

***

### LENGTH

Sirve para obtener la longitud de un campo.

> **Ejemplo**:

```SQL
SELECT name, LENGTH(name) AS 'Cantidad de letras'
FROM world;
```

***

### LEFT

Sirve para obtener la cantidad caracteres especificada de una cadena, empezando a contar por la izquierda.

> **Ejemplo**:

```SQL
SELECT name, LEFT(name, 1) AS 'Primer Caracter'
FROM world;
```

***

### SUM

Sirve para calcular la cantidad total de una columna numérica.

> **Ejemplo**:

```SQL
SELECT SUM(cost) AS 'Coste Total'
FROM products;
```

***

### AVG

Sirve para calcular el valor medio de una columna numérica.

> **Ejemplo**:

```SQL
SELECT AVG(mark) AS 'Nota Media'
FROM alums;
```

***

### COUNT

Sirve para calcular el número de filas que cumplen un determinado criterio.

> **Ejemplo**:

```SQL
SELECT COUNT(name) AS 'Número de Paises'
FROM world;
```

***

### GROUP BY

Sirve para agrupar varias filas que tienen el mismo valor en una única fila.  
Se suele utilizar con **funciones de agregado** como **COUNT**, **MAX**, **MIN**, **SUM** o **AVG**.

> **Ejemplos**:

```SQL
SELECT continent, COUNT(name) AS 'Número de Paises'
FROM world
GROUP BY continent;
```

```SQL
SELECT name, AVG(marks_jobs) AS 'Media Trabajos Entregados'
FROM world
GROUP BY name;
```

***

### HAVING

Permite utilizar **funciones de agregado**, cosa que el WHERE no permite.  
Es necesario utilizar un **GROUP BY**.

> **Ejemplos**:

*Muestra los continentes que tengan más de 20 países*

```SQL
SELECT continent
FROM world
GROUP BY continent
HAVING COUNT(name) > 20;
```
*Muestra los empleados que tengan una media de 5 o más en los trabajos entregados*

```SQL
SELECT name, AVG(marks_jobs) AS 'Media Trabajos Entregados'
FROM world
GROUP BY name
HAVING AVG(marks_jobs) >= 5
ORDER BY name DESC;
```

***

### JOIN

Sirve para combinar filas de dos o más tablas basándose en una columna común entre ellas.  
Para distinguir mejor a que tabla pertenecen, utilizaremos la siguiente nomenclatura: ***tabla.atributo***  
Hay diferentes tipos de JOINs:

- **(INNER) JOIN**: devuelve los resultados que cumplan la condición en ambas tablas.
Con **INNER**, filtra los valores nulos.
- **LEFT JOIN**: devuelve todos los resultados de la **tabla izquierda** y los que cumplan la condición de la tabla derecha.
- **RIGHT JOIN**: devuelve todos los resultados de la **tabla derecha** y los que cumplan la condición de la tabla izquierda.

> **Ejemplos**:

```SQL
SELECT goal.player, game.mdate
 FROM game JOIN goal ON (game.id = goal.matchid)
 WHERE goal.teamid='GER;
```
*Si queremos hacer una consulta que involucran varias tablas y **no podemos usar ON**, lo haríamos de la siguiente manera:*

```SQL
SELECT goal.player, game.mdate
 FROM game JOIN goal
 WHERE game.id = goal.matchid AND goal.teamid='GER;
```
***

*Muestra los profesores y su departamento sin contar los profesores que no tienen departamento y los departamentos que no tienen profesores*

```SQL
SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept ON (teacher.dept = dept.id);
```

*Muestra todos los profesores, tengan o no departamento*

```SQL
SELECT teacher.name, dept.name
 FROM teacher LEFT JOIN dept ON (teacher.dept = dept.id);
```

*Muestra todos los departamentos, tengan o no profesores*

```SQL
SELECT teacher.name, dept.name
 FROM teacher RIGHT JOIN dept ON (teacher.dept = dept.id);
```

***

### NULL

Sirve para filtrar valores nulos, pudiendo mostrar atributos de algunas columnas que tengan o no valores nulos.

> **Ejemplos**:

*Muestra el nombre de los profesores que no tienen departamento*

```SQL
SELECT name
FROM teacher
WHERE dept IS NULL;
```

*Muestra el nombre de los profesores que tienen departamento*

```SQL
SELECT name
FROM teacher
WHERE dept IS NOT NULL;
```

***

### COALESCE

Sirve para remplazar valores nulos por cualquier otro valor que queramos.

> **Ejemplos**:

*Muestra el nombre de los profesores y su número de teléfono móvil. En caso de ser este último valor nulo, mostrará '07986 444 2266'*

```SQL
SELECT name, COALESCE(mobile, '07986 444 2266') AS 'Móvil'
FROM teacher;
```

***
***

## Ejemplos Consultas Complejas

Se pueden realizar subconsultas dentro de una consulta, es decir, **realizar SELECTs dentro de un WHERE**.  
Sirve para comparar varios valores (***SELECT externo***) con un único resultado obtenido a través de una subcondición (***SELECT interno***).

> **Ejemplos**:

*Muestra cada país donde la población sea mayor que la de Rusia*

```SQL
SELECT name
FROM world
WHERE population >
      (SELECT population
      FROM world
      WHERE name = 'Russia');
```

*Muestra el país y continente de los países cuyo contiente sea el de Argentina o el de Australia*

```SQL
SELECT name, continent
FROM world
WHERE continent = 

          (SELECT continent
           FROM world
           WHERE name = 'Argentina')

OR continent = 

          (SELECT continent
           FROM world
           WHERE name = 'Australia')
           
ORDER BY name;
```

A continuación, hay algunos ejemplos de las consultas más complejas en mi opinión, que son las que contienen **varios JOINs** o tienen **subconsultas con JOINs**.

> **Ejemplos**:

*Mostrar los actores que actuan en la película Casablanca*

***Opción 1***:

```SQL
SELECT actor.name
FROM actor JOIN casting ON actor.id = casting.actorid
WHERE casting.movieid = (
           SELECT movie.id
           FROM movie
           WHERE movie.title = 'Casablanca');
```

***Opción 2***:

```SQL
SELECT actor.name
FROM actor JOIN casting ON actor.id = casting.actorid
           JOIN movie ON casting.movieid = movie.id
WHERE movie.title = 'Casablanca';
```

*Mostrar los actores que trabajaron con Art Garfunkel*

```SQL
SELECT actor.name                                             
FROM actor JOIN casting ON actor.id = casting.actorid
WHERE actor.name <> 'Art Garfunkel'
      AND casting.movieid IN (
                SELECT casting.movieid
                FROM casting JOIN actor ON casting.actorid = actor.id
                WHERE actor.name = 'Art Garfunkel');
```

***

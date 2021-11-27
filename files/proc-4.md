# [ASIR2.ASGBD.Procedimientos.4.sql](../sqls/ASIR2.ASGBD.Procedimientos.4.sql)

## Objetivo
Crear un procedimiento que devuelva el nombre y el director de los equipos tales que todos sus ciclistas son mayores de una edad que se pasa por parámetro. Utiliza la base de datos Ciclistas.
## Código 
### Variante 1
```sql
DELIMITER $$
DROP PROCEDURE IF EXISTS EdadEquipos$$

CREATE PROCEDURE EdadEquipos (IN edad_pasada INT)
BEGIN
	SELECT * FROM equipos
	WHERE nombre IN (
		SELECT nomeq
			FROM ciclistas
			GROUP BY nomeq
			HAVING MIN(edad) > edad_pasada);
END $$

CALL EdadEquipos(25)$$
```
### Variante 2

```sql
DROP PROCEDURE IF EXISTS EdadEquipos;
DELIMITER @@

CREATE PROCEDURE EdadEquipos (IN edad_pasada INT)
BEGIN
    SELECT e.nombre, e.director
    FROM equipos as e, ciclistas as c
    WHERE 
		e.nombre = c.nomequip
        AND c.edad > edad_pasada;
END @@

CALL EdadEquipos(20);
```

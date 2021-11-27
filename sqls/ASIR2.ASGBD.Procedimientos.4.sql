-- Crear un procedimiento que devuelva el nombre y el director de los equipos tales que todos
-- sus ciclistas son mayores de una edad que se pasa por parámetro. Utiliza la base de datos Ciclistas.

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
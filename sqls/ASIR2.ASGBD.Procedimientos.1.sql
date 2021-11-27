-- Crea un procedimiento que devuelva el nombre de los ciclistas que pertenezcan 
-- al mismo equipo que un corredor que se le pasa por parámetro. Utiliza la base de datos Ciclistas.

DELIMITER $$
DROP PROCEDURE IF EXISTS CorredoresCompi$$

CREATE PROCEDURE CorredoresCompi(IN nombre_ciclis VARCHAR(45))
BEGIN
	SELECT nombre FROM ciclistas WHERE nomeq = (
		SELECT nomeq FROM ciclistas WHERE nombre = nombre_ciclis);
END $$

CALL CorredoresCompi('Miguel Induráin')$$

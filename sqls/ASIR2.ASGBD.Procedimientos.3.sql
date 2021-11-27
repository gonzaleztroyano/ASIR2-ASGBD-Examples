-- Crea un procedimiento que devuelva el valor del atributo netapa de aquellas etapas tales
--  que todos los puertos que están en ellas tenga más los metros que se le pasa por parámetro. Utiliza la base de datos Ciclistas.

DELIMITER $$
DROP PROCEDURE IF EXISTS EtapasPuertosAltura$$
CREATE PROCEDURE EtapasPuertosAltura(IN alt_pedida INT)
BEGIN
	SELECT numetapa
	FROM puertos
	GROUP BY numetapa
	HAVING MIN(altura)> alt_pedida;
END $$

CALL EtapasPuertosAltura(800)$$
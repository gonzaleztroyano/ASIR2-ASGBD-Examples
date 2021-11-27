-- Crea una función que calcule el total de puntos en un partido 
-- de baloncesto tomando como entrada el resultado en formato 'xxx-xxx'. 

DROP FUNCTION IF EXISTS total;
DELIMITER @@

CREATE FUNCTION total (resultado CHAR(7))
RETURNS INT
DETERMINISTIC
	BEGIN 
		DECLARE TOTAL int;
        SET TOTAL = SUBSTRING_INDEX(resultado,"-",1) + SUBSTRING_INDEX(resultado,"-",-1);
        RETURN TOTAL;
	END@@
    
SELECT total("025-045");
DELIMITER ##
 
DROP PROCEDURE IF EXISTS act_jefe##
 
 
CREATE PROCEDURE act_jefe(IN dir_anti VARCHAR(9), 
						  IN dir_nuevo VARCHAR(9))
BEGIN
	DECLARE num_filas INT DEFAULT 0;
    DECLARE cuenta_bucle INT DEFAULT 0;
	DECLARE local_dni VARCHAR(9) DEFAULT 'PEPE';
    DECLARE local_jefe VARCHAR(9) DEFAULT 'PEPE';
    
    DECLARE cursordirectores CURSOR FOR
		SELECT DNI, Directores_DNI 
			FROM directores
			WHERE Directores_DNI = (dir_anti OR dir_nuevo);
	SELECT FOUND_ROWS( ) INTO num_filas;
	OPEN cursordirectores;
    WHILE cuenta_bucle < num_filas DO
		BEGIN 
			FETCH cursordirectores INTO local_dni, local_jefe;
            IF local_jefe = dir_anti THEN
				UPDATE directores 
					SET Directores_DNI = dir_nuevo
					WHERE DNI = local_dni;
				END IF;
			IF local_jefe = dir_nuevo THEN
				UPDATE directores
					SET Directores_DNI = dir_anti
					WHERE DNI = local_dni;
				END IF;
			SET  cuenta_bucle = cuenta_bucle + 1;

			END; 
		END WHILE;
	-- Cerrar cursos --
	CLOSE cursordirectores;
END##
 
CALL act_jefe('D1','D3');

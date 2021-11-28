# [ASIR2.ASGBD.cursores.4.sql](../sqls/ASIR2.ASGBD.cursores.4.sql)

## Objetivo
La empresa va a sufrir obras en la sede en la que se encuentra el despacho “1” y todos los trabajadores de este despacho se van a tener que trasladar al despacho “5”. Recorre la tabla de DIRECTORES, registro a registro, actualizando la información para que nuestra base de datos recoja esta circunstancia.

## Código 

```sql
DELIMITER $$
DROP PROCEDURE IF EXISTS act_despacho$$
CREATE PROCEDURE act_despacho(despacho_uno INT, despacho_dos INT)
BEGIN
	DECLARE num_filas INT DEFAULT 0;
    DECLARE cuenta_bucle INT DEFAULT 0;
    DECLARE local_dni VARCHAR(8);
    DECLARE local_despacho INT DEFAULT 99;
	DECLARE cursor_act_despachos CURSOR FOR 
		SELECT DNI,Despacho 
        FROM directores
        WHERE (Despacho = despacho_uno OR Despacho = despacho_dos);
	SELECT found_rows() INTO num_filas;
	OPEN cursor_act_despachos;
    WHILE cuenta_bucle < num_filas DO
		BEGIN 
			FETCH cursor_act_despachos INTO local_dni,local_despacho;
            IF local_despacho = despacho_uno THEN
				UPDATE directores SET Despacho = despacho_dos WHERE DNI = local_dni;
				END IF;
			IF local_despacho = despacho_dos THEN
				UPDATE directores SET Despacho = despacho_uno WHERE DNI = local_dni;
				END IF;
			SET cuenta_bucle = cuenta_bucle + 1;
        END;
	END WHILE;
    CLOSE cursor_act_despachos;
END $$

CALL act_despacho(1,2)$$
```
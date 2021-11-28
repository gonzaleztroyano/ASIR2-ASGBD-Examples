# [ASIR2.ASGBD.Trigger.6.sql](../sqls/ASIR2.ASGBD.Trigger.6.sql)

## Objetivo
-- Crea un trigger sobre la tabla empleados para que no se permita que un empleado sea jefe de más de tres empleados.

La situación de asociar un jefe a un empleado, que es en la que tenemos que comprobar la condición del enunciado, puede darse al insertar un empleado o al actualizarlo. 

Por ello, debemos crear triggers para la operación de INSERT y para la de UPDATE. Como el código de validación es el mismo, creamos una función que nos devuelva si podemos asignarle más empleados a ese jefe y lo llamamos desde ambos triggers.

## Código 

```sql
DELIMITER $$
DROP FUNCTION IF EXISTS jefe_emple_lim3$$

CREATE FUNCTION jefe_emple_lim3 (n_jefe INT)
RETURNS INT 
DETERMINISTIC
BEGIN
	DECLARE n_subs INT DEFAULT 0;
	
    SELECT COUNT(emp_no) 
		FROM empleados 
		WHERE director = n_jefe
		GROUP BY director LIMIT 0, 1000
        INTO n_subs;
    
	IF n_subs > 2
		THEN RETURN 0;
	ELSE 
		RETURN 1;
	END IF;
END $$

DROP TRIGGER IF EXISTS jefe_emple_lim3_insert$$

CREATE TRIGGER jefe_emple_lim3_insert BEFORE INSERT ON empleados
FOR EACH ROW
	IF (jefe_emple_lim3(NEW.director) = 0) THEN 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Un(a) empleado/a no puede tener más de 3 subordinados/as';
	END IF;
END$$

CREATE TRIGGER jefe_emple_lim3_update BEFORE UPDATE ON empleados
FOR EACH ROW
	IF (jefe_emple_lim3(NEW.director) = 0) THEN 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Un(a) empleado/a no puede tener más de 3 subordinados/as';
	END IF;
END$$
```
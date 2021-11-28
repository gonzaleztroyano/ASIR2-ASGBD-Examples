-- Crea un trigger para impedir que se aumente el salario de un empleado en más de un 20%.

DELIMITER $$

DROP TRIGGER IF EXISTS nomas_20_salario$$

CREATE TRIGGER nomas_20_salario BEFORE UPDATE ON empleados
FOR EACH ROW
BEGIN
	IF (NEW.salario > (OLD.salario*1.20)) THEN
		SET NEW.salario = OLD.salario;
        SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'No se puede aumentar el salario más de un 20%';
	END IF;
END $$

UPDATE `ventasleon`.`empleados` SET `salario` = '200.00' WHERE (`emp_no` = '7900')$$
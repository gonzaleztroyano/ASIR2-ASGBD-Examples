-- Queremos que cada vez que se inserte una nueva cuenta en la tabla cuenta, si el
-- cliente que abre la nueva cuenta tiene ya una cuenta en el banco, se le sume 200
-- euros al saldo con el que se abre esa cuenta.

DELIMITER $$
DROP TRIGGER IF EXISTS cuenta_cli_existente $$

CREATE TRIGGER cuenta_cli_existente BEFORE INSERT ON cuenta
FOR EACH ROW
BEGIN 
	IF EXISTS (SELECT cod_cliente 
				FROM cuenta
                WHERE cod_cliente = NEW.cod_cliente) = 1
		THEN
			SET NEW.saldo = NEW.saldo + 200;
		END IF;
END $$

INSERT INTO `ebanca`.`cuenta` (`fecha_creacion`, `saldo`, `cod_cuenta`, `cod_cliente`) VALUES ('2021-11-22', '0', '6', '5');
INSERT INTO `ebanca`.`cuenta` (`fecha_creacion`, `saldo`, `cod_cuenta`, `cod_cliente`) VALUES ('2021-11-23', '0', '7', '15');

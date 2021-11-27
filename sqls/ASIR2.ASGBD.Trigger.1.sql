-- En la BD Ventas, crea un disparador que asegure que el precio de cada producto sea un número mayor de 200.

DELIMITER $$
DROP TRIGGER IF EXISTS siempre_200$$
CREATE TRIGGER siempre_200 BEFORE INSERT ON productos
FOR EACH ROW
BEGIN
	IF NEW.precio < 200 THEN
		SET NEW.precio = 201;
	END IF;
END $$
# [ASIR2.ASGBD.Trigger.3.sql](../sqls/ASIR2.ASGBD.Trigger.3.sql)

## Objetivo
-- Haz lo necesario para que cada vez que un cliente de ebanca ingrese más de 1000€ se le bonifique con 100€,  solo para clientes con cuentas que superen tres años de antigüedad y para movimientos realizados entre el 1 de enero de 2011 y el 31 de marzo de 2011.

## Código 

```sql
DELIMITER $$
DROP PROCEDURE IF EXISTS bonificacion_updater$$
 
CREATE PROCEDURE bonificacion_updater(IN cod_cuenta_pasada INT)
	UPDATE cuenta
    SET saldo = saldo + 100
    WHERE cod_cuenta = cod_cuenta_pasada;
    $$
 
DROP FUNCTION IF EXISTS antigu_c$$
CREATE FUNCTION antigu_c(c_cuenta INT) 
RETURNS int(11)
DETERMINISTIC
BEGIN 
		DECLARE fecha DATE;
		SELECT fecha_creacion 
			FROM cuenta
            WHERE cod_cuenta=c_cuenta INTO fecha;
        RETURN timestampdiff(year,fecha,CURRENT_DATE());
 END $$
 
DROP TRIGGER IF EXISTS bonificacion$$
 
CREATE TRIGGER bonificacion AFTER INSERT
ON movimiento
FOR EACH ROW
BEGIN
    IF (antigu_c(NEW.cod_cuenta) > 3)
		AND (NEW.cantidad > 1000) 
        AND (NEW.fechahora between '2011-01-01' AND '2011-03-31')
	THEN 
		#Aquí debemos sumar 100€ a la cuenta pasada
        CALL bonificacion_updater(NEW.cod_cuenta);
	END IF;
END$$
    
INSERT INTO `ebanca`.`movimiento`
VALUES (1,'2011-02-01',4000,51,1)$$    
```
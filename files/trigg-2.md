# [ASIR2.ASGBD.Trigger.2.sql](../sqls/ASIR2.ASGBD.Trigger.2.sql)

## Objetivo
En la base ebanca, haz un disparador que cree un registro en la tabla nrojos con los campos cliente, cuenta, fecha y saldo cada vez que algún cliente se quede en números rojos en alguna de sus cuentas.
## Código 

```sql
DELIMITER $$
DROP TRIGGER IF EXISTS log_nrojos$$
CREATE TRIGGER log_nrojos AFTER UPDATE on cuenta
FOR EACH ROW
BEGIN
	IF NEW.saldo < 0 THEN
		INSERT INTO nrojos (ccliente,ccuenta,fecha,saldo) VALUES
        (NEW.cod_cliente,NEW.cod_cuenta,CURDATE(),NEW.saldo);
	END IF;
END $$

UPDATE cuenta SET saldo=-200 WHERE cod_cuenta = 4$$
```
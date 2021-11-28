# [ASIR2.ASGBD.Trigger.4.sql](../sqls/ASIR2.ASGBD.Trigger.4.sql)

## Objetivo
Haz lo necesario para cada vez que hay un movimiento  se actualice el saldo de la cuenta de ese cliente con ese movimiento, ya se un ingreso o una retirada.
## Código 

```sql
DELIMITER $$
DROP TRIGGER IF EXISTS actualiza_saldo$$

CREATE TRIGGER actualiza_saldo after INSERT ON movimiento
FOR EACH ROW
BEGIN
	UPDATE cuenta SET saldo = saldo + NEW.cantidad
    WHERE cod_cuenta = NEW.cod_cuenta;
END $$
```
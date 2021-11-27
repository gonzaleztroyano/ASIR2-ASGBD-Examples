# [ASIR2.ASGBD.Funciones.1.sql](../sqls/ASIR2.ASGBD.Funciones.1.sql)

## Objetivo
Crea una función que devuelva el valor de la hipotenusa de un triángulo a partir de los valores de sus lados
## Código 

```sql
DROP FUNCTION IF EXISTS hipotenusa;
DELIMITER @@

CREATE FUNCTION hipotenusa (
							lado1 DECIMAL(20,10),
                            lado2 DECIMAL(20,10))
RETURNS DECIMAL(20,10)
	DETERMINISTIC
	BEGIN
		declare hipot DECIMAL(20,10);
        SET hipot = (sqrt(POW(lado1,2)+POW(lado2,2)));
		RETURN hipot;
    END@@
    
DELIMITER ;
SELECT hipotenusa(5,7);
```
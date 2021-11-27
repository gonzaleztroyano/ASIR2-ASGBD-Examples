# [ASIR2.ASGBD.Procedimientos.2.sql](../sqls/ASIR2.ASGBD.Procedimientos.2.sql)

## Objetivo
Crea un procedimiento que devuelva el nombre de los ciclistas que han ganado más del número de puertos que se le pasa por parámetro. 
## Código 

```sql
DELIMITER $$
DROP PROCEDURE IF EXISTS cuenta_puertos$$
CREATE PROCEDURE cuenta_puertos(IN num_puertos INT)
BEGIN
	SELECT`ciclistas`.`nombre`
		FROM ciclistas
		WHERE dorsal IN (
			SELECT dorsalganador
			FROM puertos
			GROUP BY dorsalganador
			HAVING COUNT(dorsalganador) > num_puertos 
			);

END $$
CALL cuenta_puertos(1)$$
```
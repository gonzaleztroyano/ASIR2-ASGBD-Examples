# *Chuleta* con estructuras

## Cursores

```sql
DROP PROCEDURE IF EXISTS NOMBRE$$
CREATE PROCEDURE  NOMBRE( )
BEGIN
    DECLARE num_filas INT DEFAULT 0;
    DECLARE cuenta_bucle INT DEFAULT 0;
	DECLARE nombre_cursor CURSOR FOR
        SELECT XXX;
    SELECT found_rows() INTO num_filas;
    OPEN cursor_act_despachos;
    WHILE cuenta_bucle < num_filas DO
		BEGIN 
            FETCH nombre_cursor INTO vars;
	SET cuenta_bucle = cuenta_bucle + 1;
        END;
    END WHILE;
    CLOSE nombre_cursor;
END $$
```

## Eventos

```sql
DROP EVENT IF EXISTS ofertas_31_dic$$
CREATE EVENT ofertas_31_dic ON SCHEDULE
EVERY 1 YEAR
STARTS "2021-12-31 05:00:00" -- current_timestamp() + INTERVAL 1 minute
ENDS current_timestamp() + INTERVAL 1 minute|year|month
DO
BEGIN
    -- AQUÍ COSAS
END
```

## Triggers
```sql
CREATE TRIGGER nombre_trigger {BEFORE|AFTER} {INSERT|UPDATE|DELETE}
ON nombre_tabla
FOR EACH ROW
BEGIN
END$$
```


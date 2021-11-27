# *Chuleta* SQL con estructuras variadas

## Procedimientos 

```sql
DROP PROCEDURE IF EXISTS anioactual;
DELIMITER @@
CREATE PROCEDURE anioactual()
BEGIN
    -- Podemos declarar variables
        DECLARE var_1 INT DEFAULT 0;
	-- Instrucciones aquí --
    -- Devuelvo la sentencia select:
    SELECT YEAR(CURDATE());
END @@
DELIMITER ;
CALL anioactual()
```
## Funciones

```sql
DROP FUNCTION IF EXISTS hipotenusa;
DELIMITER @@

CREATE FUNCTION hipotenusa (
							lado1 DECIMAL(20,10),
                            lado2 DECIMAL(20,10)
                            )
RETURNS DECIMAL(20,10)
	DETERMINISTIC
	BEGIN
		DECLARE hipot DECIMAL(20,10);
        SET hipot = (sqrt(POW(lado1,2)+POW(lado2,2)));
		RETURN hipot;
    END@@
    
    DELIMITER ;
SELECT hipotenusa(5,7);
```

## Estructuras de control

### Condicionales
```sql
IF (variable = 1) 
    THEN
        SELECT pepe INTO variable_2;
        RETURN X;
    END IF;
```

### Bucles

```sql
c1_loop: LOOP
        IF (lfinalizado) 
			THEN 
                LEAVE c1_loop; 
            END IF;
        SELECT X INTO Y;    
    END LOOP c1_loop;

```
# [ASIR2.ASGBD.Examen.1.sql](../sqls/ASIR2.ASGBD.Examen.1.sql)

## Objetivo
Haz que por cada pedido que se haga de productos (Tabla pedidos):
* Cuando un producto se pida mas de tres veces en un pedido que se haga en domingo este producto aumente su precio un 15% (Tabla productos). 
* Se reste las unidades del producto que se han realizado en el pedido del stock en la tabla productos
## Código 

```sql
DELIMITER ##
DROP TRIGGER IF EXISTS productos_domingo_v2##

CREATE TRIGGER productos_domingo_v2 AFTER INSERT 
ON pedidos
FOR EACH ROW
BEGIN
	UPDATE productos
				SET stock = stock - NEW.unidades
				WHERE producto_no = NEW.producto_no;
	IF (NEW.unidades > 3 )
		AND (DAYOFWEEk(NEW.fecha) = 1 )
        THEN
			UPDATE productos
				SET precio = precio *1.15
                WHERE producto_no = NEW.producto_no;
	END IF;
END ##
```
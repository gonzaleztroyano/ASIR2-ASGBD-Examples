# ASIR2.ASGBD.EjercicosExamen.2.sql

## Objetivo
Sobre la base de datos ventas:

* Haz que una vez cada segundo compruebe que las unidades que quedan de un producto en stock ( Tabla productos) no sean menores que el total de unidades que se han pedido durante la última semana de ese producto .( Las unidades que se piden en la última semana son las unidades que se piden en la tabla pedidos). 

* En caso de que las unidades que quedan en stock (Tabla productos) sean menores a la suma de toda las unidades que se han pedido la última semana ( Tabla pedidos) se debe insertar el identificador de ese producto en una tabla que se llame Pedir_productos que contendrá como único campo el identificador de los productos.
## Código 

### Variante 1
```sql
-- Creción tabla Pedir_productos
CREATE TABLE IF NOT EXISTS Pedir_Productos (
    id INT(2) PRIMARY KEY
);
DELIMITER $$
DROP EVENT IF EXISTS stock_producto$$
CREATE EVENT stock_producto
ON SCHEDULE
EVERY 1 SECOND
STARTS CURRENT_TIMESTAMP
ENDS CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
DO
BEGIN
	DECLARE num_filas INT DEFAULT 0;
    DECLARE local_producto_no INT DEFAULT 99;
    DECLARE local_suma INT DEFAULT 0;
    DECLARE cuenta_bucle INT DEFAULT 0;
	DECLARE cursor_busca_pedidos CURSOR FOR
		SELECT DISTINCT productos.producto_no, SUM(pedidos.unidades)  as suma
			FROM pedidos, productos
			WHERE pedidos.producto_no = productos.producto_no
				AND pedidos.fecha > (CURDATE() - INTERVAL 7 DAY)
			GROUP BY productos.producto_no;
		SELECT found_rows() INTO num_filas;
			SELECT num_filas;
	OPEN cursor_busca_pedidos;
    FETCH cursor_busca_pedidos INTo local_producto_no, local_suma;
    SELECT local_producto_no, local_suma;
    WHILE cuenta_bucle < num_filas DO
		SET cuenta_bucle = cuenta_bucle + 1;
		SELECT cuenta_bucle, num_filas;
        SELECT productos.stock FROM productos WHERE producto_no = local_producto_no;
		IF (SELECT productos.stock FROM productos WHERE producto_no = local_producto_no) < local_suma
			THEN
				INSERT INTO Pedir_Productos (id) VALUES (local_producto_no);
        END IF;
    END WHILE;
    CLOSE cursor_busca_pedidos;
END $$
```
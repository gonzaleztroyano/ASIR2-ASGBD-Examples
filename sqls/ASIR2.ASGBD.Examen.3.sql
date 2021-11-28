-- Sobre la base de datos ventas.
-- • Crea un evento que una vez al año ( Cada 31 de diciembre) compruebe cuantos
-- pedidos han hecho los clientes durante ese año.
-- • Si los clientes han hecho mas de dos pedidos se le sumará en el haber una
-- cantidad en euros por cada pedido que han hecho de los productos con código del
-- 10 al 30. Esta oferta es sólo para los clientes que son de Sevilla o Cadiz.
-- • La cantidad exacta que se le ingresará al cliente por cada pedido que cumpla las
--  condiciones anteriores se guarda en una tabla llamada ofertas

DROP TABLE IF EXISTS ofertas;
CREATE TABLE ofertas(
	cli_no INT,
    anio INT,
    pedidos INT);

DELIMITER $$
DROP EVENT IF EXISTS ofertas_31_dic$$
CREATE EVENT ofertas_31_dic ON SCHEDULE
EVERY 1 YEAR
STARTS "2021-12-31 05:00:00"
DO
BEGIN
	DECLARE num_filas INT DEFAULT 0;
	DECLARE local_suma INT DEFAULT 0;
	DECLARE local_cli_no INT;
    DECLARE local_pedidos INT;
    DECLARE cursos_pedidos_oferta CURSOR FOR
	SELECT cli_no, COUNT(pedido_no) as pedidos
		FROM ventasleon.pedidos
		WHERE fecha > (DATE_SUB(CURDATE(), INTERVAL 1 YEAR)) 
		AND producto_no BETWEEN 10 AND 30
		GROUP BY cli_no HAVING sum(pedido_no)> 2;
	SELECT FOUND_ROWS() INTO num_filas;
    OPEN cursos_pedidos_oferta;
    WHILE cuenta_bucle < num_filas DO
		BEGIN 
			 FETCH cursos_pedidos_oferta INTO local_cli_no, local_pedidos;
             INSERT INTO ofertas (cli_no,anio,pedidos) VALUES (local_cli_no,YEAR(CURDATE()));
        END;
    END WHILE;
    CLOSE cursos_pedidos_oferta;
END $$
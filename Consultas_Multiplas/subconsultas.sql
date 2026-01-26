-- SUBCONSULTAS

USE loja_informatica;

-- Subconsulta WHERE
SELECT nome
FROM cliente
WHERE id_cliente IN (SELECT id_cliente FROM pedido)
GROUP BY nome;

SELECT DISTINCT c.nome
FROM cliente c
INNER JOIN pedido pe ON c.id_cliente = pe.id_cliente;

SELECT nome, email
FROM cliente
WHERE id_cliente IN (SELECT id_cliente
					FROM pedido
                    WHERE quantidade > 5);

-- Subconsultas SELECT
SELECT nome, 
	(SELECT COUNT(*) FROM pedido WHERE pedido.id_cliente = cliente.id_cliente) AS total_pedidos
FROM cliente;

SELECT c.nome, c.email,
	(SELECT SUM(pe.quantidade * pr.preco)
    FROM pedido pe
    JOIN produto pr ON pe.id_produto = pr.id_produto
    WHERE pe.id_cliente = c.id_cliente) AS total_pedido
FROM cliente c
ORDER BY total_pedido DESC;

-- Subconsulta HAVING
SELECT categoria, AVG(preco) AS media_preco
FROM produto
GROUP BY categoria
HAVING AVG(preco) > (SELECT AVG(preco) FROM produto);

-- Subconsulta FROM
SELECT cl.nome, pedidos_agregados.total_pedidos, pedidos_agregados.soma_quantidade
FROM cliente c
JOIN (
	SELECT id_cliente, COUNT(*) AS total_pedidos, SUM(quantidade) AS soma_quantidade
    FROM pedido
    GROUP BY id_cliente
) AS pedidos_agregados ON c.id_cliente = pedidos_agregados.id_cliente;

-- Subconsulta ORDER BY
SELECT c.nome, c.email
FROM cliente c
ORDER BY (
	SELECT SUM(pe.quantidade * pr.preco)
    FROM pedido pe JOIN produto pr ON pe.id_produto = pr.id_produto WHERE pe.id_cliente = c.id_cliente
) DESC;
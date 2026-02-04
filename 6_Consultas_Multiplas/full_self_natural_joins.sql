-- FULL JOIN, NATURAL JOIN E SELF JOIN

USE loja_informatica;

-- LEFT JOIN
SELECT c.nome, pe.id_pedido
FROM cliente c
LEFT JOIN pedido pe ON c.id_cliente = pe.id_cliente;

-- RIGHT JOIN
SELECT c.nome, pe.id_pedido
FROM cliente c
RIGHT JOIN pedido pe ON c.id_cliente = pe.id_cliente;

-- FULL JOIN
SELECT c.nome, pe.id_pedido
FROM cliente c
LEFT JOIN pedido pe ON c.id_cliente = pe.id_cliente
WHERE pe.id_pedido IS NULL
UNION
SELECT c.nome, pe.id_pedido
FROM cliente c
RIGHT JOIN pedido pe ON c.id_cliente = pe.id_cliente
WHERE c.id_cliente IS NULL;

SELECT c.nome AS cliente, p.nome AS produto, pe.quantidade
FROM cliente c
LEFT JOIN pedido pe ON c.id_cliente = pe.id_cliente
LEFT JOIN produto p ON pe.id_pedido
UNION
SELECT c.nome AS cliente, p.nome AS produto, pe.quantidade
FROM cliente c
RIGHT JOIN pedido pe ON c.id_cliente = pe.id_cliente
RIGHT JOIN produto p ON pe.id_produto = p.id_produto;

-- Natural Join 

SELECT *
FROM pedido
NATURAL JOIN produto; -- Não recomendado para uso em produção

-- Self join

-- Comparar clientes dentro de uma mesma cidade, excluindo comparações do mesmo cliente
SELECT
	c1.nome AS Cliente1,
    c2.nome AS Cliente2,
    c1.cidade AS CidadeComum
FROM
	cliente c1
JOIN 
	cliente c2 ON c1.cidade = c2.cidade AND c1.id_cliente != c2.id_cliente
ORDER BY c1.cidade, c1.nome, c2.nome;
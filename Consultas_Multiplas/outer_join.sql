-- OUTER JOIN

USE loja_informatica;
 
SELECT * FROM cliente LIMIT 10;
SELECT * FROM produto LIMIT 10;
SELECT * FROM pedido LIMIT 20;

-- INNER JOIN: Visualizar clientes com pedidos
SELECT c.nome, pe.id_pedido
FROM cliente c
INNER JOIN pedido pe ON pe.id_cliente = c.id_cliente
ORDER BY c.nome;

SELECT c.nome, COUNT(pe.id_pedido) AS quantidade_pedidos
FROM cliente c
INNER JOIN pedido pe ON pe.id_cliente = c.id_cliente
GROUP BY c.nome
ORDER BY c.nome;

-- LEFT OUTER JOIN: Visualizar todos os clientes, incluindo aqueles sem pedidos
SELECT c.nome, pe.id_pedido
FROM cliente c
LEFT JOIN pedido pe ON c.id_cliente = pe.id_cliente
ORDER BY c.nome; 

-- RIGHT OUTER JOIN: Visualizar todos s pedidos, incluindo sem clientes
SELECT c.nome, pe.id_pedido
FROM cliente c
RIGHT JOIN pedido pe ON c.id_cliente = pe.id_cliente;

-- LEFT OUTER JOIN: Visualizar clientes sem pedido
SELECT c.*
FROM cliente c
LEFT JOIN pedido pe ON c.id_cliente = pe.id_cliente
WHERE pe.id_pedido IS NULL;

-- Visualizar todos os clientes, com seus pedidos e produtos, incluindo aqueles sem pedidos e produtos
SELECT c.nome, pe.id_pedido, p.nome AS produto
FROM cliente c
LEFT JOIN pedido pe ON c.id_cliente = pe.id_cliente
LEFT JOIN produto p ON p.id_produto = pe.id_produto;

desc pedido;
-- Calcule o total gasto por cada cliente em seus pedidos
SELECT c.nome, SUM(p.preco * pe.quantidade) AS total_gasto
FROM cliente c
INNER JOIN pedido pe ON c.id_cliente = pe.id_cliente
INNER JOIN produto p ON pe.id_produto = p.id_produto
GROUP BY c.nome;

-- Visualizar quais clientes não gastaram em seus pedidos (erro)
SELECT c.nome, SUM(p.preco * pe.quantidade) AS total_gasto
FROM cliente c
LEFT JOIN pedido pe ON c.id_cliente = pe.id_cliente
LEFT JOIN produto p ON pe.id_produto = p.id_produto
WHERE p.preco IS NULL OR p.preco = 0
GROUP BY c.nome;
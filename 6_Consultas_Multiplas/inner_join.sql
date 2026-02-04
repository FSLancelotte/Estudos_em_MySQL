 /*
 
 Inner Join
 
 */
 
 USE loja_informatica;
 
 SELECT * FROM cliente LIMIT 10;
 SELECT * FROM produto LIMIT 10;
 SELECT * FROM pedido LIMIT 20;
 
 -- INNER JOIN entre cliente e pedido
 SELECT cliente.nome, cliente.email, pedido.id_pedido
 FROM cliente
 INNER JOIN pedido
 ON cliente.id_cliente = pedido.id_cliente;
 
 -- INNER JOIN entre pedido e produto
 SELECT pedido.id_pedido, produto.nome, produto.preco, pedido.quantidade
 FROM pedido
 INNER JOIN produto
 ON pedido.id_produto = produto.id_produto;
 
 -- INNER JOIN entre cliente, pedido e produto
 SELECT cliente.nome AS cliente, produto.nome AS produto, produto.preco, pedido.quantidade, pedido.data
 FROM cliente
 INNER JOIN pedido on cliente.id_cliente = pedido.id_cliente
 INNER JOIN produto on pedido.id_produto = produto.id_produto;
 
 -- Alias para tableas
SELECT c.nome AS cliente, p.nome AS produto, p.preco, pe.quantidade, pe.data
FROM cliente c
INNER JOIN pedido pe ON c.id_cliente = pe.id_cliente
INNER JOIN produto p ON pe.id_produto = p.id_produto;

SELECT c.nome AS cliente, p.nome AS produto, p.preco, pe.quantidade, pe.data
FROM cliente c
INNER JOIN pedido pe ON c.id_cliente = pe.id_cliente
INNER JOIN produto p ON pe.id_produto = p.id_produto
WHERE p.preco > 1000
GROUP BY p.nome, c.nome, p.preco, pe.quantidade, pe.data
ORDER BY p.preco DESC;


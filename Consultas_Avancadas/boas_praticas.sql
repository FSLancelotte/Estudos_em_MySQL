-- Boas Práticas

USE loja_informatica;

-- Utilizar Alias simples e fácil de entender
SELECT pe.id_pedido, c.nome AS nome_cliente, p.nome AS nome_produto, ROUND(COALESCE(pe.quantidade*p.preco, 0), 2) AS valor_total
FROM cliente c
JOIN pedido pe ON c.id_cliente = pe.id_cliente
JOIN produto p ON pe.id_produto = p.id_produto;

-- Evitar o uso de SELECT *
SELECT nome, email FROM cliente;

SELECT c.nome, c.email
FROM cliente c;

-- Usar EXPLAIN para otimizar consultas e INDICES
EXPLAIN
SELECT c.nome, c.email,
	(SELECT SUM(pe.quantidade * pr.preco)
	FROM pedido pe
    JOIN produto pr ON pe.id_produto = pr.id_produto
    WHERE pe.id_cliente = c.id_cliente) AS total_pedido
FROM cliente c
ORDER BY total_pedido DESC; 

EXPLAIN
SELECT c.nome, c.email, SUM(pe.quantidade * pr.preco) AS total_pedido
FROM cliente c
LEFT JOIN pedido pe ON c.id_cliente = pe.id_cliente
LEFT JOIN produto pr ON pe.id_produto = pr.id_produto
GROUP BY c.id_cliente, c.nome, c.email
ORDER BY total_pedido DESC;

EXPLAIN
SELECT c.nome, c.email, SUM(pe.quantidade * pr.preco) AS total_pedido
FROM cliente c
JOIN pedido pe ON c.id_cliente = pe.id_cliente
JOIN produto pr ON pe.id_produto = pr.id_produto
GROUP BY c.id_cliente, c.nome, c.email
ORDER BY total_pedido DESC;

CREATE INDEX idx_pedido_produto ON pedido(id_produto); -- Criação de Indice
DROP INDEX idx_pedido_produto ON pedido; -- Deletar Indices

-- Evitar funções em colunas no where
SELECT * FROM pedido WHERE MONTH(data) = 1; -- ineficiente

SELECT * FROM pedido WHERE data BETWEEN '2023-01-01' AND '2023-01-31'; -- eficiente

-- Uso de transações para garantir integridade e a confiabilidade nos dados

-- Iniciar transação
START TRANSACTION;

INSERT INTO cliente(id_cliente, nome, email, cidade) VALUES (101, 'Rodrigo Augusto', 'rodrigo.augusto@email.com', 'São José dos Campos');
INSERT INTO pedido(id_pedido, id_cliente, id_produto, quantidade, data) VALUES (203, 101, 7, 3, '2023-11-27');

-- Confirmar as operações
COMMIT;
-- REVERTER as operações
ROLLBACK;

SELECT * FROM cliente WHERE id_cliente="101";
SELECT * FROM pedido WHERE id_pedido="203";
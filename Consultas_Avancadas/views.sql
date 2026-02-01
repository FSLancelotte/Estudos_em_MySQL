-- Aula de Views

USE loja_informatica;

SELECT * FROM cliente LIMIT 10;
SELECT * FROM produto LIMIT 10;
SELECT * FROM pedido LIMIT 20;

-- View para simplificar a tabela cliente
CREATE VIEW cliente_simples AS
SELECT id_cliente, nome, email
FROM cliente; 

-- Consultar View
SELECT * FROM cliente_simples LIMIT 10;

-- Visualizar estrutura da View
SHOW CREATE TABLE cliente_simples;
SHOW CREATE TABLE cliente;

desc cliente_simples;
desc cliente;
 
-- Manipular dados igual tabelas (UPDATE, INSERT e DELETE)

-- Atualizar View
CREATE OR REPLACE VIEW cliente_simples AS
SELECT id_cliente, nome, cidade
FROM cliente;

SELECT * FROM cliente_simples LIMIT 10;

-- Deletar View
DROP VIEW cliente_simples;

-- View para calcular o total de pedidos feitos por cada cliente
CREATE VIEW cliente_pedido_total AS
SELECT c.nome, COUNT(pe.id_pedido) AS total_pedidos
FROM cliente c
LEFT JOIN pedido pe ON c.id_cliente = pe.id_cliente
GROUP BY c.nome;

SELECT * FROM cliente_pedido_total WHERE total_pedidos > 15;

-- View para listar detalhes do cliente e Total Gasto
CREATE VIEW cliente_total_gasto AS
SELECT c.nome, c.email, COUNT(pe.id_pedido) AS total_pedidos, SUM(pe.quantidade * pr.preco) AS total_gasto
FROM cliente c
JOIN pedido pe ON pe.id_cliente = c.id_cliente
JOIN produto pr ON pe.id_produto = pr.id_produto
GROUP BY c.nome, c.email;


SELECT * FROM cliente_total_gasto WHERE total_gasto > 500;
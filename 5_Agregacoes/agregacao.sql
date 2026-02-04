/*
Projeto prático do módulo de agregação

Tarefas realizadas:

1- Use o banco de dados restaurante;
2- Calcule a quantidade de pedidos;
3- Calcule a quantidade de clientes únicos que realizaram pedidos;
4- Calcule a média de preço dos produtos;
5- Calcule o mínimo e máximo do preço dos produtos;
6- Selecione o nome e o preço do produto e faça um rank dos 5 produtos mais caros;
7- Selecione a média dos preços dos produtos agrupados por categoria;
8- Selecionar o fornecedor e a quantidade de produtos que vieram daquele fornecedor da informações de produtos;
9- Selecionar os fornecedores que possuem mais de um produto cadastrado;
10- Selecionar os clientes que realizaram apenas 1 pedido.
*/

USE restaurante;

SELECT count(*) FROM pedidos;

-- Algumas linhas de DESCRIBE para verificar a estrutura das tabelas e usar de referência na construção dos scripts
DESC clientes;
DESC pedidos;
DESC produtos;
DESC info_produtos;

SELECT id_cliente, COUNT(id_cliente) FROM pedidos GROUP BY id_cliente;

SELECT ROUND(AVG(preco), 2) AS media_precos FROM produtos;

SELECT MIN(preco) AS preco_minimo, MAX(preco) AS preco_maximo FROM produtos;

SELECT nome, preco, ROW_NUMBER() OVER (ORDER BY preco DESC) AS ranking_preco FROM produtos LIMIT 5;

SELECT categoria, ROUND(AVG(preco), 2) AS media_preco FROM produtos GROUP BY categoria;

SELECT fornecedor, COUNT(fornecedor) AS quantidade_fornecida FROM info_produtos GROUP BY fornecedor;

SELECT fornecedor, COUNT(DISTINCT id_produto) AS produtos_cadastrados 
FROM info_produtos 
GROUP BY fornecedor 
HAVING produtos_cadastrados > 1;

SELECT id_cliente, COUNT(DISTINCT id_produto) AS produtos_distintos_comprados
FROM pedidos
GROUP BY id_cliente
HAVING produtos_distintos_comprados = 1;
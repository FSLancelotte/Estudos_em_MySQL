-- Agregações

-- Preparação do BD

CREATE DATABASE loja_informatica;
USE loja_informatica;

CREATE TABLE IF NOT EXISTS cliente (
	id_cliente INT PRIMARY KEY,
    nome VARCHAR(200),
    email VARCHAR(100),
    cidade VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS produto(
	id_produto INT PRIMARY KEY,
    nome VARCHAR(200),
    categoria VARCHAR(100),
    preco DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS pedido(
	id_pedido INT PRIMARY KEY,
    id_cliente INT,
    id_produto INT,
    quantidade INT,
    data DATE,
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);


INSERT INTO cliente SELECT * FROM backup_cliente;
INSERT INTO produto SELECT * FROM backup_produto;
INSERT INTO pedido SELECT * FROM backup_pedido; -- ERRADO

INSERT INTO pedido
SELECT id_pedido, id_cliente, id_produto, quantidade, STR_TO_DATE(data, '%d/%m/%Y') FROM backup_pedido;

SELECT * FROM backup_cliente LIMIT 10;
SELECT * FROM backup_produto LIMIT 10;
SELECT * FROM backup_pedido LIMIT 10;


-- Funções de agregação

SELECT * FROM cliente LIMIT 10;
SELECT * FROM produto LIMIT 10;
SELECT * FROM pedido LIMIT 20;

SELECT COUNT(*) FROM pedido; -- Eficiente para contagem de linhas
SELECT COUNT(quantidade) FROM pedido; -- Conta registros não nulos
SELECT COUNT(id_pedido) FROM pedido; 
SELECT COUNT(DISTINCT id_cliente) FROM pedido;

SELECT SUM(quantidade) FROM pedido;
SELECT AVG(quantidade) FROM pedido;

SELECT MAX(preco) FROM produto;
SELECT MIN(preco) FROM produto;

SELECT VAR_POP(preco) FROM produto; -- Variância populacional = VARIANCE()
SELECT VAR_SAMP(preco) FROM produto; -- Variância amostral

SELECT STDDEV(preco) FROM produto; -- Desvio Padrão = STDDEV_POP; Desvio Padrão Amostral = STDDEV_SAMP

SELECT GROUP_CONCAT(DISTINCT quantidade) FROM pedido;
SELECT GROUP_CONCAT(DISTINCT id_produto) FROM pedido;

SELECT nome, preco, RANK() OVER (ORDER BY preco DESC) AS ranking_preco FROM produto;
SELECT nome, preco, ROW_NUMBER() OVER (ORDER BY preco DESC) AS ranking_preco FROM produto;
SELECT nome, preco, DENSE_RANK() OVER (ORDER BY preco DESC) AS ranking_preco FROM produto;
SELECT DISTINCT nome, preco, DENSE_RANK() OVER (ORDER BY preco DESC) AS ranking_preco FROM produto LIMIT 10;


-- Agrupando Resultados

SELECT * FROM cliente LIMIT 10;
SELECT * FROM produto LIMIT 10;
SELECT * FROM pedido LIMIT 20;

SELECT SUM(preco) AS preco_total FROM produto;
SELECT SUM(preco) AS preco_total FROM produto GROUP BY categoria;
SELECT categoria, SUM(preco) AS preco_total FROM produto GROUP BY categoria;
SELECT categoria, nome, SUM(preco) AS preco_total FROM produto GROUP BY categoria, nome ORDER BY categoria, nome;

SELECT categoria, AVG(preco) AS media_preco FROM produto GROUP BY categoria;
SELECT categoria, ROUND(AVG(preco), 2) AS media_preco FROM produto GROUP BY categoria ORDER BY media_preco DESC;

SELECT
	DISTINCT nome, -- trocar categoria
    preco,
    DENSE_RANK() OVER (ORDER BY preco DESC) AS ranking_preco
FROM produto;

SELECT
	categoria,
    SUM(preco) AS preco_total,
    RANK() OVER (ORDER BY SUM(preco) DESC) AS ranking_preco
FROM produto
GROUP BY categoria;


-- Filtrando agregações

SELECT * FROM cliente LIMIT 10;
SELECT * FROM produto LIMIT 10;
SELECT * FROM pedido LIMIT 20;

SELECT categoria, COUNT(*) FROM produto GROUP BY categoria;
SELECT categoria, COUNT(*) FROM produto GROUP BY categoria HAVING COUNT(*) > 10;

SELECT categoria, COUNT(*) FROM produto WHERE categoria <> 'Acessórios' GROUP BY categoria;

SELECT categoria, COUNT(*) FROM produto WHERE categoria <> 'Acessórios' GROUP BY categoria HAVING COUNT(*) > 10; -- Preferível restringir no WHERE
SELECT categoria, COUNT(*) FROM produto GROUP BY categoria HAVING COUNT(*) > 10 AND categoria <> 'Acessórios'; 

-- Resolução de Problema:
-- Identificar quais produtos foram vendidos mais de uma vez com erro (quantidade = 0)

SELECT * FROM pedido;
desc pedido;

SELECT id_pedido FROM pedido WHERE quantidade IS NULL;
SELECT COUNT(*) FROM pedido WHERE quantidade IS NULL;

SELECT id_produto, COUNT(*) FROM pedido WHERE quantidade IS NULL GROUP BY id_produto;
SELECT id_produto, COUNT(*) FROM pedido WHERE quantidade IS NULL GROUP BY id_produto HAVING COUNT(id_produto)>1; 
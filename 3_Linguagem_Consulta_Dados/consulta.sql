-- 1: Use o banco de dados restaurante
use restaurante;

-- 2: Selecione o nome e a categoria dos produtos que tem o preço superior a 30
SELECT * FROM produtos LIMIT 5;
SELECT nome, categoria FROM produtos WHERE preco > 30;

-- 3: Selecione o nome, telefone e data de nascimento dos clientes que nasceram antes do ano de 1985
SELECT nome, telefone, data_nascimento FROM clientes WHERE year(data_nascimento) < 1985 ORDER BY data_nascimento; 

-- 4: Selecione o id do produto e os ingredientes de informações de produto para os ingredientes que contenham a palavra "carne"
SELECT * FROM info_produtos LIMIT 5;
SELECT id_produto, ingredientes FROM info_produtos WHERE ingredientes LIKE '%carne%';

-- 5: Selecione o nome e a categoria dos produtos ordenados em ordem alfabética por categoria, para cada categoria deve ser ordenado pelo nome do produto
SELECT nome, categoria FROM produtos ORDER BY categoria, nome;

-- 6: Selecione os 5 produtos mais caros do restaurante
SELECT nome, descricao, preco, categoria FROM produtos ORDER BY preco DESC limit 5;

-- 7: A cada dia da semana 2 pratos principais estão na promoção, hoje você deve selecionar 2 produtos da categoria 'Prato Principal' e pular 6 registros (offset = 5)
SELECT nome, descricao, preco, categoria FROM produtos WHERE categoria = 'Prato Principal' LIMIT 2 OFFSET 5;

-- 8: Faça backup dos dados da tabela pedidos com o nome de backup_pedidos.
CREATE TABLE backup_pedidos AS SELECT * FROM pedidos;
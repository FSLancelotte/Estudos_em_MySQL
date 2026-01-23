/*
Tarefas requisitadas:

1- Use o banco de dados restaurante
2- Selecione todos os pedidos que do id funcionário igual a 4 e status é igual a ‘Pendente’
3- Selecione todos os pedidos que o status não é igual a ‘Concluído’
4- Selecione os pedidos que contenham os id produtos: 1, 3, 5, 7 ou 8
5- Selecione os clientes que começam com a letra c
6- Selecione as informações de produtos que contenham nos ingredientes ‘carne’ ou ‘frango’
7- Selecione os produtos com o preço entre 20 a 30
8- Atualizar id pedido 6 da tabela pedidos para status = NULL
9- Selecione os pedidos com status nulos
10- Selecionar o id pedido e o status da tabela pedidos, porém para todos os status nulos, mostrar 'Cancelado'
11- Selecione o nome, cargo, salário dos funcionários e adicione um campo chamado media_salario, que irá mostrar 
‘Acima da média’, para o salário > 3000, senão 'Abaixo da média'
*/

use restaurante;

SELECT * FROM pedidos WHERE id_funcionario = 4 AND status = 'Pendente';

SELECT * FROM pedidos WHERE NOT status = 'Concluído'; -- Também funcionaria: ...WHERE status <> 'Concluído'

SELECT * FROM pedidos WHERE id_produto IN (1, 3, 5, 7, 8);

SELECT nome from clientes WHERE nome LIKE 'C%';

SELECT * FROM info_produtos WHERE ingredientes LIKE '%carne%' OR ingredientes LIKE '%frango%';

SELECT * FROM produtos WHERE preco BETWEEN 20 and 30;


SELECT * FROM pedidos WHERE id_pedido = 6;
UPDATE pedidos
SET status = NULL
WHERE id_pedido = 6;

SELECT * FROM pedidos WHERE status IS NULL;

SELECT id_pedido, ifnull(status, 'Cancelado') as status FROM pedidos;

SELECT nome, cargo, salario,
	CASE
		WHEN salario > 3000 THEN 'Acima da média'
        ELSE 'Abaixo da média'
	END AS media_salario
FROM funcionarios;
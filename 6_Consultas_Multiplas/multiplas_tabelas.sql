/*
Tarefas executadas neste projeto:
1- Use o banco de dados restaurante e crie os joins ou subconsultas

2- Selecionar:
	produtos: id, nome e descrição
	info_produtos:  ingredientes
        
3- Selecionar:
	pedidos:  id, quantidade e data
	clientes: nome e email

4- Selecionar:
	pedidos:  id, quantidade e data
	clientes: nome e email
	funcionarios: nome

5- Selecionar:
	pedidos:  id, quantidade e data
	clientes: nome e email
	funcionarios: nome
	produtos: nome, preco

6- Selecionar o nome dos clientes com os pedidos com status ‘Pendente’ e 
	exibir por ordem descendente de acordo com o id do pedido

7- Selecionar clientes sem pedidos

8- Selecionar o nome do cliente e o total de pedidos cada cliente

9- Selecionar o preço total (quantidade*preco) de cada pedido

*/

USE restaurante;

SELECT p.id_produto, p.nome, p.descricao, i.ingredientes
FROM produtos p
JOIN info_produtos i ON i.id_produto = p.id_produto;

SELECT * FROM pedidos LIMIT 5;
SELECT p.id_pedido, p.quantidade, p.data_pedido, c.nome, c.email
FROM pedidos p
JOIN clientes c ON c.id_cliente = p.id_cliente;

SELECT p.id_pedido, p.quantidade, p.data_pedido, c.nome AS cliente, c.email AS email_cliente, f.nome AS funcionario
FROM pedidos p
JOIN clientes c ON c.id_cliente = p.id_cliente
JOIN funcionarios f ON f.id_funcionario = p.id_funcionario;

SELECT pe.id_pedido, pe.quantidade, pe.data_pedido,
		c.nome AS cliente, c.email AS email_cliente,
		f.nome AS funcionario,
		pr.nome AS produto, pr.preco
FROM pedidos pe
JOIN clientes c ON c.id_cliente = pe.id_cliente
JOIN funcionarios f ON f.id_funcionario = pe.id_funcionario
JOIN produtos pr ON pr.id_produto = pe.id_produto;

SELECT c.nome
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente
WHERE p.status = 'Pendente'
ORDER BY p.id_pedido DESC;

SELECT c.nome
FROM clientes c
LEFT OUTER JOIN pedidos p ON c.id_cliente = p.id_cliente
WHERE p.id_pedido IS NULL; 

SELECT c.nome, COUNT(p.id_cliente) AS total_pedidos
FROM clientes c
LEFT JOIN pedidos p ON p.id_cliente = c.id_cliente
GROUP BY c.nome;

SELECT pe.id_pedido, SUM(pr.preco * pe.quantidade) AS valor_total
FROM pedidos pe
JOIN produtos pr ON pe.id_produto = pr.id_produto
GROUP BY pe.id_pedido
ORDER BY id_pedido;
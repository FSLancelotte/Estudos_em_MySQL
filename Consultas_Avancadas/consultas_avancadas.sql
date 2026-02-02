/*
Tarefas executadas neste projeto:
1- Use o banco de dados restaurante

2- Crie uma view chamada resumo_pedido unindo as tabelas:
    pedidos: id, quantidade e data
    clientes: nome e email
    funcionarios: nome
    produtos: nome, preco

3- Selecionar o id do pedido, nome do cliente e o cálculo do total (quantidade * preco) da view resumo_pedido

4- Atualizar a view resumo_pedido para incluir o campo total (calculado)

5- Repetir a consulta da tarefa 3, mas utilizando o novo campo total da view

6- Utilizar o comando EXPLAIN na consulta anterior para analisar o JOIN oculto da query

7- Crie uma função chamada ‘BuscaIngredientesProduto’ para retornar os ingredientes de info_produtos via id_produto

8- Executar a função ‘BuscaIngredientesProduto’ para o produto ID 10

9- Crie uma função chamada ‘mediaPedido’ para comparar o total de um pedido com a média geral (Acima, Abaixo ou Igual)

10- Executar a função ‘mediaPedido’ para os pedidos ID 5 e ID 6
*/

USE restaurante;

CREATE VIEW resumo_pedido AS
SELECT c.nome AS cliente, c.email, pe.id_pedido, pe.quantidade, pe.data_pedido,
		f.nome, pr.nome AS produto, pr.preco
FROM pedidos pe
JOIN clientes c ON c.id_cliente = pe.id_cliente
JOIN produtos pr ON pe.id_produto = pr.id_produto
JOIN funcionarios f ON pe.id_funcionario = f.id_funcionario;

SELECT id_pedido, cliente, SUM(quantidade * preco) AS total
FROM resumo_pedido
GROUP BY id_pedido;

CREATE OR REPLACE VIEW resumo_pedido AS
SELECT c.nome AS cliente, c.email, pe.id_pedido, pe.quantidade, pe.data_pedido,
		f.nome, pr.nome AS produto, pr.preco, SUM(pe.quantidade * pr.preco) AS total
FROM pedidos pe
JOIN clientes c ON c.id_cliente = pe.id_cliente
JOIN produtos pr ON pe.id_produto = pr.id_produto
JOIN funcionarios f ON pe.id_funcionario = f.id_funcionario
GROUP BY pe.id_pedido;

SELECT id_pedido, cliente, total
FROM resumo_pedido;

EXPLAIN
SELECT id_pedido, cliente, total
FROM resumo_pedido;

DESC info_produtos;

DELIMITER //
CREATE FUNCTION BuscaIngredientesProduto(produtoID INT)
RETURNS TEXT
READS SQL DATA
BEGIN
	DECLARE ingredientesInclusos TEXT;
    
    SELECT ingredientes INTO ingredientesInclusos FROM info_produtos WHERE id_produto = produtoID;
    
    RETURN IFNULL(ingredientesInclusos, 'Ingredientes não localizados');
END //
DELIMITER ;

SELECT BuscaIngredientesProduto(10) AS ingredientes;

DELIMITER //
CREATE FUNCTION mediaPedido(pedidoID INT)
RETURNS VARCHAR(20)
READS SQL DATA
BEGIN
	DECLARE avaliacao VARCHAR(20);
    DECLARE totalPedido DECIMAL(10,2);
    DECLARE mediaPedidos DECIMAL(10,2);
    
    SELECT total INTO totalPedido FROM resumo_pedido WHERE id_pedido = pedidoID;
	SELECT AVG(total) INTO mediaPedidos FROM resumo_pedido;
    
    SET avaliacao =
    CASE 
		WHEN totalPedido > mediaPedidos THEN 'Acima da média'
        WHEN totalPedido < mediaPedidos THEN 'Abaixo da média'
        ELSE 'Igual a média'
	END;
    
    RETURN avaliacao;
END //
DELIMITER ;

SELECT mediaPedido(5);
SELECT mediaPedido(6);
-- Procedimentos armazenados

USE loja_informatica;

SELECT * FROM cliente LIMIT 10;
SELECT * FROM produto LIMIT 10;
SELECT * FROM pedido LIMIT 20;

-- Procedimento armazenado para listar todos os clientes
CREATE PROCEDURE ListarClientes()
	SELECT * FROM cliente;

-- Chamar o procedimento armazenado
CALL ListarClientes();

-- Procedimento armazenado para inserir um novo pedido
DELIMITER //
CREATE PROCEDURE AdicionarPedido(IN pedidoID INT, IN clienteID INT, IN produtoID INT, IN qtd INT, IN dataPedido DATE)
BEGIN
	INSERT INTO pedido(id_pedido, id_cliente, id_produto, quantidade, data) VALUES (pedidoID, clienteID, produtoID, qtd, dataPedido);
    INSERT INTO backup_pedido(ID_Pedido, ID_Cliente, ID_Produto, Quantidade, Data) VALUES (pedidoID, clienteID, produtoID, qtd, dataPedido);
END //
DELIMITER ;

CALL AdicionarPedido(201, 1, 2, 10, '2024-03-01');

SELECT * FROM pedido WHERE id_pedido = 201;
SELECT * FROM backup_pedido WHERE id_pedido = 201;

DELETE FROM pedido WHERE id_pedido = 201;
DELETE FROM backup_pedido WHERE ID_Pedido = 201;

/* Procedimento armazenado para vizualizar novos preços sem alterar a tabela produto
e visualizar a quantidade de registros */
DELIMITER //
CREATE PROCEDURE PromocaoProdutos(IN desconto FLOAT, OUT totalProdutos INT)
BEGIN
	DECLARE fator_desconto FLOAT;
    SET fator_desconto = (1 - (desconto/100));
    
    SELECT COUNT(*) INTO totalProdutos
    FROM produto;

	SELECT id_produto, nome, preco AS preco_original, ROUND(preco * fator_desconto, 2) AS preco_com_desconto
    FROM produto;
END //
DELIMITER ;

CALL PromocaoProdutos(5, @totalProdutos);
SELECT @totalProdutos AS total_produtos_alterados;

-- Mostrar todos os procedimentos
SHOW PROCEDURE STATUS;

-- Deletar procedimento
DROP PROCEDURE IF EXISTS AdicionarPedido;
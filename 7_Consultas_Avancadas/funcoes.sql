-- Funções

USE loja_informatica;
SELECT * FROM cliente LIMIT 10;
SELECT * FROM produto LIMIT 10;
SELECT * FROM pedido LIMIT 20;

-- Função para retornar o nome de um cliente com base no seu ID
DELIMITER //
CREATE FUNCTION BuscaClienteNome(idCliente INT)
RETURNS VARCHAR(200)
READS SQL DATA
BEGIN
	DECLARE nomeCliente VARCHAR(200);
    SELECT nome INTO nomeCliente FROM cliente WHERE id_cliente = idCliente;
	RETURN nomeCliente;
END //
DELIMITER ;

-- Usar a Função em uma consulta
SELECT BuscaClienteNome(76);

-- Função para calcular o total de vendas de um produto
DELIMITER //
CREATE FUNCTION TotalVendas(produtoID INT)
RETURNS DECIMAL(10, 2)
READS SQL DATA
BEGIN
	DECLARE total DECIMAL(10, 2);
	SELECT SUM(preco * quantidade) INTO total
    FROM pedido
    JOIN produto ON produto.id_produto = pedido.id_produto
    WHERE produto.id_produto = produtoID;
    RETURN total;
END //
DELIMITER ;

SELECT nome, TotalVendas(id_produto) AS total_vendas FROM produto;

-- Função para classificar o desmpenho de vendas de um produto
DELIMITER //
CREATE FUNCTION ClassificaDesempenhoVendas(produtoID INT)
RETURNS VARCHAR(100)
READS SQL DATA
BEGIN
	DECLARE totalVendas DECIMAL(10, 2);
    DECLARE desempenho VARCHAR(100);
    
    SELECT COALESCE(SUM(p.preco * pe.quantidade), 0) INTO totalVendas
    FROM produto p
    LEFT JOIN pedido pe ON p.id_produto = pe.id_produto
    WHERE p.id_produto = produtoID;
    
    SET desempenho =
    CASE
		WHEN totalVendas = 0 THEN 'Sem Vendas'
        WHEN totalVendas <= 1000 THEN 'Baixo'
        WHEN totalVendas <= 5000 THEN 'Médio'
        ELSE 'Alto'
	END;
    
    RETURN desempenho;
END //
DELIMITER ;

SELECT nome, ClassificaDesempenhoVendas(id_produto) AS desempenho_vendas FROM produto;

-- Função para calcular desconto em cima de um valor de produto
DELIMITER //
CREATE FUNCTION CalculaDesconto(valor DECIMAL(10,2), percentualDesconto DECIMAL(5,2))
RETURNS DECIMAL(10,2)
NO SQL
BEGIN
	DECLARE resultado DECIMAL(10, 2);
    SET resultado = valor - (valor *(percentualDesconto / 100));
    RETURN resultado;
END //
DELIMITER ;

SELECT CalculaDesconto(150.00, 5) AS ValorComDesconto;

-- Mostrar todas as funções
SHOW FUNCTION STATUS;	

-- Deletar funções
DROP FUNCTION IF EXISTS CalculaDesconto;
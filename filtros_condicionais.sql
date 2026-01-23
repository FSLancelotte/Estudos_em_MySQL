-- Filtros condicionais

use informatica;

-- AND, OR e NOT

SELECT * FROM cliente;

SELECT * FROM cliente
WHERE cadastro_ativo = TRUE AND limite_credito > 6000;

SELECT * FROM cliente
WHERE cadastro_ativo = TRUE OR limite_credito > 6000;

SELECT * FROM cliente
WHERE limite_credito > 6000 AND YEAR(data_nascimento) > 1980;

SELECT * FROM cliente
WHERE cadastro_ativo = TRUE OR limite_credito > 6000 AND YEAR(data_nascimento) > 1980; -- O and é realizado antes

SELECT * FROM cliente
WHERE (cadastro_ativo = TRUE OR limite_credito > 6000) AND YEAR(data_nascimento) > 1980;

SELECT * FROM cliente WHERE NOT limite_credito > 6000;


-- IN 

SELECT * FROM cliente;

SELECT * FROM cliente WHERE id_cliente IN (1, 2, 4, 6);

SELECT * FROM cliente  WHERE year(data_nascimento) in (1991, 1995);

-- BETWEEN

SELECT * FROM cliente WHERE data_nascimento BETWEEN '1990-01-01' AND '2000-12-31';

SELECT * FROM cliente where limite_credito BETWEEN 6000 AND 10000;


-- LIKE

SELECT * FROM cliente WHERE info_adicionais LIKE 'revisao%';

SELECT * FROM cliente WHERE info_adicionais LIKE '%cadastro'; -- custoso

SELECT * FROM cliente WHERE email LIKE '%@%.com'; 

INSERT INTO cliente(nome, email, data_nascimento, info_adicionais) VALUES
					('A', 'a@a.com', '1990-10-10', ' ');  -- Cadastro Incorreto

SELECT * FROM cliente WHERE email LIKE '__%@__%.com'; 




-- Null e NOT NULL

SELECT * FROM cliente;

SELECT * FROM cliente WHERE info_adicionais IS NULL;

SELECT * FROM cliente
WHERE limite_credito > 5000 AND  (info_adicionais IS NULL OR id_produto IS NULL);

SELECT nome, ifnull(limite_credito, 0) as limite_credito_tratado FROM cliente;

SELECT nome, info_adicionais, ifnull(info_adicionais, 'Nada Consta') as info_adicionais_tratada FROM cliente;

SELECT nome, info_adicionais, nullif(info_adicionais, 'Inativo') as info_adicionais_tratada FROM cliente;

SELECT nome, info_adicionais, nullif(info_adicionais, '') as info_adicionais_tratada FROM cliente;

SELECT nome, ifnull(nullif(info_adicionais, ''), 'Nada Consta') as info_adicionais FROM cliente;

SELECT nome, coalesce(info_adicionais, 'Nada Consta') FROM cliente; 

SELECT nome, coalesce(limite_credito, id_produto, 'Cadastro Nulo') FROM cliente;

SELECT nome, info_adicionais, COALESCE(info_adicionais, 'Não Consta') as info FROM cliente;

-- Tratar espeços em branco

SELECT '       Remover espaços          ', TRIM('       Remover espaços          ');

SELECT nome, info_adicionais FROM cliente WHERE info_adicionais <> TRIM(info_adicionais);

SELECT * FROM cliente
WHERE nullif(trim(info_adicionais), '') IS NULL;

SELECT * FROM cliente
WHERE nullif(info_adicionais, ' ') IS NULL;


-- IF e CASE

SELECT * FROM cliente;

SELECT nome, IF(limite_credito > 6000, 'Alto', 'Baixo') AS categoria_limite FROM cliente;

SELECT
	nome,
    CASE
		WHEN limite_credito > 6000 THEN 'Alto'
        ELSE 'Baixo'
	END AS categoria_limite
FROM cliente;

SELECT id_cliente, nome, limite_credito,
	IF (limite_credito > 9000, 'Premium', 
	IF(limite_credito BETWEEN 5000 AND 9000, 'Gold',
		'Silver')) AS categoria_limite
FROM cliente;

SELECT id_cliente, nome, limite_credito,
	CASE
		WHEN limite_credito > 9000 THEN 'Premium'
        WHEN limite_credito BETWEEN 5000 AND 9000 THEN 'Gold'
        ELSE 'Silver'
	END AS categoria_cliente
FROM cliente;

SELECT id_cliente, nome, limite_credito,
	CASE
		WHEN limite_credito > 9000 THEN 'Premium'
        WHEN limite_credito BETWEEN 5000 AND 9000 THEN 'Gold'
        ELSE 'Silver'
	END AS categoria_cliente
FROM cliente;

SELECT * FROM cliente;
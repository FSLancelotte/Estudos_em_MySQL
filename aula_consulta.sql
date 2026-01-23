-- Consultando dados

use informatica;

desc cliente;

SELECT * FROM cliente;

truncate cliente;

INSERT INTO cliente VALUES
	(NULL, 'Marcos', 'marcos@email.com', '1991-01-05', 8000, NULL, True, 2),
    (NULL, 'Carlos', 'carlos@email.com', '1998-02-26', 5500, NULL, True, 1),
    (NULL, 'Ana', 'ana@email.com', '1980-05-28', 10000.00, 'Revisão de cadastro', True, 1),
    (NULL, 'Jõao', 'joao@email.com', '1995-10-14', 5500.00, 'Inativo', False, NULL),
    (NULL, 'Thiago', 'thiago@email.com', '2001-08-20', 4600, NULL, True, 1);

-- Selecionar todas as colunas de uma tabela    
SELECT * FROM cliente;

-- Selecionar colunas específicas
SELECT nome, email FROM cliente;

-- Criar tablea a partir de seleção de dados (BACKUP*)
CREATE TABLE backup_cliente AS SELECT * FROM cliente;

desc cliente;
desc backup_cliente;

-- Inserindo registros a partir da seleção de dados 
TRUNCATE backup_cliente;
SELECT * FROM backup_cliente;
INSERT INTO backup_cliente SELECT * FROM cliente;
SELECT * FROM backup_cliente;


-- Condição

-- Filtrar por campo numérico
SELECT nome, limite_credito FROM cliente WHERE limite_credito > 5000;

-- Filtrar por campo texto
SELECT nome, limite_credito FROM cliente WHERE nome ='João';
SELECT nome, limite_credito FROM cliente WHERE nome LIKE 'Jo%';

-- Filtrar por campo booleano
SELECT nome, email FROM cliente WHERE cadastro_ativo = TRUE;

-- Filtrar por campo de data
SELECT nome, data_nascimento FROM cliente WHERE data_nascimento > '1991-01-01';

SELECT nome, data_nascimento FROM cliente WHERE year(data_nascimento) >= 1998;


-- Ordenação

-- Ordenar por ordem ascendente (alfabética)
SELECT nome FROM cliente ORDER BY nome ASC;

-- Ordenar por ordem decrescente
SELECT nome, data_nascimento FROM cliente ORDER BY data_nascimento DESC;

-- Ordenar por mais de um campo 
SELECT nome, limite_credito FROM cliente ORDER BY limite_credito DESC, nome ASC;



-- Limitação

-- Selecionar um registro (Boa prática)
SELECT * FROM cliente LIMIT 3;

-- Selecionar os 3 clientes com mais limite de crédito
SELECT nome, limite_credito, email FROM cliente ORDER BY limite_credito DESC LIMIT 3;

-- Pular os primeiros 3 registros e selecionar os próximos 2:
SELECT nome FROM cliente ORDER BY nome LIMIT 2 OFFSET 3;
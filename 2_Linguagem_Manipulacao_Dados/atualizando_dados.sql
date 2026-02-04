-- Atualizando dados

use informatica;

select * from cliente;

-- Atualizar 1 campo
UPDATE cliente 
SET email = 'marcos_novo@email.com'
WHERE id_cliente = 1;

-- Atualzar mutiplos campos
UPDATE cliente 
SET data_nascimento = '1975-04-10', limite_credito = 1000
WHERE id_cliente = 2;

-- Atualizar com operadores matemáticos
UPDATE cliente
SET limite_credito = limite_credito + 500
WHERE id_cliente =3;

-- Atualizar com condições complexas
UPDATE cliente
SET cadastro_ativo = FALSE
WHERE limite_credito <=1000 AND data_nascimento <'1980-01-01';

SET SQL_SAFE_UPDATES = 1;

-- Atualizar todos os registros de uma coluna
UPDATE cliente
set info_adicionais = 'Revisão de cadastro';

select * from cliente;
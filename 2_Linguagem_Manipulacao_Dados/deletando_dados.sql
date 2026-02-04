-- Removendo dados

use informatica;

select * from cliente;

-- Deletar 1 registro
DELETE FROM cliente WHERE id_cliente = 4;

-- Deletar registro com condições múltiplas
DELETE FROM cliente WHERE cadastro_ativo = FALSE and limite_credito < 2000;

-- Deletar todos os registros
DELETE FROM cliente;

SET SQL_SAFE_UPDATES = 1;

TRUNCATE TABLE cliente;

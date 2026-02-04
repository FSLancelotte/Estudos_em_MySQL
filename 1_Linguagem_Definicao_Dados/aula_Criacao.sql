/*
Aula 2
*/

use informatica;

create table if not exists cliente(
	id_cliente INT auto_increment PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    data_nascimento DATE,
    limite_credito decimal (10, 2),
    infor_adicionais TEXT,
    cadastro_ativo BOOLEAN DEFAULT 1,
    id_produto INT,
    UNIQUE (email)
);
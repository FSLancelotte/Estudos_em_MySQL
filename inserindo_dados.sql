use informatica;

drop table cliente;

create table IF NOT EXISTS cliente(
	id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(100),
	data_nascimento DATE,
    limite_credito DECIMAL(10, 2),
    info_adicionais TEXT,
    cadastro_ativo BOOLEAN DEFAULT TRUE,
    id_produto INT,
    UNIQUE (email)
    -- FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

-- Selecionar tabela
SELECT * from cliente;

-- Inserir 1 registro
INSERT INTO cliente (nome, email, data_nascimento, limite_credito) VALUES
					('Marcos', 'marcos@gmail.com', '1991-01-05', 8000.00);

INSERT INTO cliente (nome) VALUES ('Pedro');

-- Inserir multiplos registros
INSERT INTO cliente (nome, email, data_nascimento, limite_credito) VALUES
					('Ana', 'ana@gmail.com', '1980-05-28', 10000),
                    ('João', 'joao@email.com', '1995-10-14', 5000);
                    
-- Inserir registro sem especificar os campos
INSERT INTO cliente VALUES (NULL, 'Thiago', 'thiago@email.com', '1995-08-20', 4600, NULL, TRUE, 1);

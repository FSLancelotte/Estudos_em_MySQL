create database restaurante;
use restaurante;

create table if not exists funcionarios(
	id_funcionario INT auto_increment primary key,
    nome VARCHAR(255),
    cpf VARCHAR(14),
    data_nascimento DATE,
    endereco VARCHAR(255),
    telefone VARCHAR(15),
    email VARCHAR(100),
    cargo VARCHAR(100),
    salario DECIMAL(10, 2),
    data_adimissao DATE
);

create table if not exists clientes(
	id_cliente INT auto_increment primary key,
    nome VARCHAR(255),
    cpf VARCHAR(14),
    data_nascimento DATE,
    endereco VARCHAR(255),
    telefone VARCHAR(15),
	email VARCHAR(100),
    data_cadastro DATE
);

create table if not exists produtos(
	id_produto INT auto_increment primary key,
    nome VARCHAR(255),
    descricao TEXT,
    preco DECIMAL(10, 2),
    categoria VARCHAR(100)
);

create table if not exists pedidos(
	id_pedido INT auto_increment primary key,
    id_cliente INT,
    id_funcionario INT,
    id_produto INT,
    quantidade INT,
    preco DECIMAL(10, 2),
    data_pedido DATE,
    status VARCHAR(50),
    FOREIGN KEY (id_cliente) references clientes(id_cliente), 
    FOREIGN KEY (id_funcionario) references funcionarios(id_funcionario),
    FOREIGN KEY (id_produto) references produtos(id_produto)
);

create table if not exists info_produtos(
	id_info  INT auto_increment primary key,
    id_produto INT,
    ingredientes TEXT,
    fornecedor VARCHAR(255),
    FOREIGN KEY (id_produto) references produtos(id_produto)
);


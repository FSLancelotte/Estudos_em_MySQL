create database informatica;
use informatica;
create table cliente(
	id int,
    nome varchar(50)
);
show tables;

alter table cliente add data_nascimento DATE;

drop table cliente;
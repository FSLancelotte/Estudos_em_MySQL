# Sobre os arquivos CSV


Os arquivos CSV contém os registros do banco de dados e foram utilizados para importação;


# Importação dos arquivos através do MySQL Workbench

> No painel de navegação, vá em "Schemas";
> Clique com o botão direito no banco de dados que se deseja inserir as tabelas;
> Clique em "Table Data Import Wizard";
> Selecione o caminho do arquivo CSV;
> Selecione "Create new table", com o banco correto selecionado e dê um nome à nova tabela;
> Atente-se para os tipos de dados de cada campo. Note que:
	Na importação não existe o tipo float ou decimal, mas o existe o tipo double com o caractere de separação configurável;
	O tipo DATE pode ser preenchido pelo datetime se os campos coincidirem com o formato esperado, caso contrário utilize o tipo text e trate os dados depois;
	Antes da importação, certifique-se de deixar campos vazios com o texto "NULL" para ser corretamente interpretado pelo programa como campos vazios.
	
> Avance para importar os dados e verifique os logs de importação para checar possíveis erros no processo;


# Dados com codificação errônea

É possível que ao importar os dados, mesmo informando que a codificação esteja em UTF-8 (que é o padrão), sua codificação seja interpretada de maneira errônea. Exemplo: nome da cliente 'Patrícia' vindo como 'PatrÃcia' ou o produto 'Placa de Vídeo' vindo como 'Placa de VÃ­deo'.

Para corrigir isso foi criado um script que pode ser executado por completo corrigindo cada linha com erro nas tabelas. 

Este trecho foi realizado com auxílio de uma IA para redução de trabalho manual simples e repetitivo.
Para fins de transparência e demonstração, segue um trecho do prompt utilizado para a execução da tarefa:

Minha lista de produtos está com um problema nos registros e preciso concertá-los. Crie um script que altere os nomes corretamente de acordo com o script deixado abaixo. A lista segue após o script

Script:

UPDATE produto
SET nome = 'Mouse Óptico'
WHERE nome LIKE 'Mouse Ã%';
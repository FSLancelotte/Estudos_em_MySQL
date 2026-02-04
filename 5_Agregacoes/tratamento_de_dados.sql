-- Tratamento dos dados

USE loja_informatica;
SET SQL_SAFE_UPDATES = 0;

SELECT * FROM produto;
SELECT nome FROM produto GROUP BY nome;

UPDATE produto
SET nome = 'Mouse Óptico'
WHERE nome LIKE 'Mouse Ã%';

UPDATE produto
SET nome = 'Teclado Mecânico'
WHERE nome LIKE 'Teclado MecÃ%';

UPDATE produto
SET nome = 'Placa de Vídeo RTX 3080' 
WHERE nome LIKE 'Placa de V%' OR nome LIKE 'Placa de VÃ­deo%';

UPDATE produto 
SET nome = 'Memória RAM 16GB' 
WHERE nome LIKE 'Mem%' OR nome LIKE 'MemÃ³ria%';

UPDATE produto 
SET nome = 'Placa-Mãe B450' 
WHERE nome LIKE 'Placa-M%' OR nome LIKE 'Placa-MÃ£e%';


SELECT categoria FROM produto GROUP BY categoria;

UPDATE produto
SET categoria = 'Acessórios'
WHERE categoria LIKE 'Acess%';


SET SQL_SAFE_UPDATES = 1;
-- 1. a) Crie um banco de dados chamado BD_Teste.

CREATE DATABASE BD_Teste

--	b) Exclua o banco de dados criado no item anterior.

DROP DATABASE BD_Teste

--	c) Crie um banco de dados chamado Exercicios

CREATE DATABASE Exercicios

 /*2. No banco de dados criado no exercício anterior, crie 3 tabelas, cada uma contendo as seguintes
	colunas:

	Tabela 1: dCliente
	- ID_Cliente
	- Nome_Cliente
	- Data_de _Nascimento

	Tabela 2: dGerente
	- ID_Gerente
	- Nome_Gerente
	- Data_de_Contratacao
	- Salario

	Tabela 3: fContratos
	- ID_Contrato
	- Data_de_Assinatura
	- ID_Cliente
	- ID_Gerente
	- Valor_do_Contrato

	Lembre-se dos seguintes pontos:
	a) Garantir que o Banco de Dados Exercicios está selecionado.
	b) Definir qual será o tipo de dados mais adequado para cada coluna das tabelas. Lembrando que
	os tipos de dados mais comuns são: INT, FLOAT, VARCHAR e DATETIME.
	Por fim, faça um SELECT para visualizar cada tabela*/

CREATE TABLE dCliente(ID_Cliente INT,Nome_Cliente VARCHAR(100),Data_de_Nascimento DATETIME)
CREATE TABLE dGerente(ID_Gerente INT,Nome_Gerente VARCHAR(100),Data_de_Contratacao DATETIME,Salario FLOAT)
CREATE TABLE fContratos(ID_Contrato INT,Data_de_Assinatura DATETIME,ID_Cliente INT,ID_Gerente INT,Valor_do_Contrato FLOAT)

SELECT * FROM dCliente
SELECT * FROM dGerente
SELECT * FROM fContratos

-- 3. Em cada uma das 3 tabelas, adicione os seguintes valores:

INSERT INTO dCliente(ID_Cliente,Nome_Cliente,Data_de_Nascimento)
VALUES
	(1,'André Martins','1989-12-02'),
	(2,'Bárbara Campos','1992-07-05'),
	(3,'Carol Freitas','1985-23-04'),
	(4,'Diego Cardoso','1994-11-10'),
	(5,'Eduardo Pereira','1988-09-11'),
	(6,'Fabiana Silva','1989-02-09'),
	(7,'Gustavo Barbosa','1993-27-06'),
	(8,'Helen Viana','1990-11-02')

SELECT * FROM dCliente

INSERT INTO dGerente(ID_Gerente,Nome_Gerente,Data_de_Contratacao,Salario)
VALUES
	(1,'Lucas Sampaio','2015-21-03',6700),
	(2,'Mariana Padilha','2011-10-01',9900),
	(3,'Nathália Santos','2018-03-10',7200),
	(4,'Otávio Costa','2017-18-04',11000)

SELECT * FROM dGerente

INSERT INTO fContratos(ID_Contrato,Data_de_Assinatura,ID_Cliente,ID_Gerente,Valor_do_Contrato)
VALUES
	(1,'2019-12-01',8,1,2300),
	(2,'2019-10-02',3,2,15500),
	(3,'2019-07-03',7,2,6500),
	(4,'2019-15-03',1,3,33000),
	(5,'2019-21-03',5,4,11100),
	(6,'2019-23-03',4,2,5500),
	(7,'2019-28-03',9,3,55000),
	(8,'2019-04-04',2,1,31000),
	(9,'2019-05-04',10,4,3400),
	(10,'2019-05-04',6,2,9200)

SELECT * FROM fContratos


/*4. Novos dados deverão ser adicionados nas tabelas dCliente, dGerente e fContratos. Fique livre
	para adicionar uma nova linha em cada tabela contendo, respectivamente,
	(1) um novo cliente (id cliente, nome e data de nascimento)*/
INSERT INTO 
	dCliente(ID_Cliente,Nome_Cliente,Data_de_Nascimento)
VALUES
	(11,'Arthur Ribas','2017-23-02')
	

	
	--(2) um novo gerente (id gerente, nome, data de contratação e salário)
INSERT INTO 
	dCliente(ID_Cliente,Nome_Cliente,Data_de_Nascimento)
VALUES
	(11,'Arthur Ribas','2017-23-02')
	(3) um novo contrato (id, data assinatura, id cliente, id gerente, valor do contrato)*/


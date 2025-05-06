-- 1 - Você é responsável por controlar os dados de clientes e de produtos da sua empresa. 

/* 1.1 - Existem 2.517 produtos cadastrados na base e, se não tiver, você deverá reportar ao seu 
gestor para saber se existe alguma defasagem no controle dos produtos.*/

select 
	* 
from
	DimProduct
-- Resposta: Sim um total de 2.517 produtos cadastrado

/* 1.2 - Até o mês passado, a empresa tinha um total de 19.500 clientes na base de controle. 
Verifique se esse número aumentou ou reduziu. */

select distinct 
	FirstName,LastName,EmailAddress 
from 
	DimCustomer
-- Resposta: Diminuiu para 18.485 clientes

/* 2 - Você trabalha no setor de marketing da empresa Contoso e acaba de ter uma ideia de oferecer 
descontos especiais para os clientes no dia de seus aniversários. Para isso, você vai precisar 
listar todos os clientes e as suas respectivas datas de nascimento, além de um contato.*/

SELECT 
	CustomerKey as 'Id cliente', 
	FirstName as 'Primeiro Nome', 
	EmailAddress as 'E-mail', 
	BirthDate  as 'Data de nascimento'
FROM
	DimCustomer

/* 3 - A Contoso está comemorando aniversário de inauguração de 10 anos e pretende fazer uma 
ação de premiação para os clientes. A empresa quer presentear os primeiros clientes desde 
a inauguração.Você foi alocado para levar adiante essa ação. Para isso, você terá que fazer o seguinte:

	3.a -Contoso decidiu presentear os primeiros 100 clientes da história com um vale compras 
		de R$ 10.000. Utilize um comando em SQL para retornar uma tabela com os primeiros 
		100 primeiros clientes da tabela dimCustomer (selecione todas as colunas). */

 select top(100) * from DimCustomer

/*	3.b - A Contoso decidiu presentear os primeiros 20% de clientes da história com um vale 
		compras de R$ 2.000. Utilize um comando em SQL para retornar 10% das linhas da sua 
		tabela dimCustomer (selecione todas as colunas). */

select top(10) percent * from DimCustomer

/*	3.c - Adapte o código do item a) para retornar apenas as 100 primeiras linhas, mas apenas as 
		colunas FirstName, EmailAddress, BirthDate. */

select top(100) percent FirstName, EmailAddress, BirthDate from DimCustomer

--	3.d - Renomeie as colunas anteriores para nomes em português.

select top(10) percent 
	FirstName as 'Primeiro Nome', 
	EmailAddress as 'Email', 
	BirthDate as 'Data de nascimento'
from 
	DimCustomer

/* 4 - A empresa Contoso precisa fazer contato com os fornecedores de produtos para repor o 
		estoque. Você é da área de compras e precisa descobrir quem são esses fornecedores. 

		4.a - Utilize um comando em SQL para retornar apenas os nomes dos fornecedores na tabela 
		dimProduct e renomeie essa nova coluna da tabela.*/

select distinct Manufacturer as 'Fornecedores' from DimProduct

/* 5 - O seu trabalho de investigação não para. Você precisa descobrir se existe algum produto 
		registrado na base de produtos que ainda não tenha sido vendido. Tente chegar nessa 
		informação.*/

select * from FactSales
select 




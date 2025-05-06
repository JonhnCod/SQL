/* 1. O gerente comercial pediu a voc� uma an�lise da Quantidade Vendida e Quantidade
	Devolvida para o canal de venda mais importante da empresa: Store.*/

SELECT 
	SUM(SalesQuantity) AS 'QUANTIDADE VENDIDAS',
	SUM(ReturnQuantity) AS 'QUANTIDADE RETORNADAS'
FROM FactSales
where channelKey = 1 


/* 2. Uma nova a��o no setor de Marketing precisar� avaliar a m�dia salarial de todos os clientes
	da empresa, mas apenas de ocupa��o Professional. Utilize um comando SQL para atingir esse
	resultado.*/

SELECT 
	AVG(YearlyIncome) AS 'M�DIA SALARIAL' 
FROM
	DimCustomer
WHERE 
	Occupation = 'PROFESSIONAL'


/* 3. Voc� precisar� fazer uma an�lise da quantidade de funcion�rios das lojas registradas na
	empresa. O seu gerente te pediu os seguintes n�meros e informa��es:

	a) Quantos funcion�rios tem a loja com mais funcion�rios?*/

SELECT 
	MAX(EmployeeCount) AS 'MAX FUNCION�RIOS' 
FROM 
	DimStore

	/*b) Qual � o nome dessa loja?*/

SELECT 	TOP(1) StoreName AS 'NOME DA LOJA',	EmployeeCount AS 'QUANTIDADE DE FUNCION�RIOS'FROM 	DimStoreORDER BY 
	EmployeeCount DESC;

	/*c) Quantos funcion�rios tem a loja com menos funcion�rios?*/

SELECT MIN(EmployeeCount) AS 'MIN FUNCION�RIOS' FROM DimStore

	/*d) Qual � o nome dessa loja?*/SELECT 	TOP(1) StoreName AS 'NOME DA LOJA',	EmployeeCount AS 'QUANTIDADE DE FUNCION�RIOS'FROM 	DimStoreWHERE EmployeeCount IS NOT NULLORDER BY 
	EmployeeCount ASC;/* 4. A �rea de RH est� com uma nova a��o para a empresa, e para isso precisa saber a quantidade
	total de funcion�rios do sexo Masculino e do sexo Feminino.

	a) Descubra essas duas informa��es utilizando o SQL.*/

SELECT COUNT(GENDER) AS 'QTD. FUNCION�RIOS MASCULINOS' FROM DimCustomer
WHERE Gender = 'M'

SELECT COUNT(GENDER) AS 'QTD. FUNCION�RIOS FEMENINOS' FROM DimCustomer
WHERE Gender = 'F'



	/*b) O funcion�rio e a funcion�ria mais antigos receber�o uma homenagem. Descubra as
	seguintes informa��es de cada um deles: Nome, E-mail, Data de Contrata��o.*/SELECT 	TOP(1) FirstName AS 'PRIMEIRO NOME',	LastName AS '�LTIMO NOME',	MiddleName AS 'NOME DE MEIO',	EmailAddress AS 'EMAIL',	StartDate AS 'DATA DA CONTRATA��O'FROM DimEmployeeWHERE 	Gender = 'M'	AND Status IS NOT NULL ORDER BY StartDate ASC;SELECT 	TOP(1) FirstName AS 'PRIMEIRO NOME',	LastName AS '�LTIMO NOME',	MiddleName AS 'NOME DE MEIO',	EmailAddress AS 'EMAIL',	StartDate AS 'DATA DA CONTRATA��O'FROM DimEmployeeWHERE 	Gender = 'F'	AND Status IS NOT NULL ORDER BY StartDate ASC;/* 5. Agora voc� precisa fazer uma an�lise dos produtos. Ser� necess�rio descobrir as seguintes
	informa��es:

	a) Quantidade distinta de cores de produtos.
	b) Quantidade distinta de marcas
	c) Quantidade distinta de classes de produto

	Para simplificar, voc� pode fazer isso em uma mesma consulta.*/	SELECT * FROM DimProductSELECT 	COUNT(DISTINCT ColorName) AS 'QTD TOTAL DE CORES',	COUNT(DISTINCT BrandName) AS 'QTD TOTAL DE MARCAS',	COUNT(DISTINCT ClassName) AS 'QTD TOTAL DE CLASSES'	FROM DimProduct
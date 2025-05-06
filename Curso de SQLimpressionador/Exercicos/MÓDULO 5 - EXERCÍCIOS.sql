/* 1. O gerente comercial pediu a você uma análise da Quantidade Vendida e Quantidade
	Devolvida para o canal de venda mais importante da empresa: Store.*/

SELECT 
	SUM(SalesQuantity) AS 'QUANTIDADE VENDIDAS',
	SUM(ReturnQuantity) AS 'QUANTIDADE RETORNADAS'
FROM FactSales
where channelKey = 1 


/* 2. Uma nova ação no setor de Marketing precisará avaliar a média salarial de todos os clientes
	da empresa, mas apenas de ocupação Professional. Utilize um comando SQL para atingir esse
	resultado.*/

SELECT 
	AVG(YearlyIncome) AS 'MÉDIA SALARIAL' 
FROM
	DimCustomer
WHERE 
	Occupation = 'PROFESSIONAL'


/* 3. Você precisará fazer uma análise da quantidade de funcionários das lojas registradas na
	empresa. O seu gerente te pediu os seguintes números e informações:

	a) Quantos funcionários tem a loja com mais funcionários?*/

SELECT 
	MAX(EmployeeCount) AS 'MAX FUNCIONÁRIOS' 
FROM 
	DimStore

	/*b) Qual é o nome dessa loja?*/

SELECT 	TOP(1) StoreName AS 'NOME DA LOJA',	EmployeeCount AS 'QUANTIDADE DE FUNCIONÁRIOS'FROM 	DimStoreORDER BY 
	EmployeeCount DESC;

	/*c) Quantos funcionários tem a loja com menos funcionários?*/

SELECT MIN(EmployeeCount) AS 'MIN FUNCIONÁRIOS' FROM DimStore

	/*d) Qual é o nome dessa loja?*/SELECT 	TOP(1) StoreName AS 'NOME DA LOJA',	EmployeeCount AS 'QUANTIDADE DE FUNCIONÁRIOS'FROM 	DimStoreWHERE EmployeeCount IS NOT NULLORDER BY 
	EmployeeCount ASC;/* 4. A área de RH está com uma nova ação para a empresa, e para isso precisa saber a quantidade
	total de funcionários do sexo Masculino e do sexo Feminino.

	a) Descubra essas duas informações utilizando o SQL.*/

SELECT COUNT(GENDER) AS 'QTD. FUNCIONÁRIOS MASCULINOS' FROM DimCustomer
WHERE Gender = 'M'

SELECT COUNT(GENDER) AS 'QTD. FUNCIONÁRIOS FEMENINOS' FROM DimCustomer
WHERE Gender = 'F'



	/*b) O funcionário e a funcionária mais antigos receberão uma homenagem. Descubra as
	seguintes informações de cada um deles: Nome, E-mail, Data de Contratação.*/SELECT 	TOP(1) FirstName AS 'PRIMEIRO NOME',	LastName AS 'ÚLTIMO NOME',	MiddleName AS 'NOME DE MEIO',	EmailAddress AS 'EMAIL',	StartDate AS 'DATA DA CONTRATAÇÃO'FROM DimEmployeeWHERE 	Gender = 'M'	AND Status IS NOT NULL ORDER BY StartDate ASC;SELECT 	TOP(1) FirstName AS 'PRIMEIRO NOME',	LastName AS 'ÚLTIMO NOME',	MiddleName AS 'NOME DE MEIO',	EmailAddress AS 'EMAIL',	StartDate AS 'DATA DA CONTRATAÇÃO'FROM DimEmployeeWHERE 	Gender = 'F'	AND Status IS NOT NULL ORDER BY StartDate ASC;/* 5. Agora você precisa fazer uma análise dos produtos. Será necessário descobrir as seguintes
	informações:

	a) Quantidade distinta de cores de produtos.
	b) Quantidade distinta de marcas
	c) Quantidade distinta de classes de produto

	Para simplificar, você pode fazer isso em uma mesma consulta.*/	SELECT * FROM DimProductSELECT 	COUNT(DISTINCT ColorName) AS 'QTD TOTAL DE CORES',	COUNT(DISTINCT BrandName) AS 'QTD TOTAL DE MARCAS',	COUNT(DISTINCT ClassName) AS 'QTD TOTAL DE CLASSES'	FROM DimProduct
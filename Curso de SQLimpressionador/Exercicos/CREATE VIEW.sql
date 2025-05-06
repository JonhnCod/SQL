use ContosoRetailDW

/* 1. a) A partir da tabela DimProduct, crie uma View contendo as informações de
	ProductName, ColorName, UnitPrice e UnitCost, da tabela DimProduct. Chame essa View
	de vwProdutos.*/
GO
CREATE VIEW vwProdutos AS
SELECT 
	ProductName,
	ColorName,
	UnitPrice,
	UnitCost
FROM DimProduct
GO
	/*b) A partir da tabela DimEmployee, crie uma View mostrando FirstName, BirthDate,
	DepartmentName. Chame essa View de vwFuncionarios.*/

CREATE VIEW vwFuncionarios AS
SELECT 
	FirstName,
	BirthDate,
	DepartmentName
FROM DimEmployee
GO

	/*c) A partir da tabela DimStore, crie uma View mostrando StoreKey, StoreName e
	OpenDate. Chame essa View de vwLojas.*/

CREATE VIEW vwLOJAS AS
SELECT 
	StoreKey,
	StoreName,
	OpenDate
FROM DimStore

GO

/* 2. Crie uma View contendo as informações de Nome Completo (FirstName +
	LastName), Gênero (por extenso), E-mail e Renda Anual (formatada com R$).
	Utilize a tabela DimCustomer. Chame essa View de vwClientes.*/


GO
CREATE VIEW vwClientes AS 
SELECT FirstName + ' ' +
	LastName as 'NOME COMPLETO',
	REPLACE(REPLACE(GENDER,'M','MASCULINO'),'F','FEMININO') AS 'SEXO',
	EmailAddress AS 'EMAIL',
	FORMAT(YearlyIncome,'C') AS 'RENDA ANUAL' 
FROM DimCustomer
GO

/*3. a) A partir da tabela DimStore, crie uma View que considera apenas as lojas ativas. Faça
	um SELECT de todas as colunas. Chame essa View de vwLojasAtivas.*/

CREATE VIEW vwLojasAtivas AS
SELECT 
	*
FROM DimStore
WHERE Status = 'ON'
GO

	/*b) A partir da tabela DimEmployee, crie uma View de uma tabela que considera apenas os
	funcionários da área de Marketing. Faça um SELECT das colunas: FirstName, EmailAddress
	e DepartmentName. Chame essa de vwFuncionariosMkt.*/

CREATE VIEW vwFuncionariosMkt AS
SELECT 
	FirstName,
	EmailAddress,
	DepartmentName
FROM DimEmployee
WHERE DepartmentName = 'Marketing'
GO


	/*c) Crie uma View de uma tabela que considera apenas os produtos das marcas Contoso e
	Litware. Além disso, a sua View deve considerar apenas os produtos de cor Silver. Faça
	um SELECT de todas as colunas da tabela DimProduct. Chame essa View de
	vwContosoLitwareSilver*/

CREATE VIEW vwContosoLitwareSilver AS
SELECT 
	*
FROM DimProduct
WHERE BrandName IN ('Contoso','Litware') AND ColorName = 'Silver'
GO


/* 4. Crie uma View que seja o resultado de um agrupamento da tabela FactSales. Este
	agrupamento deve considerar o SalesQuantity (Quantidade Total Vendida) por Nome do
	Produto. Chame esta View de vwTotalVendidoProdutos.
	OBS: Para isso, você terá que utilizar um JOIN para relacionar as tabelas FactSales e
	DimProduct.*/GOALTER VIEW vwTotalVendidoProdutos ASSELECT 	ProductName AS 'PRODUTO',	SUM(SalesQuantity) AS  'QTD VENDIDA'FROM FactSales FSINNER JOIN DimProduct DP	ON FS.ProductKey = DP.ProductKeyGROUP BY ProductNameGO

SELECT * FROM vwTotalVendidoProdutos
ORDER BY [QTD VENDIDA] DESC

/*5. Faça as seguintes alterações nas tabelas da questão 1.

	a. Na View criada na letra a da questão 1, adicione a coluna de BrandName.*/
GO
ALTER VIEW vwProdutos AS
SELECT 
	ProductName,
	BrandName,
	ColorName,
	UnitPrice,
	UnitCost
FROM DimProduct
GO

	/*b. Na View criada na letra b da questão 1, faça um filtro e considere apenas os
	funcionários do sexo feminino.*/
GO
ALTER VIEW vwFuncionarios AS
SELECT 
	FirstName,
	BirthDate,
	DepartmentName,
	Gender
FROM DimEmployee
WHERE Gender = 'F'
GO

	/*c. Na View criada na letra c da questão 1, faça uma alteração e filtre apenas as lojas
ativas.*/
GO
ALTER VIEW vwLOJAS AS
SELECT 
	StoreKey,
	StoreName,
	OpenDate,
	Status
FROM DimStore
WHERE Status = 'On'
GO
SELECT * FROM vwLOJAS


/*6. a) Crie uma View que seja o resultado de um agrupamento da tabela DimProduct. O
	resultado esperado da consulta deverá ser o total de produtos por marca. Chame essa
	View de vw_6a.*/

go
CREATE VIEW vw_6a AS 
SELECT 
	BrandName AS 'MARCA',
	COUNT(ProductName) AS 'QTD PRODUTOS'
FROM DimProduct
GROUP BY BrandName
go
SELECT * FROM vw_6a

	/*b) Altere a View criada no exercício anterior, adicionando o peso total por marca. Atenção:
	sua View final deverá ter então 3 colunas: Nome da Marca, Total de Produtos e Peso Total.*/

go
ALTER VIEW vw_6a AS 
SELECT 
	BrandName AS 'MARCA',
	COUNT(ProductName) AS 'QTD PRODUTOS',
	SUM(WEIGHT) AS 'PESO TOTAL'
FROM DimProduct
GROUP BY BrandName
go


	--c) Exclua a View vw_6a.*/

DROP VIEW vw_6a 

SELECT * FROM vw_6a









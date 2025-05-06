/* 1. Utilize o INNER JOIN para trazer os nomes das subcategorias dos produtos, da tabela
DimProductSubcategory para a tabela DimProduct.*/

SELECT 
	DimProduct.ProductName,
	DP.ProductSubcategoryName
FROM DimProduct
INNER JOIN DimProductSubcategory DP
	ON DimProduct.ProductSubcategoryKey = DP.ProductSubcategoryKey

/* 2. Identifique uma coluna em comum entre as tabelas DimProductSubcategory e
	DimProductCategory. Utilize essa coluna para complementar informa��es na tabela
	DimProductSubcategory a partir da DimProductCategory. Utilize o LEFT JOIN.*/


SELECT
	ProductSubcategoryKey AS 'ID SUB-CATEGORIA',
	ProductSubcategoryName AS 'SUB CATEGORIA',
	ProductCategoryDescription AS 'DESCRI��O',
	ProductCategoryName AS 'CATEGORIA'
	
FROM
	DimProductSubcategory DPS
LEFT JOIN DimProductCategory DPC
	ON  DPS.ProductCategoryKey = DPC.ProductCategoryKey


/* 3. Para cada loja da tabela DimStore, descubra qual o Continente e o Nome do Pa�s associados
	(de acordo com DimGeography). Seu SELECT final deve conter apenas as seguintes colunas:
	StoreKey, StoreName, EmployeeCount, ContinentName e RegionCountryName. Utilize o LEFT
	JOIN neste exerc�cio.*/

SELECT * FROM DimStore
SELECT * FROM DimGeography

SELECT
	StoreKey AS 'ID LOJA',
	StoreName AS 'NOME DA LOJA',
	EmployeeCount AS 'NUM. FUNCION�RIOS',
	RegionCountryName AS 'PA�S',
	ContinentName AS 'CONTINENTE'
	
FROM
	DimStore DS
LEFT JOIN DimGeography DG
	ON  DS.GeographyKey = DG.GeographyKey

/* 4. Complementa a tabela DimProduct com a informa��o de ProductCategoryDescription. Utilize
	o LEFT JOIN e retorne em seu SELECT apenas as 5 colunas que considerar mais relevantes.*/

SELECT
	ProductKey AS 'ID PRODUTO',
	ProductName AS 'NOME DO PRODUTO',
	ProductCategoryDescription AS 'CATEGORIA DISCRI��O',
	BrandName AS 'MARCA',
	UnitPrice AS 'PRE�O'
	
FROM
	DimProduct DP
LEFT JOIN DimProductSubcategory DPS
	ON  DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
		LEFT JOIN DimProductCategory DPC
			ON DPS.ProductCategoryKey = DPC.ProductCategoryKey


/*5. A tabela FactStrategyPlan resume o planejamento estrat�gico da empresa. Cada linha
	representa um montante destinado a uma determinada AccountKey.
	a) Fa�a um SELECT das 100 primeiras linhas de FactStrategyPlan para reconhecer a tabela.*/
	
	
	/*b) Fa�a um INNER JOIN para criar uma tabela contendo o AccountName para cada
	AccountKey da tabela FactStrategyPlan. O seu SELECT final deve conter as colunas:
	� StrategyPlanKey
	� DateKey
	� AccountName
	� Amount*/
SELECT 
	TOP(100)StrategyPlanKey,
	Datekey,
	AccountName,
	Amount
FROM 
	FactStrategyPlan FS
INNER JOIN DimAccount DA
	ON FS.AccountKey = DA.AccountKey

/*6. Vamos continuar analisando a tabela FactStrategyPlan. Al�m da coluna AccountKey que
	identifica o tipo de conta, h� tamb�m uma outra coluna chamada ScenarioKey. Essa coluna
	possui a numera��o que identifica o tipo de cen�rio: Real, Or�ado e Previs�o.
	Fa�a um INNER JOIN para criar uma tabela contendo o ScenarioName para cada ScenarioKey
	da tabela FactStrategyPlan. O seu SELECT final deve conter as colunas:
	� StrategyPlanKey
	� DateKey
	� ScenarioName
	� Amount*/

SELECT 
	StrategyPlanKey,
	Datekey,
	ScenarioName,
	Amount
FROM 
	FactStrategyPlan FS
INNER JOIN DimScenario DS
	ON FS.ScenarioKey = DS.ScenarioKey

SELECT TOP(10)* FROM DimProduct



/*7.Algumas subcategorias n�o possuem nenhum exemplar de produto. Identifique que
	subcategorias s�o essas.*/

SELECT 
	DP.ProductSubcategoryKey,
	ProductName,
	ProductSubcategoryName
	
FROM DimProduct DP
RIGHT JOIN DimProductSubcategory DPS
	ON DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey

WHERE ProductName IS NULL



		



	





	
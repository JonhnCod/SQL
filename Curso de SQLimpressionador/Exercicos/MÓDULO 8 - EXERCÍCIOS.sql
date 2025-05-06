/* 1. a) Fa�a um resumo da quantidade vendida (Sales Quantity) de acordo com o nome do canal
	de vendas (ChannelName). Voc� deve ordenar a tabela final de acordo com SalesQuantity,
	em ordem decrescente.*/

SELECT 
	ChannelName	AS 'CANAL',
	SUM(SalesQuantity) AS 'QTD. TOTAL'
FROM
	FactSales FS
INNER JOIN DimChannel DC
	ON FS.channelKey = DC.ChannelKey
GROUP BY DC.ChannelName
ORDER BY SUM(SalesQuantity) DESC

	/*b) Fa�a um agrupamento mostrando a quantidade total vendida (Sales Quantity) e
	quantidade total devolvida (Return Quantity) de acordo com o nome das lojas
	(StoreName).*/



SELECT TOP(10)
	StoreName AS 'NOME LOJA',
	SUM(SalesQuantity) AS 'QTD. VENDIDA',
	SUM(ReturnQuantity) AS 'QTD. DEVOLVIDA'
FROM
	FactSales FC
INNER JOIN DimStore DS
	ON FC.StoreKey = DS.StoreKey
GROUP BY StoreName


	/*c) Fa�a um resumo do valor total vendido (Sales Amount) para cada m�s
	(CalendarMonthLabel) e ano (CalendarYear).*/


SELECT 
	CalendarMonthLabel AS 'M�S',
	CalendarYear AS 'ANO',
	SUM(SalesAmount) AS 'QTD.VENDIDA'
FROM FactSales FS
INNER JOIN DimDate DD
	ON FS.DateKey = DD.Datekey
GROUP BY CalendarYear,CalendarMonthLabel,CalendarMonth
ORDER BY CalendarMonth ASC


/* 2. Voc� precisa fazer uma an�lise de vendas por produtos. O objetivo final � descobrir o valor
	total vendido (SalesQuantity) por produto.*/

	/*a) Descubra qual � a cor de produto que mais � vendida (de acordo com SalesQuantity).*/

SELECT 
	ColorName AS 'COR',
	SUM(SalesQuantity) AS 'QTD.VENDIDA'
FROM FactSales FS
INNER JOIN DimProduct DP
	ON FS.ProductKey = DP.ProductKey
GROUP BY ColorName
ORDER BY SUM(SalesQuantity) DESC


	/*b) Quantas cores tiveram uma quantidade vendida acima de 3.000.000.*/SELECT 
	ColorName AS 'COR',
	SUM(SalesQuantity) AS 'QTD.VENDIDA'
FROM FactSales FS
INNER JOIN DimProduct DP
	ON FS.ProductKey = DP.ProductKey
GROUP BY ColorName
HAVING SUM(SalesQuantity) > 3000000
ORDER BY SUM(SalesQuantity) DESC/* 3. Crie um agrupamento de quantidade vendida (SalesQuantity) por categoria do produto
	(ProductCategoryName). Obs: Voc� precisar� fazer mais de 1 INNER JOIN, dado que a rela��o
	entre FactSales e DimProductCategory n�o � direta*/SELECT 	ProductCategoryName AS 'CATEGORIA',	SUM(SalesQuantity) AS 'QTD VENDIDA'FROM	DimProductCategory DPCINNER JOIN DimProductSubcategory DPS	ON DPC.ProductCategoryKey = DPS.ProductCategoryKeyINNER JOIN DimProduct DP	ON DPS.ProductSubcategoryKey = DP.ProductSubcategoryKeyINNER JOIN FactSales FS	ON DP.ProductKey = FS.ProductKeyGROUP BY ProductCategoryName/*4. a) Voc� deve fazer uma consulta � tabela FactOnlineSales e descobrir qual � o nome completo
	do cliente que mais realizou compras online (de acordo com a coluna SalesQuantity).*/
SELECT 	DC.CustomerKey AS 'ID CLIENTE',	FirstName AS 'NOME',		LastName AS	'�LTIMO NOME',	SUM(SalesQuantity) AS 'QTD VENDIDA'FROM 	FactOnlineSales FOSINNER JOIN DimCustomer DC	ON FOS.CustomerKey = DC.CustomerKeyWHERE CustomerType = 'person'GROUP BY DC.CustomerKey,FirstName,LastNameORDER BY SUM(SalesQuantity) DESC	 

	/*b) Feito isso, fa�a um agrupamento de produtos e descubra quais foram os top 10 produtos mais
	comprados pelo cliente da letra a, considerando o nome do produto.*/SELECT TOP(10)	ProductName AS 'PRODUTO',	SUM(SalesQuantity) AS 'QTD. VENDIDA'FROM	FactOnlineSales FOSINNER JOIN DimProduct DP	ON FOS.ProductKey = DP.ProductKeyWHERE CustomerKey = 7665GROUP BY ProductNameORDER BY SUM(SalesQuantity) DESC/* 5. Fa�a um resumo mostrando o total de produtos comprados (Sales Quantity) de acordo com o
	sexo dos clientes.*/SELECT 	Gender AS 'SEXO',	SUM(SalesQuantity) AS 'QTD.VENDIDA'FROM 	FactOnlineSales FOSINNER JOIN DimCustomer DC 	ON FOS.CustomerKey = DC.CustomerKeyGROUP BY GenderHAVING Gender IS NOT NULL/*6. Fa�a uma tabela resumo mostrando a taxa de c�mbio m�dia de acordo com cada
CurrencyDescription. A tabela final deve conter apenas taxas entre 10 e 100.*/SELECT	CurrencyDescription AS 'C�MBIO',	AVG(AverageRate) AS 'TAXA M�DIA'FROM FactExchangeRate FERINNER JOIN DimCurrency DC	ON FER.CurrencyKey = DC.CurrencyKeyGROUP BY CurrencyDescriptionHAVING  AVG(AverageRate) BETWEEN 10 AND 100/* 7. Calcule a SOMA TOTAL de AMOUNT referente � tabela FactStrategyPlan destinado aos
cen�rios: Actual e Budget.*/SELECT	ScenarioName AS 'CENARIO',	SUM(Amount) AS 'VALOR TOTAL'FROM FactStrategyPlan FSPINNER JOIN DimScenario DS	ON FSP.ScenarioKey = DS.ScenarioKeyWHERE ScenarioName IN ('Actual','Budget')GROUP BY ScenarioName/*8. Fa�a uma tabela resumo mostrando o resultado do planejamento estrat�gico por ano.*/SELECT	DD.CalendarYear AS 'ANO',	SUM(Amount) AS 'VALOR TOTAL'FROM 	FactStrategyPlan FSPINNER JOIN DimDate DD	ON fSP.Datekey = DD.DatekeyGROUP BY DD.CalendarYear/* 9. Fa�a um agrupamento de quantidade de produtos por ProductSubcategoryName. Leve em
	considera��o em sua an�lise apenas a marca Contoso e a cor Silver.*/SELECT TOP(1) * FROM DimProduct
SELECT TOP(1) * FROM DimProductSubcategorySELECT 	ProductSubcategoryName AS 'SUBCATEGORIA',	COUNT(ProductName) AS 'QTD PRODUTOS'FROM DimProductSubcategory DPSINNER JOIN DimProduct DP	ON DPS.ProductSubcategoryKey = DP.ProductSubcategoryKeyWHERE BrandName = 'CONTOSO' AND ColorName = 'SILVER'GROUP BY ProductSubcategoryName/*10. Fa�a um agrupamento duplo de quantidade de produtos por BrandName e
	ProductSubcategoryName. A tabela final dever� ser ordenada de acordo com a coluna
	BrandName.*/SELECT TOP(1) * FROM DimProduct
SELECT TOP(1) * FROM DimProductSubcategorySELECT	BrandName AS 'MARCA',	ProductSubcategoryName AS 'SUBCATEGORIA',	COUNT(*) AS 'QTD PRODUTOS'FROM DimProduct DPINNER JOIN DimProductSubcategory DPS ON DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey GROUP BY BrandName,ProductSubcategoryName ORDER BY BrandName		





	
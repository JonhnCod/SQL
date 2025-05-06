

SELECT * FROM Factsales
WHERE StoreKey = (SELECT StoreKey FROM DimStore WHERE StoreName = 'Contoso Orlando Store')


/* 2. O setor de controle de produtos quer fazer uma an�lise para descobrir quais s�o os produtos
	que possuem um UnitPrice maior que o UnitPrice do produto de ID igual a 1893.

	a) A sua consulta resultante deve conter as colunas ProductKey, ProductName e UnitPrice
	da tabela DimProduct.*/

SELECT 
	ProductKey,
	ProductName,
	UnitPrice
FROM 
	DimProduct
WHERE UnitPrice > (SELECT UnitPrice FROM DimProduct WHERE ProductKey = 1893)

SELECT * FROM DimCustomer


	/*b) Nessa query voc� tamb�m deve retornar uma coluna extra, que informe o UnitPrice do
	produto 1893*/

SELECT 
	ProductKey,
	ProductName,
	UnitPrice,
	(SELECT UnitPrice FROM DimProduct WHERE ProductKey = 1893) AS 'PRECO ID 1893'
FROM 
	DimProduct
WHERE UnitPrice > (SELECT UnitPrice FROM DimProduct WHERE ProductKey = 1893)

/*3. A empresa Contoso criou um programa de bonifica��o chamado �Todos por 1�. Este
	programa consistia no seguinte: 1 funcion�rio seria escolhido ao final do ano como o funcion�rio
	destaque, s� que a bonifica��o seria recebida por todos da �rea daquele funcion�rio em
	particular. O objetivo desse programa seria o de incentivar a colabora��o coletiva entre os
	funcion�rios de uma mesma �rea. Desta forma, o funcion�rio destaque beneficiaria n�o s� a si,
	mas tamb�m a todos os colegas de sua �rea.
	
	Ao final do ano, o funcion�rio escolhido como destaque foi o Miguel Severino. Isso significa que
	todos os funcion�rios da �rea do Miguel seriam beneficiados com o programa.

	O seu objetivo � realizar uma consulta � tabela DimEmployee e retornar todos os funcion�rios
	da �rea �vencedora� para que o setor Financeiro possa realizar os pagamentos das bonifica��es.*/

SELECT * FROM DimEmployee
WHERE DepartmentName = (
SELECT DepartmentName FROM DimEmployee
WHERE CONCAT( FirstName + ' ',LastName ) = 'Miguel Severino')


/* 4. Fa�a uma query que retorne os clientes que recebem um sal�rio anual acima da m�dia. A sua
	query deve retornar as colunas CustomerKey, FirstName, LastName, EmailAddress e
	YearlyIncome.
	Obs: considere apenas os clientes que s�o 'Pessoas F�sicas'.*/

SELECT 
	CustomerKey,
	FirstName,
	LastName,
	EmailAddress,
	YearlyIncome,
	(SELECT AVG(YearlyIncome) FROM DimCustomer WHERE CustomerType = 'PERSON') AS 'M�DIA SALARIAL'
FROM DimCustomer
WHERE YearlyIncome > (SELECT AVG(YearlyIncome) FROM DimCustomer WHERE CustomerType = 'PERSON') AND CustomerType = 'PERSON'


/* 5. A a��o de desconto da Asian Holiday Promotion foi uma das mais bem sucedidas da empresa.
	Agora, a Contoso quer entender um pouco melhor sobre o perfil dos clientes que compraram
	produtos com essa promo��o.

	Seu trabalho � criar uma query que retorne a lista de clientes que compraram nessa promo��o.*/
SELECT 
	CustomerKey,
	FirstName,
	LastName,
	EmailAddress,
	CustomerType
FROM DimCustomer
WHERE 
	CustomerKey = 
		ANY(SELECT CustomerKey FROM FactOnlineSales 
		WHERE PromotionKey = 
			ANY(SELECT PromotionKey FROM DimPromotion WHERE PromotionName = 'Asian Holiday Promotion'))

/* 6. A empresa implementou um programa de fideliza��o de clientes empresariais. Todos aqueles
	que comprarem mais de 3000 unidades de um mesmo produto receber� descontos em outras
	compras.
	Voc� dever� descobrir as informa��es de CustomerKey e CompanyName destes clientes*/


SELECT
	CustomerKey,
	CompanyName
FROM DimCustomer
WHERE CustomerKey = 
		ANY(SELECT 
				CustomerKey
			FROM FactOnlineSales
			GROUP BY CustomerKey,ProductKey
			HAVING SUM(SalesQuantity) > 3000) 
		AND CustomerType = 'COMPANY'

/* 7. Voc� dever� criar uma consulta para o setor de vendas que mostre as seguintes colunas da
	tabela DimProduct:
	ProductKey,
	ProductName,
	BrandName,
	UnitPrice
	M�dia de UnitPrice. */

SELECT 
	ProductKey,
	ProductName,
	BrandName,
	UnitPrice,
	(SELECT AVG(UNITPRICE) FROM DimProduct) AS 'M�DIA DE PRE�O'
FROM DimProduct
go


/* 8. Fa�a uma consulta para descobrir os seguintes indicadores dos seus produtos:
	Maior quantidade de produtos por marca
	Menor quantidade de produtos por marca
	M�dia de produtos por marca*/

SELECT
	MAX(QUANTIDADE) AS 'M�X',
	MIN(QUANTIDADE) AS 'MIN',
	AVG(QUANTIDADE) AS 'M�DIA'
FROM (
	SELECT 
		BrandName,
		COUNT(*) AS 'QUANTIDADE'
	FROM DimProduct 
	GROUP BY BrandName) AS TABELA


/* 9. Crie uma CTE que seja o agrupamento da tabela DimProduct, armazenando o total de
	produtos por marca. Em seguida, fa�a um SELECT nesta CTE, descobrindo qual � a quantidade
	m�xima de produtos para uma marca. Chame esta CTE de CTE_QtdProdutosPorMarca*/

WITH CTE_QtdProdutosPorMarca AS (
SELECT 
		BrandName,
		COUNT(*) AS 'QUANTIDADE'
	FROM DimProduct 
	GROUP BY BrandName) 

SELECT * FROM CTE_QtdProdutosPorMarca


/* 10. Crie duas CTEs:
	(i) a primeira deve conter as colunas ProductKey, ProductName, ProductSubcategoryKey,
	BrandName e UnitPrice, da tabela DimProduct, mas apenas os produtos da marca Adventure
	Works. Chame essa CTE de CTE_ProdutosAdventureWorks.
	(ii) a segunda deve conter as colunas ProductSubcategoryKey, ProductSubcategoryName, da
	tabela DimProductSubcategory mas apenas para as subcategorias �Televisions� e �Monitors�.
	Chame essa CTE de CTE_CategoriaTelevisionsERadio.
	Fa�a um Join entre essas duas CTEs, e o resultado deve ser uma query contendo todas as colunas
	das duas tabelas. Observe nesse exemplo a diferen�a entre o LEFT JOIN e o INNER JOIN.*/
GO
WITH CTE_ProdutosAdventureWorks AS (
SELECT
	ProductKey,
	ProductName,
	ProductSubcategoryKey,
	BrandName,
	UnitPrice
FROM DimProduct
WHERE BrandName = 'Adventure Works'
),
CTE_CategoriaTelevisionsERadio AS (
SELECT
	ProductSubcategoryKey,
	ProductSubcategoryName
FROM DimProductSubcategory
WHERE ProductSubcategoryName IN ('Televisions','Monitors'))

SELECT 
	* 
FROM CTE_ProdutosAdventureWorks AS CTE_P
INNER JOIN CTE_CategoriaTelevisionsERadio AS CTE_C
	ON CTE_P.ProductSubcategoryKey = CTE_C.ProductSubcategoryKey

WITH CTE_ProdutosAdventureWorks AS (
SELECT
	ProductKey,
	ProductName,
	ProductSubcategoryKey,
	BrandName,
	UnitPrice
FROM DimProduct
WHERE BrandName = 'Adventure Works'
),
CTE_CategoriaTelevisionsERadio AS (
SELECT
	ProductSubcategoryKey,
	ProductSubcategoryName
FROM DimProductSubcategory
WHERE ProductSubcategoryName IN ('Televisions','Monitors'))

SELECT 
	* 
FROM CTE_CategoriaTelevisionsERadio AS CTE_P
LEFT JOIN CTE_ProdutosAdventureWorks AS CTE_C
	ON CTE_P.ProductSubcategoryKey = CTE_C.ProductSubcategoryKey

GO


























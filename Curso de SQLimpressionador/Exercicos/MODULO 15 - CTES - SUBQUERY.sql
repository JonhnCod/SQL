

SELECT * FROM Factsales
WHERE StoreKey = (SELECT StoreKey FROM DimStore WHERE StoreName = 'Contoso Orlando Store')


/* 2. O setor de controle de produtos quer fazer uma análise para descobrir quais são os produtos
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


	/*b) Nessa query você também deve retornar uma coluna extra, que informe o UnitPrice do
	produto 1893*/

SELECT 
	ProductKey,
	ProductName,
	UnitPrice,
	(SELECT UnitPrice FROM DimProduct WHERE ProductKey = 1893) AS 'PRECO ID 1893'
FROM 
	DimProduct
WHERE UnitPrice > (SELECT UnitPrice FROM DimProduct WHERE ProductKey = 1893)

/*3. A empresa Contoso criou um programa de bonificação chamado “Todos por 1”. Este
	programa consistia no seguinte: 1 funcionário seria escolhido ao final do ano como o funcionário
	destaque, só que a bonificação seria recebida por todos da área daquele funcionário em
	particular. O objetivo desse programa seria o de incentivar a colaboração coletiva entre os
	funcionários de uma mesma área. Desta forma, o funcionário destaque beneficiaria não só a si,
	mas também a todos os colegas de sua área.
	
	Ao final do ano, o funcionário escolhido como destaque foi o Miguel Severino. Isso significa que
	todos os funcionários da área do Miguel seriam beneficiados com o programa.

	O seu objetivo é realizar uma consulta à tabela DimEmployee e retornar todos os funcionários
	da área “vencedora” para que o setor Financeiro possa realizar os pagamentos das bonificações.*/

SELECT * FROM DimEmployee
WHERE DepartmentName = (
SELECT DepartmentName FROM DimEmployee
WHERE CONCAT( FirstName + ' ',LastName ) = 'Miguel Severino')


/* 4. Faça uma query que retorne os clientes que recebem um salário anual acima da média. A sua
	query deve retornar as colunas CustomerKey, FirstName, LastName, EmailAddress e
	YearlyIncome.
	Obs: considere apenas os clientes que são 'Pessoas Físicas'.*/

SELECT 
	CustomerKey,
	FirstName,
	LastName,
	EmailAddress,
	YearlyIncome,
	(SELECT AVG(YearlyIncome) FROM DimCustomer WHERE CustomerType = 'PERSON') AS 'MÉDIA SALARIAL'
FROM DimCustomer
WHERE YearlyIncome > (SELECT AVG(YearlyIncome) FROM DimCustomer WHERE CustomerType = 'PERSON') AND CustomerType = 'PERSON'


/* 5. A ação de desconto da Asian Holiday Promotion foi uma das mais bem sucedidas da empresa.
	Agora, a Contoso quer entender um pouco melhor sobre o perfil dos clientes que compraram
	produtos com essa promoção.

	Seu trabalho é criar uma query que retorne a lista de clientes que compraram nessa promoção.*/
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

/* 6. A empresa implementou um programa de fidelização de clientes empresariais. Todos aqueles
	que comprarem mais de 3000 unidades de um mesmo produto receberá descontos em outras
	compras.
	Você deverá descobrir as informações de CustomerKey e CompanyName destes clientes*/


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

/* 7. Você deverá criar uma consulta para o setor de vendas que mostre as seguintes colunas da
	tabela DimProduct:
	ProductKey,
	ProductName,
	BrandName,
	UnitPrice
	Média de UnitPrice. */

SELECT 
	ProductKey,
	ProductName,
	BrandName,
	UnitPrice,
	(SELECT AVG(UNITPRICE) FROM DimProduct) AS 'MÉDIA DE PREÇO'
FROM DimProduct
go


/* 8. Faça uma consulta para descobrir os seguintes indicadores dos seus produtos:
	Maior quantidade de produtos por marca
	Menor quantidade de produtos por marca
	Média de produtos por marca*/

SELECT
	MAX(QUANTIDADE) AS 'MÁX',
	MIN(QUANTIDADE) AS 'MIN',
	AVG(QUANTIDADE) AS 'MÉDIA'
FROM (
	SELECT 
		BrandName,
		COUNT(*) AS 'QUANTIDADE'
	FROM DimProduct 
	GROUP BY BrandName) AS TABELA


/* 9. Crie uma CTE que seja o agrupamento da tabela DimProduct, armazenando o total de
	produtos por marca. Em seguida, faça um SELECT nesta CTE, descobrindo qual é a quantidade
	máxima de produtos para uma marca. Chame esta CTE de CTE_QtdProdutosPorMarca*/

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
	tabela DimProductSubcategory mas apenas para as subcategorias ‘Televisions’ e ‘Monitors’.
	Chame essa CTE de CTE_CategoriaTelevisionsERadio.
	Faça um Join entre essas duas CTEs, e o resultado deve ser uma query contendo todas as colunas
	das duas tabelas. Observe nesse exemplo a diferença entre o LEFT JOIN e o INNER JOIN.*/
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


























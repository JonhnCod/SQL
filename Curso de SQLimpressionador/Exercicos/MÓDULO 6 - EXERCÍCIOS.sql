/* 1. a) Fa�a um resumo da quantidade vendida (SalesQuantity) de acordo com o canal de vendas
	(channelkey).*/

SELECT 
	channelkey,
	SUM(SalesQuantity) 
FROM 
	FactSales
GROUP BY 
	channelKey

	/*b) Fa�a um agrupamento mostrando a quantidade total vendida (SalesQuantity) e quantidade
	total devolvida (Return Quantity) de acordo com o ID das lojas (StoreKey).*/

SELECT 
	StoreKey AS 'ID DA LOJA', 
	SUM(SalesQuantity) AS 'QUANTIDADE VENDIDAS',
	SUM(ReturnQuantity) AS 'QUANTIDADE DEVOLVIDO'
FROM 
	FactSales
GROUP BY StoreKey


	/*c) Fa�a um resumo do valor total vendido (SalesAmount) para cada canal de venda, mas apenas
	para o ano de 2007.*/

SELECT 
	channelKey, 
	SUM(SalesAmount) 
FROM 
	FactSales
WHERE 
	DateKey LIKE '%2007%'
GROUP BY 
	channelKey
	
/*2. Voc� precisa fazer uma an�lise de vendas por produtos. O objetivo final � descobrir o valor
	total vendido (SalesAmount) por produto (ProductKey).*/

SELECT 
	ProductKey,
	SUM(SalesAmount) 
FROM 
	FACTSALES
GROUP BY 
	ProductKey

	/*a) A tabela final dever� estar ordenada de acordo com a quantidade vendida e, al�m disso,
	mostrar apenas os produtos que tiveram um resultado final de vendas maior do que
	$5.000.000.*/

SELECT 
	ProductKey AS 'ID DO PRODUTO',
	SUM(SalesAmount) AS 'QUANTIDADE VENDIDA'
FROM 
	FACTSALES
GROUP BY 
	ProductKey
HAVING 
	SUM(SalesAmount) > 5000000
ORDER BY 
	SUM(SalesAmount) DESC

	/*b) Fa�a uma adapta��o no exerc�cio anterior e mostre os Top 10 produtos com mais vendas.
	Desconsidere o filtro de $5.000.000 aplicado.*/

SELECT TOP(10)
	ProductKey AS 'ID DO PRODUTO',
	SUM(SalesAmount) AS 'QUANTIDADE VENDIDA'
FROM 
	FACTSALES
GROUP BY 
	ProductKey
ORDER BY 
	SUM(SalesAmount) DESC

/* 3. a) Voc� deve fazer uma consulta � tabela FactOnlineSales e descobrir qual � o ID
	(CustomerKey) do cliente que mais realizou compras online (de acordo com a coluna
	SalesQuantity).*/
 SELECT * FROM FactSales
SELECT 
	TOP(1) CustomerKey AS 'ID CLIENTE', 
	SUM(SalesQuantity) AS 'COMPRAS TOTAIS'
FROM 
	FactOnlineSales
GROUP BY CustomerKey
ORDER BY SUM(SalesQuantity) DESC

	/*b) Feito isso, fa�a um agrupamento de total vendido (SalesQuantity) por ID do produto
	e descubra quais foram os top 3 produtos mais comprados pelo cliente da letra a).*/

SELECT 
	TOP(3) ProductKey AS 'ID PRODUTO', 
	SUM(SalesQuantity) AS 'COMPRAS TOTAIS'
FROM 
	FactOnlineSales
WHERE CustomerKey = 19037
GROUP BY ProductKey
ORDER BY SUM(SalesQuantity) DESC

/* 4. a) Fa�a um agrupamento e descubra a quantidade total de produtos por marca.*/



SELECT 
	BRANDNAME AS 'MARCA DO PRODUTO', 
	COUNT(BrandName) AS 'TOTAL DE PRODUTO'
FROM 
	DimProduct
GROUP BY 
	BrandName

	  /*b) Determine a m�dia do pre�o unit�rio (UnitPrice) para cada ClassName.*/

SELECT 
	CLASSNAME AS 'NOME DA CLASSE', 
	AVG(UNITPRICE) AS 'M�DIA  DE PRECO'
FROM 
	DimProduct
GROUP BY ClassName
ORDER BY AVG(UNITPRICE) DESC


	  /*c) Fa�a um agrupamento de cores e descubra o peso total que cada cor de produto possui.*/

	  SELECT * FROM DimProduct

SELECT 
	ColorName AS 'COR',
	SUM(Weight) AS 'PESO TOTAL' 
FROM 
	DimProduct
GROUP BY 
	ColorName


/*5. Voc� dever� descobrir o peso total para cada tipo de produto (StockTypeName).

	A tabela final deve considerar apenas a marca �Contoso� e ter os seus valores classificados em
	ordem decrescente*/

SELECT 
	StockTypeName AS 'TIPO DO PRODUTO', 
	SUM(WEIGHT) AS 'PESO TOTAL' 
FROM 
	DimProduct 
WHERE BrandName = 'CONTOSO'
GROUP BY StockTypeName
ORDER BY SUM(Weight) DESC


/* 6. Voc� seria capaz de confirmar se todas as marcas dos produtos possuem � disposi��o todas as
	16 op��es de cores?*/

SELECT 
	BRANDNAME AS 'MARCA',
	COUNT(DISTINCT ColorName) AS ' TOTAL CORES DISTINTA'
FROM
	DimProduct
GROUP BY 
	BrandName

/* 7. Fa�a um agrupamento para saber o total de clientes de acordo com o Sexo e tamb�m a m�dia
	salarial de acordo com o Sexo. Corrija qualquer resultado �inesperado� com os seus
	conhecimentos em SQL.*/

SELECT 
	GENDER AS 'SEXO',
	COUNT(Gender) AS 'TOTAL CLIENTES',
	AVG(YEARLYINCOME) AS 'M�DIA SALARIAL' 
FROM 
	DimCustomer
WHERE Gender IS NOT NULL
GROUP BY Gender

/* 8. Fa�a um agrupamento para descobrir a quantidade total de clientes e a m�dia salarial de
	acordo com o seu n�vel escolar. Utilize a coluna Education da tabela DimCustomer para fazer
	esse agrupamento.*/

SELECT 
	Education AS 'NIVEL ESCOLAR', 
	COUNT(EDUCATION) AS 'QTD CLIENTES',
	AVG(YEARLYINCOME) AS 'M�DIA SALARIAL'
FROM 
	DimCustomer
WHERE Education IS NOT NULL
GROUP BY Education

/* 9. Fa�a uma tabela resumo mostrando a quantidade total de funcion�rios de acordo com o
	Departamento (DepartmentName). Importante: Voc� dever� considerar apenas os
	funcion�rios ativos.*/



SELECT 
	DepartmentName AS 'DEPARTAMENTO',
	COUNT(DepartmentName) AS 'TOTAL FUNCION�RIOS'
FROM 
	DimEmployee
WHERE Status = 'CURRENT'
GROUP BY DepartmentName

/* 10. Fa�a uma tabela resumo mostrando o total de VacationHours para cada cargo (Title). Voc�
	deve considerar apenas as mulheres, dos departamentos de Production, Marketing,
	Engineering e Finance, para os funcion�rios contratados entre os anos de 1999 e 2000.*/

SELECT * FROM DimEmployee

SELECT 
	TITLE AS 'PROFISS�O', 
	SUM(VacationHours) AS 'HORAS TRABALHADAS' 
FROM 
	DimEmployee
WHERE 
	Gender = 'F' 
	AND DepartmentName IN ('Production','Marketing','Engineering','Finance') 
	AND HireDate BETWEEN '1999-01-01' AND '2000-12-31'
GROUP BY Title





	



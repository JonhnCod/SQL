CREATE VIEW vwProdutos2 AS
SELECT
BrandName AS 'Marca',
ColorName AS 'Cor',
COUNT(*) AS 'Quantidade_Vendida',
ROUND(SUM(SalesAmount), 2) AS 'Receita_Total'
FROM DimProduct
INNER JOIN FactSales
ON DimProduct.ProductKey = FactSales.ProductKey
GROUP BY BrandName, ColorName


/*1. Utilize a View vwProdutos para criar uma coluna extra calculando a quantidade total vendida
	dos produtos.*/

SELECT 
	*,
	SUM(Quantidade_vendida) OVER() AS 'QUANTIDADE TOTAL VENDIDO'
FROM vwProdutos2


/*2. Crie mais uma coluna na consulta anterior, incluindo o total de produtos vendidos para cada
	marca.*/

SELECT 
	*,
	SUM(Quantidade_vendida) OVER() AS 'QUANTIDADE TOTAL VENDIDO',
	SUM(Quantidade_vendida) OVER(PARTITION BY MARCA) AS 'QUANTIDADE TOTAL VENDIDO POR MARCA'
FROM vwProdutos2

-- 3. Calcule o % de participação do total de vendas de produtos por marca. 

SELECT 
	*,
	SUM(Quantidade_vendida) OVER() AS 'QUANTIDADE TOTAL VENDIDO',
	SUM(Quantidade_vendida) OVER(PARTITION BY MARCA) AS 'QUANTIDADE TOTAL VENDIDO POR MARCA',
	FORMAT(CAST(SUM(Quantidade_vendida) OVER(PARTITION BY MARCA) AS DECIMAL)/SUM(Quantidade_vendida) OVER(),'0.00%') AS '% POR MARCA'
FROM vwProdutos2


/*4. Crie uma consulta à View vwProdutos, selecionando as colunas Marca, Cor,
	Quantidade_Vendida e também criando uma coluna extra de Rank para descobrir a posição de
	cada Marca/Cor. Você deve obter o resultado abaixo. Obs: Sua consulta deve ser filtrada para
	que seja mostrada apenas a marca Contoso*/


SELECT 
	Marca,
	Cor,
	Quantidade_Vendida,
	RANK() OVER(ORDER BY Quantidade_Vendida DESC)
FROM vwProdutos2
WHERE MARCA = 'CONTOSO'

/*Exercício Desafio 1

	Para responder os próximos 2 exercícios, você precisará criar uma View auxiliar. Diferente do
	que foi feito anteriormente, você não terá acesso ao código dessa view antes do gabarito.
	A sua view deve se chamar vwHistoricoLojas e deve conter um histórico com a quantidade de
	lojas abertas a cada Ano/Mês. Os desafios são:

	(1) Criar uma coluna de ID para essa View
	(2) Relacionar as tabelas DimDate e DimStore
	Dicas:

	1- A coluna de ID será criada a partir de uma função de janela. Você deverá se atentar a forma
	como essa coluna deverá ser ordenada, pensando que queremos visualizar uma ordem de
	Ano/Mês que seja: 2005/january, 2005/February... e não 2005/April, 2005/August...

	2- As colunas Ano, Mês e Qtd_Lojas correspondem, respectivamente, às seguintes colunas:
	CalendarYear e CalendarMonthLabel da tabela DimDate e uma contagem da coluna OpenDate
	da tabela DimStore.*/


CREATE VIEW vwHistoricoLojas AS (
SELECT
	 ROW_NUMBER() OVER(ORDER BY CALENDARMONTH) AS 'ID',
	 CalendarYear AS 'ANO',
	 CalendarMonthLabel AS 'MÊS',
	 COUNT(OPENDATE) AS 'QNTD_LOJAS'
FROM DimDate
LEFT JOIN DIMSTORE ON DimDate.Datekey = DimStore.OpenDate
GROUP BY CalendarYear,CalendarMonthLabel,CalendarMonth
)



/*5. A partir da view criada no exercício anterior, você deverá fazer uma soma móvel
	considerando sempre o mês atual + 2 meses para trás.*/

SELECT 
	*,
	SUM(QNTD_LOJAS) OVER(ORDER BY ID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS 'SOMA MÓVEL'
FROM vwHistoricoLojas

-- 6. Utilize a vwHistoricoLojas para calcular o acumulado de lojas abertas a cada ano/mês.

SELECT 
	*,
	SUM(QNTD_LOJAS) OVER(ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'SOMA MÓVEL'
FROM vwHistoricoLojas

SELECT * FROM DimCustomer


/*Neste desafio, você terá que criar suas próprias tabelas e views para conseguir resolver os
	exercícios 7 e 8. Os próximos exercícios envolverão análises de novos clientes. Para isso, será
	necessário criar uma nova tabela e uma nova view*/


/*PASSO 1: Crie um novo banco de dados chamado Desafio e selecione esse banco de dados
	criado.*/
CREATE DATABASE DESAFIO

USE DESAFIO
CREATE TABLE CALENDARIO(
DATA DATE)


/*PASSO 2: Crie uma tabela de datas entre o dia 1 de janeiro do ano com a compra
(DateFirstPurchase) mais antiga e o dia 31 de dezembro do ano com a compra mais recente. */


DECLARE @AnoInicial INT = YEAR((SELECT MIN(DateFirstPurchase) FROM ContosoRetailDW.dbo.DimCustomer))
DECLARE @AnoFinal INT = YEAR((SELECT MAX(DateFirstPurchase) FROM ContosoRetailDW.dbo.DimCustomer))

DECLARE @DataInicial DATE = DATEFROMPARTS(@AnoInicial,1,1)
DECLARE @DataFinal DATE = DATEFROMPARTS(@AnoFinal,12,31)

WHILE @DataInicial <= @DataFinal
BEGIN
	INSERT INTO CALENDARIO(DATA)VALUES(@DataInicial)
	SET @DataInicial = DATEADD(DAY,1,@DataInicial)
END

/*PASSO 3: Crie colunas auxiliares na tabela Calendario chamadas: Ano, Mes, Dia, AnoMes e
NomeMes. Todas do tipo INT.*/ALTER TABLE CALENDARIO ADD Ano INT ,	Mes INT,	Dia INT,	AnoMes INT,	NomeMes VARCHAR(50)/*PASSO 4: Adicione na tabela os valores de Ano, Mês, Dia, AnoMes e NomeMes (nome do mês
em português). Dica: utilize a instrução CASE para verificar o mês e retornar o nome certo.*/SELECT * FROM CALENDARIOUPDATE CALENDARIO SET Ano = YEAR(DATA)UPDATE CALENDARIO SET Mes = MONTH(DATA)UPDATE CALENDARIO SET Dia = DAY(DATA)UPDATE CALENDARIO SET AnoMes = CONCAT(YEAR(DATA),FORMAT(MONTH(DATA),'00'))UPDATE CALENDARIO SET NomeMes =								CASE 									WHEN MONTH(DATA) = 1 THEN 'Janeiro'									WHEN MONTH(DATA) = 2 THEN 'Fevereiro'									WHEN MONTH(DATA) = 3 THEN 'Março'									WHEN MONTH(DATA) = 4 THEN 'Abril'									WHEN MONTH(DATA) = 5 THEN 'Maio'									WHEN MONTH(DATA) = 6 THEN 'Junho'									WHEN MONTH(DATA) = 7 THEN 'Julho'									WHEN MONTH(DATA) = 8 THEN 'Agosto'									WHEN MONTH(DATA) = 9 THEN 'Setembro'									WHEN MONTH(DATA) = 10 THEN 'Outubro'									WHEN MONTH(DATA) = 11 THEN 'Novembro'									WHEN MONTH(DATA) = 12 THEN 'Dezembro'								END
-- PASSO 5: Crie a View vwNovosClientes, que deve ter as colunas mostradas abaixo.

CREATE VIEW vwNovosClientes AS
SELECT 
	ROW_NUMBER() OVER(ORDER BY ANOMES) AS 'ID',
	ANO,
	NOMEMES,
	COUNT(CDD.DateFirstPurchase) AS 'Novos_Clientes'
FROM 
	CALENDARIO
LEFT JOIN ContosoRetailDW.dbo.DimCustomer CDD
	ON CALENDARIO.DATA = CDD.DateFirstPurchase
GROUP BY ANO,NOMEMES,ANOMES

SELECT * FROM vwNovosClientes



-- 7.
-- a) Faça um cálculo de soma móvel de novos clientes nos últimos 2 meses.
SELECT *,
	SUM(Novos_clientes) OVER(ORDER BY ID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS 'SOMA MOVEL (2 MESES)'
FROM vwNovosClientes 

-- b) Faça um cálculo de média móvel de novos clientes nos últimos 2 meses.
SELECT *,
	AVG(Novos_clientes) OVER(ORDER BY ID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS 'SOMA MOVEL (2 MESES)'
FROM vwNovosClientes 

-- c) Faça um cálculo de acumulado dos novos clientes ao longo do tempo.
SELECT 
	*,
	SUM(Novos_clientes) OVER(ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'SOMA MÓVEL'
FROM vwNovosClientes
-- d) Faça um cálculo de acumulado intra-ano, ou seja, um acumulado que vai de janeiro a
-- dezembro de cada ano, e volta a fazer o cálculo de acumulado no ano seguinte.*/SELECT 
	*,
	SUM(Novos_clientes) OVER(PARTITION BY ANO ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'SOMA MÓVEL'
FROM vwNovosClientes-- 8. Faça os cálculos de MoM e YoY para avaliar o percentual de crescimento de novos clientes,
-- entre o mês atual e o mês anterior, e entre um mês atual e o mesmo mês do ano anterior.SELECT
*,
FORMAT(CONVERT(FLOAT, Novos_Clientes)/NULLIF(LAG(Novos_Clientes, 1)
OVER(ORDER BY ID), 0) - 1, '0.00%') AS '% MoM',
FORMAT(CONVERT(FLOAT, Novos_Clientes)/NULLIF(LAG(Novos_Clientes, 12)
OVER(ORDER BY ID), 0) - 1, '0.00%') AS '% YoY'
FROM vwNovosClientes

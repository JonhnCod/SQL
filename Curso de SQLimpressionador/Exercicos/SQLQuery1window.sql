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

-- 3. Calcule o % de participa��o do total de vendas de produtos por marca. 

SELECT 
	*,
	SUM(Quantidade_vendida) OVER() AS 'QUANTIDADE TOTAL VENDIDO',
	SUM(Quantidade_vendida) OVER(PARTITION BY MARCA) AS 'QUANTIDADE TOTAL VENDIDO POR MARCA',
	FORMAT(CAST(SUM(Quantidade_vendida) OVER(PARTITION BY MARCA) AS DECIMAL)/SUM(Quantidade_vendida) OVER(),'0.00%') AS '% POR MARCA'
FROM vwProdutos2


/*4. Crie uma consulta � View vwProdutos, selecionando as colunas Marca, Cor,
	Quantidade_Vendida e tamb�m criando uma coluna extra de Rank para descobrir a posi��o de
	cada Marca/Cor. Voc� deve obter o resultado abaixo. Obs: Sua consulta deve ser filtrada para
	que seja mostrada apenas a marca Contoso*/


SELECT 
	Marca,
	Cor,
	Quantidade_Vendida,
	RANK() OVER(ORDER BY Quantidade_Vendida DESC)
FROM vwProdutos2
WHERE MARCA = 'CONTOSO'

/*Exerc�cio Desafio 1

	Para responder os pr�ximos 2 exerc�cios, voc� precisar� criar uma View auxiliar. Diferente do
	que foi feito anteriormente, voc� n�o ter� acesso ao c�digo dessa view antes do gabarito.
	A sua view deve se chamar vwHistoricoLojas e deve conter um hist�rico com a quantidade de
	lojas abertas a cada Ano/M�s. Os desafios s�o:

	(1) Criar uma coluna de ID para essa View
	(2) Relacionar as tabelas DimDate e DimStore
	Dicas:

	1- A coluna de ID ser� criada a partir de uma fun��o de janela. Voc� dever� se atentar a forma
	como essa coluna dever� ser ordenada, pensando que queremos visualizar uma ordem de
	Ano/M�s que seja: 2005/january, 2005/February... e n�o 2005/April, 2005/August...

	2- As colunas Ano, M�s e Qtd_Lojas correspondem, respectivamente, �s seguintes colunas:
	CalendarYear e CalendarMonthLabel da tabela DimDate e uma contagem da coluna OpenDate
	da tabela DimStore.*/


CREATE VIEW vwHistoricoLojas AS (
SELECT
	 ROW_NUMBER() OVER(ORDER BY CALENDARMONTH) AS 'ID',
	 CalendarYear AS 'ANO',
	 CalendarMonthLabel AS 'M�S',
	 COUNT(OPENDATE) AS 'QNTD_LOJAS'
FROM DimDate
LEFT JOIN DIMSTORE ON DimDate.Datekey = DimStore.OpenDate
GROUP BY CalendarYear,CalendarMonthLabel,CalendarMonth
)



/*5. A partir da view criada no exerc�cio anterior, voc� dever� fazer uma soma m�vel
	considerando sempre o m�s atual + 2 meses para tr�s.*/

SELECT 
	*,
	SUM(QNTD_LOJAS) OVER(ORDER BY ID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS 'SOMA M�VEL'
FROM vwHistoricoLojas

-- 6. Utilize a vwHistoricoLojas para calcular o acumulado de lojas abertas a cada ano/m�s.

SELECT 
	*,
	SUM(QNTD_LOJAS) OVER(ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'SOMA M�VEL'
FROM vwHistoricoLojas

SELECT * FROM DimCustomer


/*Neste desafio, voc� ter� que criar suas pr�prias tabelas e views para conseguir resolver os
	exerc�cios 7 e 8. Os pr�ximos exerc�cios envolver�o an�lises de novos clientes. Para isso, ser�
	necess�rio criar uma nova tabela e uma nova view*/


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
NomeMes. Todas do tipo INT.*/ALTER TABLE CALENDARIO ADD Ano INT ,	Mes INT,	Dia INT,	AnoMes INT,	NomeMes VARCHAR(50)/*PASSO 4: Adicione na tabela os valores de Ano, M�s, Dia, AnoMes e NomeMes (nome do m�s
em portugu�s). Dica: utilize a instru��o CASE para verificar o m�s e retornar o nome certo.*/SELECT * FROM CALENDARIOUPDATE CALENDARIO SET Ano = YEAR(DATA)UPDATE CALENDARIO SET Mes = MONTH(DATA)UPDATE CALENDARIO SET Dia = DAY(DATA)UPDATE CALENDARIO SET AnoMes = CONCAT(YEAR(DATA),FORMAT(MONTH(DATA),'00'))UPDATE CALENDARIO SET NomeMes =								CASE 									WHEN MONTH(DATA) = 1 THEN 'Janeiro'									WHEN MONTH(DATA) = 2 THEN 'Fevereiro'									WHEN MONTH(DATA) = 3 THEN 'Mar�o'									WHEN MONTH(DATA) = 4 THEN 'Abril'									WHEN MONTH(DATA) = 5 THEN 'Maio'									WHEN MONTH(DATA) = 6 THEN 'Junho'									WHEN MONTH(DATA) = 7 THEN 'Julho'									WHEN MONTH(DATA) = 8 THEN 'Agosto'									WHEN MONTH(DATA) = 9 THEN 'Setembro'									WHEN MONTH(DATA) = 10 THEN 'Outubro'									WHEN MONTH(DATA) = 11 THEN 'Novembro'									WHEN MONTH(DATA) = 12 THEN 'Dezembro'								END
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
-- a) Fa�a um c�lculo de soma m�vel de novos clientes nos �ltimos 2 meses.
SELECT *,
	SUM(Novos_clientes) OVER(ORDER BY ID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS 'SOMA MOVEL (2 MESES)'
FROM vwNovosClientes 

-- b) Fa�a um c�lculo de m�dia m�vel de novos clientes nos �ltimos 2 meses.
SELECT *,
	AVG(Novos_clientes) OVER(ORDER BY ID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS 'SOMA MOVEL (2 MESES)'
FROM vwNovosClientes 

-- c) Fa�a um c�lculo de acumulado dos novos clientes ao longo do tempo.
SELECT 
	*,
	SUM(Novos_clientes) OVER(ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'SOMA M�VEL'
FROM vwNovosClientes
-- d) Fa�a um c�lculo de acumulado intra-ano, ou seja, um acumulado que vai de janeiro a
-- dezembro de cada ano, e volta a fazer o c�lculo de acumulado no ano seguinte.*/SELECT 
	*,
	SUM(Novos_clientes) OVER(PARTITION BY ANO ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'SOMA M�VEL'
FROM vwNovosClientes-- 8. Fa�a os c�lculos de MoM e YoY para avaliar o percentual de crescimento de novos clientes,
-- entre o m�s atual e o m�s anterior, e entre um m�s atual e o mesmo m�s do ano anterior.SELECT
*,
FORMAT(CONVERT(FLOAT, Novos_Clientes)/NULLIF(LAG(Novos_Clientes, 1)
OVER(ORDER BY ID), 0) - 1, '0.00%') AS '% MoM',
FORMAT(CONVERT(FLOAT, Novos_Clientes)/NULLIF(LAG(Novos_Clientes, 12)
OVER(ORDER BY ID), 0) - 1, '0.00%') AS '% YoY'
FROM vwNovosClientes

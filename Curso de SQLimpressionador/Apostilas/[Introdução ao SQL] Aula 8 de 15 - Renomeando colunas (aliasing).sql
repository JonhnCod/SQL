-- [SQL Server] Introdução ao SQL
-- Aula 8 de 15: Renomeando colunas (aliasing)

-- Comando AS: Renomeando colunas (aliasing)

-- Selecione as 3 colunas da tabela DimProduct: ProductName, BrandName e ColorName

SELECT
	ProductName AS Produto,
	BrandName AS Marca,
	ColorName AS Cor
FROM 
	DimProduct
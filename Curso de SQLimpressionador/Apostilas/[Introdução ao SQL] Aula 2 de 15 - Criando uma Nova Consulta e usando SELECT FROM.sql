-- [SQL Server] Introdução ao SQL
-- Aula 2 de 15: Criando uma Nova Consulta e usando SELECT FROM


-- Selecionando todas as linhas e colunas da tabela DimCustomer
SELECT * FROM DimCustomer

-- Selecionando todas as linhas e colunas da tabela DimStore
SELECT * FROM DimStore

-- Selecionando todas as linhas da tabela DimCustomer, especificamente as colunas StoreKey, StoreName, StorePhone
SELECT StoreKey, StoreName, StorePhone FROM DimStore

-- Selecionando todas as linhas e colunas da tabela DimProduct
SELECT * FROM DimProduct

-- Selecionando todas as linhasda tabela DimProduct, especificamente as colunas ProductName, BrandName
SELECT ProductName, BrandName FROM DimProduct
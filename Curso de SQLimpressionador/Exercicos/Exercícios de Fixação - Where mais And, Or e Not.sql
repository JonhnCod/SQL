-- [SQL Server] Ordenando e filtrando dados
-- Aula 11 de 27: Exercícios de Fixação - Where mais And, Or e Not

-- Podemos filtrar os dados nas nossas tabelas utilizando o comando WHERE

-- 1. Selecione todas as linhas da tabela DimEmployee de funcionários do sexo feminino E do departamento de finanças.

SELECT * FROM DimEmployee
WHERE Gender = 'F' AND DepartmentName = 'Finance'

-- 2. Selecione todas as linhas da tabela DimProduct de produtos Contoso E da cor vermelha E que tenham um UnitPrice maior ou igual a $100.

SELECT * FROM DimProduct
WHERE BrandName = 'Contoso' AND ColorName = 'Red' AND UnitPrice >= 100


-- 3. Selecione todas as linhas da tabela DimProduct com produtos da marca Litware OU da marca Fabrikam OU da cor Preta.

SELECT * FROM DimProduct
WHERE BrandName = 'Litware' OR BrandName = 'Fabrikam' OR ColorName = 'Black'

-- 4. Selecione todas as linhas da tabela DimSalesTerritory onde o continente é a Europa mas o país NÃO é a Itália.

SELECT * FROM DimSalesTerritory
WHERE SalesTerritoryGroup = 'Europe' AND NOT SalesTerritoryCountry = 'Italy'

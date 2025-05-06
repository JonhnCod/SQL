/* 1. Declare 4 vari�veis inteiras. Atribua os seguintes valores a elas:

	valor1 = 10
	valor2 = 5
	valor3 = 34
	valor4 = 7*/

DECLARE 
	@valor1 AS FLOAT = 10,
	@valor2 AS FLOAT = 5,
	@valor3 AS FLOAT = 34,
	@valor4 AS FLOAT = 7

	/*a) Crie uma nova vari�vel para armazenar o resultado da soma entre valor1 e valor2. Chame
	essa vari�vel de soma.*/

DECLARE @SOMA AS FLOAT = @valor1 + @valor2
SELECT @SOMA

	/*b) Crie uma nova vari�vel para armazenar o resultado da subtra��o entre valor3 e valor 4.
	Chame essa vari�vel de subtracao.*/
DECLARE @SUBTRACAO AS FLOAT = @valor3 - @valor4
SELECT @SUBTRACAO

	/*c) Crie uma nova vari�vel para armazenar o resultado da multiplica��o entre o valor 1 e o
	valor4. Chame essa vari�vel de multiplicacao.*/

DECLARE @MULTIPLICACAO AS FLOAT = @valor1 * @valor4
SELECT @MULTIPLICACAO


	/*d) Crie uma nova vari�vel para armazenar o resultado da divis�o do valor3 pelo valor4. Chame
	essa vari�vel de divisao. Obs: O resultado dever� estar em decimal, e n�o em inteiro.*/

DECLARE @DIVISAO AS FLOAT = @valor3 / @valor4
SELECT @DIVISAO


	/*e) Arredonde o resultado da letra d) para 2 casas decimais.*/

DECLARE @DIVISAODECIMAL AS DECIMAL(5,2) = @valor3 / @valor4
SELECT @DIVISAODECIMAL


/* 2. Para cada declara��o das vari�veis abaixo, aten��o em rela��o ao tipo de dado que dever� ser
	especificado.

	a) Declare uma vari�vel chamada �produto� e atribua o valor de �Celular�.*/

DECLARE @produto AS VARCHAR(50) = 'CELULAR'

	/*b) Declare uma vari�vel chamada �quantidade� e atribua o valor de 12.*/

DECLARE @quantidade AS INT = 12

	/*c) Declare uma vari�vel chamada �preco� e atribua o valor 9.99.*/

DECLARE @preco AS FLOAT = 9.99

	/*d) Declare uma vari�vel chamada �faturamento� e atribua o resultado da multiplica��o entre
	�quantidade� e �preco�.*/

DECLARE @faturamento AS FLOAT = @quantidade * @preco

	/*e) Visualize o resultado dessas 4 vari�veis em uma �nica consulta, por meio do SELECT.*/

SELECT 
	@produto AS 'PRODUTO',
	@quantidade AS 'QUANTIDADE',
	@preco AS 'PRECO',
	@faturamento AS 'FATURAMENTO'

/*	3. Voc� � respons�vel por gerenciar um banco de dados onde s�o recebidos dados externos de
	usu�rios. Em resumo, esses dados s�o:

	- Nome do usu�rio
	- Data de nascimento
	- Quantidade de pets que aquele usu�rio possui

	Voc� precisar� criar um c�digo em SQL capaz de juntar as informa��es fornecidas por este
	usu�rio. Para simular estes dados, crie 3 vari�veis, chamadas: nome, data_nascimento e
	num_pets. Voc� dever� armazenar os valores �Andr�, �10/02/1998� e 2, respectivamente.
	Dica: voc� precisar� utilizar as fun��es CAST e FORMAT para chegar no resultado*/

DECLARE 
	@nome AS VARCHAR(50) = 'Andr�',
	@data_nascimento AS DATETIME = '10/02/1998',
	@num_pet AS INT = 2

SELECT 
	'Meu nome � ' +  @nome + ' nasci em ' + FORMAT(@data_nascimento,'dd/MM/yyyy') + ' e tenho ' + CAST(@num_pet AS VARCHAR(50)) + ' pets.' AS 'COLUNA'

/*	4. Voc� acabou de ser promovido e o seu papel ser� realizar um controle de qualidade sobre as
	lojas da empresa.

	A primeira informa��o que � passada a voc� � que o ano de 2008 foi bem complicado para a
	empresa, pois foi quando duas das principais lojas fecharam. O seu primeiro desafio � descobrir
	o nome dessas lojas que fecharam no ano de 2008, para que voc� possa entender o motivo e
	mapear planos de a��o para evitar que outras lojas importantes tomem o mesmo caminho.
	O seu resultado dever� estar estruturado em uma frase, com a seguinte estrutura:
	�As lojas fechadas no ano de 2008 foram: � + nome_das_lojas
	Obs: utilize o comando PRINT (e n�o o SELECT!) para mostrar o resultado.*/


DECLARE @nome_das_lojas VARCHAR(100) = ''
SELECT @nome_das_lojas = @nome_das_lojas + StoreName + ', '
from DimStore
WHERE Status = 'OFF' AND CloseDate between '01-01-2008' AND '31-12-2008'
PRINT 'As lojas fechadas no ano de 2008 foram: ' + @nome_das_lojas

/*	5. Voc� precisa criar uma consulta para mostrar a lista de produtos da tabela DimProduct para
	uma subcategoria espec�fica: �Lamps�.
	Utilize o conceito de vari�veis para chegar neste resultado.*/


DECLARE @productSubcategoria VARCHAR(50) = 'Lamps'
SELECT 
	ProductName
from
	DimProduct
INNER JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
WHERE ProductSubcategoryName = @productSubcategoria


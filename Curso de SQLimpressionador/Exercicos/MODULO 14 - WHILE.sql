
/* 1. Utilize o Loop While para criar um contador que comece em um valor inicial @ValorInicial e
	termine em um valor final @ValorFinal. Você deverá printar na tela a seguinte frase:
	“O valor do contador é: “ + ___*/DECLARE @ValorInicial INT = 1
DECLARE @ValorFinal INT = 15


WHILE @ValorInicial <= @ValorFinal 
BEGIN 
	PRINT 'O Valor do contador é: ' +	CONVERT(VARCHAR,@ValorINICIAL)
	SET @ValorInicial+= 1
END/* 2. Você deverá criar uma estrutura de repetição que printe na tela a quantidade de contratações
	para cada ano, desde 1996 até 2003. A informação de data de contratação encontra-se na
	coluna HireDate da tabela DimEmployee. Utilize o formato:
	X contratações em 1996
	Y contratações em 1997
	Z contratações em 1998
	...
	...
	N contratações em 2003
	Obs: a coluna HireDate contém a data completa (dd/mm/aaaa). Lembrando que você deverá
	printar a quantidade de contratações por ano.*/DECLARE @anoInicial INT = 1996DECLARE @anoFinal INT = 2003WHILE @anoInicial <= @anoFinalBEGINDECLARE @Funcionarios INT = (SELECT COUNT(*) FROM DimEmployee WHERE YEAR(HIREDATE) = @anoInicial)PRINT CONCAT(@Funcionarios , ' contratações em ',@anoInicial)SET @anoInicial+=1END/* 3. Utilize um Loop While para criar uma tabela chamada Calendario, contendo uma coluna que
	comece com a data 01/01/2021 e vá até 31/12/2021.*/CREATE TABLE Calendario (DATA DATE)DECLARE @DataInicio DATE = '01/01/2021'DECLARE @DataFinal DATE = '31/12/2021'DECLARE @dataAgora DATE = @DataInicioWHILE @DataAgora <= @DataFinalBEGIN	INSERT INTO Calendario(DATA)	VALUES (@dataAgora)	SET @dataAgora = DATEADD(d,1,@dataAgora)ENDSELECT FORMAT(DATA,'dd/MM/yy') AS 'Data' FROM Calendario
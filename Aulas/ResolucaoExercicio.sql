/*
	PROCEDURE sp_exCalc PARA CALCULAR FIBO, FAT, IRRAF 
*/
USE DB_CD
GO

IF NOT EXISTS (SELECT 1 FROM sys.all_objects WHERE name LIKE 'SP_EXCALC' AND type = 'P')
BEGIN
	EXEC ('CREATE PROCEDURE SP_EXCALC AS SELECT 1 ') 
END 
GO

ALTER PROCEDURE SP_EXCALC (@VALOR FLOAT, @TIPO_CALCULO VARCHAR(10))
AS 

	IF(@TIPO_CALCULO = 'FIBO')
	BEGIN
		
		DECLARE 
			 @F1 INT = 0
			,@F2 INT = 1 
			,@FN INT = 0 

		PRINT @FN

		WHILE @FN <= @VALOR 
		BEGIN
			
			SET @FN = @F2 + @F1

			IF @FN <= @VALOR 
			BEGIN 
				PRINT @FN 
			END

			SET @F1 = @F2 
			SET @F2 = @FN
			 
		END
		
	END
	
	ELSE IF(@TIPO_CALCULO = 'FAT')
	BEGIN
	
		DECLARE 
			 @F INT = 1 
			,@CONT INT = 1
			 
		WHILE @CONT <= @VALOR 
		BEGIN
			SET @F = @F * @CONT 
			PRINT @F 
			SET @CONT = @CONT + 1 
		END 
		
	END

	ELSE IF(@TIPO_CALCULO = 'IRRF')
	BEGIN
		 
		 IF(@VALOR <= 1751.81)
		 BEGIN
			PRINT @VALOR * 0.92 
		 END 

		 ELSE IF(@VALOR > 1751.81 AND @VALOR <= 2919.72)
		 BEGIN
			PRINT @VALOR * 0.91
		 END

		 ELSE IF(@VALOR > 2919.72 AND @VALOR <= 5839.45)
		 BEGIN
			PRINT @VALOR * 0.89 
		 END

		 ELSE IF(@VALOR > 5839.45)
		 BEGIN
			PRINT @VALOR - 642.34 
		 END
	END

	ELSE IF(@TIPO_CALCULO = 'DESC')
	BEGIN
		 PRINT @VALOR * 0.1
	END 

	ELSE IF(@TIPO_CALCULO = 'AUM') 
	BEGIN 
		PRINT @VALOR * 1.1
	END


GO

IF NOT EXISTS (SELECT 1 FROM sys.all_objects WHERE name LIKE 'sp_exMedia')
BEGIN
	EXEC ('CREATE PROCEDURE sp_exMedia AS SELECT 1')
	 
END

GO 

ALTER PROCEDURE SP_EXMEDIA (@NOTA1 FLOAT, @NOTA2 FLOAT, @NOTA3 FLOAT, @TIPO VARCHAR(15))
AS 
BEGIN

	DECLARE 
		 @MEDIA FLOAT =  (@NOTA1 + @NOTA2 + @NOTA3 ) / 3
		,@FALTA FLOAT = 0

	SET @FALTA = @MEDIA - 10 

	IF (ABS(@FALTA) > 6)
	BEGIN 
		PRINT 'AINDA FALTAM ' + CONVERT(VARCHAR(10), ROUND(ABS(@FALTA), 2)) 
	END
	ELSE IF(@FALTA < 6) 

	BEGIN
		PRINT 'NOTA SUFICIENTE PARA PASSAR' 
	END

	
	 
	 
END 
GO

--EXEC sp_exMedia 2, 2, 2, 'FMEDIA';
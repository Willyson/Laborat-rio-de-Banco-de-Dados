USE DB_CD
GO 

 
 IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE NAME = 'AUDITORIA')
BEGIN
	CREATE TABLE AUDITORIA 
	(
		 ID_LOG INT NOT NULL IDENTITY
		,USUARIO VARCHAR(40)
		,ACAO    VARCHAR(40) 
		,TABELA VARCHAR(40) 
		,DATA DATETIME 
		,CODIGO_ALTERADO INT
	)
END
GO


IF NOT EXISTS (SELECT 1 FROM SYS.triggers WHERE NAME = 'TR_AUDITORIA_MUSICA_INSERE')
BEGIN 
	EXEC ('CREATE TRIGGER TR_AUDITORIA_MUSICA_INSERE ON MUSICA FOR INSERT AS SELECT 1')
END 
GO 

ALTER TRIGGER TR_AUDITORIA_MUSICA_INSERE
	ON MUSICA
	FOR INSERT
	AS 

	INSERT INTO AUDITORIA 
		SELECT 
			SUSER_NAME() 
			,'INSERT'
			,'dbo.MUSICA'
			,GETDATE()
			,CODIGO_MUSICA
		FROM INSERTED 

GO


IF NOT EXISTS (SELECT 1 FROM SYS.triggers WHERE NAME = 'TR_AUDITORIA_MUSICA_DELETE')
BEGIN 
	EXEC ('CREATE TRIGGER TR_AUDITORIA_MUSICA_DELETE ON MUSICA FOR INSERT AS SELECT 1')
END 
GO 

ALTER TRIGGER TR_AUDITORIA_MUSICA_DELETE
	ON MUSICA
	FOR DELETE
	AS 

	INSERT INTO AUDITORIA 
		SELECT 
			SUSER_NAME() 
			,'DELETE'
			,'dbo.MUSICA'
			,GETDATE()
			,CODIGO_MUSICA
		FROM DELETED 

GO



IF NOT EXISTS (SELECT 1 FROM SYS.triggers WHERE NAME = 'TR_AUDITORIA_MUSICA_UPDATE')
BEGIN 
	EXEC ('CREATE TRIGGER TR_AUDITORIA_MUSICA_UPDATE ON MUSICA FOR INSERT AS SELECT 1')
END 
GO 

ALTER TRIGGER TR_AUDITORIA_MUSICA_UPDATE
	ON MUSICA
	FOR UPDATE
	AS 

	INSERT INTO AUDITORIA 
		SELECT 
			SUSER_NAME() 
			,'UPDATE'
			,'dbo.MUSICA'
			,GETDATE()
			,CODIGO_MUSICA
		FROM INSERTED 

GO



EXEC SP_PREENCHE_DB_CD 'MUSICA', 3

SELECT * FROM MUSICA

UPDATE MUSICA 
SET NOME_MUSICA = 'STARMAN'
WHERE CODIGO_MUSICA = 2

SELECT * FROM AUDITORIA
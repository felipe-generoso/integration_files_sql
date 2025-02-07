﻿USE [DB_PMITG_FGOS]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[INTEGRACAO_PMITG]
AS
BEGIN

	DECLARE @DIRETORIO_CLIENTES    VARCHAR(200) = 'C:\PMITG\CLIENTES'
	DECLARE @DIRETORIO_PEDIDOS     VARCHAR(200) = 'C:\PMITG\PEDIDOS'
	DECLARE @NOME_ARQUIVO          VARCHAR(200)
	DECLARE @ID_INTEGRACAO_ARQUIVO NUMERIC(15)
	DECLARE @TABELA		       VARCHAR(200)

	--Identifica os arquivos no diretório

	EXEC GETFILES @DIRETORIO_CLIENTES, 'CLIENTES'

	EXEC GETFILES @DIRETORIO_PEDIDOS, 'PEDIDOS'
	
	IF OBJECT_ID('TEMPDB..#ARQUIVOS') IS NOT NULL
		DROP TABLE #ARQUIVOS

	SELECT *
	  INTO #ARQUIVOS
	  FROM INTEGRACAO_ARQUIVOS WITH(NOLOCK)
	 WHERE STATUS_PROCESSAMENTO = 'PENDENTE'

	WHILE EXISTS (SELECT TOP 1 1 FROM #ARQUIVOS)
	BEGIN

		SELECT @NOME_ARQUIVO	      = NOME_ARQUIVO 
		      ,@ID_INTEGRACAO_ARQUIVO = ID_INTEGRACAO_ARQUIVO
		      ,@TABELA	              = TABELA
		  FROM #ARQUIVOS

		IF @TABELA = 'CLIENTES'
		BEGIN

			--Integra Clientes

			EXEC INTEGRACAO_CLIENTES @DIRETORIO_CLIENTES, @NOME_ARQUIVO

			UPDATE INTEGRACAO_ARQUIVOS
			   SET STATUS_PROCESSAMENTO = 'PROCESSADO'
			 WHERE ID_INTEGRACAO_ARQUIVO = @ID_INTEGRACAO_ARQUIVO

	    END

		IF @TABELA = 'PEDIDOS'
		BEGIN

			--Integra Pedidos

			EXEC INTEGRACAO_PEDIDOS @DIRETORIO_PEDIDOS, @NOME_ARQUIVO

			UPDATE INTEGRACAO_ARQUIVOS
			   SET STATUS_PROCESSAMENTO = 'PROCESSADO'
			 WHERE ID_INTEGRACAO_ARQUIVO = @ID_INTEGRACAO_ARQUIVO

		END

		DELETE 
		  FROM #ARQUIVOS 
		 WHERE ID_INTEGRACAO_ARQUIVO = @ID_INTEGRACAO_ARQUIVO

	END

END
GO

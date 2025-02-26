﻿USE [DB_PMITG_FGOS]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[MES_ANIVERSARIO] (@DATA DATE)
RETURNS INT
AS
BEGIN

  DECLARE @ANIVERSARIO INT = 0 --1 para sim, 0 para não.

	SELECT @ANIVERSARIO = 1 
	 WHERE DATEDIFF(MONTH,GETDATE(),@DATA) = 0	

  RETURN @ANIVERSARIO

END
GO

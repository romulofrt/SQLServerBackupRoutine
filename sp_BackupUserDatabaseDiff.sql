USE [master]
GO
/****** Object:  StoredProcedure [dbo].[sp_BackupUserDatabaseDiff]    Script Date: 09/03/2023 14:02:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[sp_BackupUserDatabaseDiff](
@database_name VARCHAR(100),
@unidade VARCHAR(3),
@diretorio VARCHAR(100),
@bkp_set VARCHAR(100)
)
AS
SET NOCOUNT ON;
SET LANGUAGE 'Brazilian';

BEGIN
			

			DECLARE @caminho VARCHAR(256) 
			DECLARE @nomedoarquivo NVARCHAR(256) 
			DECLARE @dataBKP VARCHAR(20)
			DECLARE @num_hr_bkp VARCHAR(2) 
			DECLARE @num_min_bkp VARCHAR(2)
			DECLARE @dia_hj VARCHAR(2)
			DECLARE @NomeMes VARCHAR(100)
			DECLARE @retorno INT
			DECLARE @Mes VARCHAR(2)
			DECLARE @Ano VARCHAR(4)
			DECLARE @bkpset VARCHAR(100)
			

			SET @dia_hj = DATEPART(DD, GETDATE()) 
			SET @num_hr_bkp = DATEPART(HH, GETDATE()) 
			SET @num_min_bkp = DATEPART(MI, GETDATE()) 
			SET @NomeMes =  REPLACE(UPPER(DATENAME(MONTH,GETDATE())),'MARÇO','MARCO')
			SET @Mes = MONTH(GETDATE())
			SET @Ano = YEAR(GETDATE())

			

			SET @nomedoarquivo = @database_name+'_'+ CONVERT(VARCHAR(10),GETDATE(),112)+'_'+ @num_hr_bkp +'-'+@num_min_bkp+'_Diff'+'.bak'
			SET @caminho = N''+@unidade+'\'+@diretorio+'\'+@Ano+'\'+@Mes+'-'+@NomeMes+'\'+@nomedoarquivo+''
			
			
			BACKUP DATABASE @database_name TO  DISK = @caminho
			WITH  DIFFERENTIAL , NOFORMAT, NOINIT,  NAME = @bkp_set, SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10

					
			DECLARE @backupSetId AS INT
			SELECT 
				@backupSetId = position 
			FROM msdb..backupset 
			WHERE 
				database_name = @database_name 
			and backup_set_id = (select max(backup_set_id) from msdb..backupset where database_name = @database_name )


			IF @backupSetId is null 
			BEGIN 
				RAISERROR(N'Falha na verificação. Informação de backup para a base de dados %s não foi encontrado.', 16, 1,@database_name)
			END

			RESTORE VERIFYONLY FROM  DISK = @caminho WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND
			

END

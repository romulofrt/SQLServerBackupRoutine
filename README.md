# SQLServerBackupRoutine
São um conjunto de scrips baseado em store procedures com rotinas de backup: Full, Differencial e Transaction Log para SQL Server. Junto com esse conjunto existe um script Power Shell para criar um estrutura de pasta composto com base de dados de sistema(master, model e msdb) e base de dados de usuário conforme exemplo:

## Estrutura de Pasta                     
E:\<Pasta com o nome da base>\<pasta com o ano>\<pastas com os meses do ano>\<arquivos de backup>                   

## Setup
Primeiro passo e executar o script PowerShell CriaEstruturaPastaSQLServer.ps1 em seguida executar as procedures sp_BackupUserDatabaseDiff.sql, sp_BackupUserDatabaseFull.sql e
sp_BackupUserDatabaseTlog.sql para cria-las. Sugiro que crie em base de dados de sistemas, msdb ou master.

Feito isso crie um Job no SQL Server Agent para criar a estrutura de pasta e execução das procedures de acordo com o agendamento da sua rotina de backup.


DECLARE
      @database_name VARCHAR(100) = '', -- Informe o nome da base
      @unidade VARCHAR(3) = '', --Informe o nome da unidade de disco, exemplo 'D:'
      @diretorio VARCHAR(100) = '', --Informe o diretorio com o nome da base criado pelo scrip powershell
      @bkp_set VARCHAR(100) = '' --informe o nome do backupset

EXEC sp_BackupUserDatabaseFull @database_name, @unidade, @diretorio, @bkp_set
EXEC sp_BackupUserDatabaseDiff @database_name, @unidade, @diretorio, @bkp_set
EXEC sp_BackupUserDatabaseTlog @database_name, @unidade, @diretorio, @bkp_set
  

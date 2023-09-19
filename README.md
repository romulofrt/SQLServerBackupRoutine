# SQLServerBackupRoutine
São um conjunto de scrips baseado em store procedures com rotinas de backup: Full, Differencial e Transaction Log para SQL Server. Junto com esse conjunto existe um script Power Shell para criar um estrutura de pasta composto com base de dados de sistema(master, model e msdb) e base de dados de usuário conforme exemplo:

## Unidade de disco
E:\
  |
  | Pastas com o nome das bases
    master
    model
    msdb
    AdventureWorks2022
                      |
                      |
                      | Pasta com o ano
                        2023
                            |
                            |
                            | Dias do mes
                              1-JANEIRO
                                       |
                                       |
                                       | Arquivos de backup
                                         AdventureWorks_20230101_0023_Full.bak
                                         AdventureWorks_20230107_2359_Diff.bak
                                         AdventureWorks_20230108_0000_TLog.bak
                                         AdventureWorks_20230108_0005_TLog.bak
                                         AdventureWorks_20230108_0010_TLog.bak
                                         AdventureWorks_20230108_0015_TLog.bak                                         
                              2-FEVEREIRO
                              3-MARCO
                              4-ABRIL
                              5-MAIO
                              6-JUNHO
                              7-JULHO
                              8-AGOSTO
                              9-SETEMBRO
                              10-OUTUBRO
                              11-NOVEMBRO
                              12-DEZEMBRO
                          
                              
Caminho final ate os arquivos: E:\AdventureWorks2022\2023\1-JANEIRO\                       
                        
  

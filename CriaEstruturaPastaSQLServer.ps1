# Muda a linguagem para portugues BR
Set-WinSystemLocale -SystemLocale 'pt-br'

# Setando valor nulo/vazio para variavel
$mes = ""
$mesnumero = ""
$dbname = ""

# Informe o caminho
$path = "E:\Dev\Bases\"

# Obter o ano atual
$ano = (Get-Date).Year

$pathano = $path + $ano

# Criar o diretório com o ano atual
if(!(Test-Path -Path $pathano)) {
New-Item -ItemType Directory -Path $pathano
}

# Acessar o diretório criado
Set-Location -Path $pathano # "C:\Exemplo\$ano"


#Conexao com o banco de dados
$Servidor = "localhost\SQL2022"
$database = "master"
$connstring = "Server=$Servidor;Database=$database;Trusted_Connection=True;"
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connstring
$connection.Open()

#Listando Base de dados
$query = "SELECT name from sys.databases where name <> 'tempdb' order by database_id;"
$command = New-Object System.Data.SqlClient.SqlCommand($query,$connection) ##$connection.CreateCommand()
$ds = New-Object System.Data.DataSet
$resultset = New-Object System.Data.SqlClient.SqlDataAdapter($command)
[void]$resultset.fill($ds)
$connection.Close()

$rows = $ds.Tables[0]


foreach($dbname in $rows.Rows){
          
    $path = $pathano + '\' + $dbname["name"] 

    if(!(Test-Path -Path $path)) {
         New-Item -ItemType Directory -Path $path ##$dbname["name"] 
    }                            
    ##$path = $path +'\'+$dbname["name"]
    
    Set-Location -Path $path
           
    # Loop pelos meses do ano
    1..12 | ForEach-Object {
    
        $mes = Get-Culture | Select-Object -ExpandProperty DateTimeFormat | Select-Object -ExpandProperty MonthNames | Select-Object -Index ($_ - 1)
        $mes = $mes.Replace("ç","c")
        $mesnumero = $_.ToString() +'-'+ $mes.ToUpper()

        if(!(Test-Path -Path $mesnumero)){
        New-Item -ItemType Directory -Path $mesnumero
        }

    } 
    
    $path = $pathano
}





install.packages("DBI")
install.packages("odbc")

library(DBI)
library(odbc)

# Conexão com o banco de dados
con = dbConnect(odbc::odbc(),
                Driver = "SQL Server",
                Server = "", # Nome do servidor
                Database = "AulaR",
                Trusted_Connection = "True")

# Listar tabelas no banco de dados
dbListTables(con)

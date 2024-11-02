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
dbListTables(conn = con)
# Importar dados do SQL para o R
dados_sql <- dbGetQuery(conn = con, statement = "SELECT * FROM Estudantes")

# Acessar dados

dados_sql[1, 2]

dados_sql[1, 2:4]

# Alterando a idade de Ana (1ª linha, 3ª coluna)
dados_sql[1, 3] <- 23

# Criação de uma nova coluna
dados_sql$Resultado <- ifelse(test = dados_sql$Nota > 7, 
                              yes = "Aprovado", 
                              no = "Reprovado")

estudantes_reprovados <- dados_sql[dados_sql$Resultado == "Reprovado",]
estudantes_aprovados <- dados_sql[dados_sql$Resultado == "Aprovado",]

# Fechar a conexão com o banco de dados
dbDisconnect(conn = con)


# Manipulação de CSV
install.packages("readr")
library(readr)

# Criar um dataframe de exemplo
df_exemplo <- data.frame(
  Aluno = c("Maria", "João", "Camila", "Pedro"),
  Matematica = c(7.5, 8.0, 6.5, 9.0),
  Portugues = c(8.0, 7.5, 7.0, 8.5),
  Historia = c(6.0, 7.5, 8.0, 7.0)
)

# Exportar arquivo
write.csv(x = df_exemplo, file = "dados/notas_alunos.csv", row.names = FALSE)
# Importar arquivo
dados_csv <- read.csv(file = "dados/notas_alunos.csv", sep=",", dec = ".")

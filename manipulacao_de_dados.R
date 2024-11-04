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
# Criando novas colunas
dados_csv$Media <- round(x = rowMeans(x = dados_csv[,2:4]), digits = 1)
dados_csv$Resultado <- ifelse(test = dados_csv$Media > 7,
                              yes = "Aprovado",
                              no = "Reprovado")

# Calcular a média geral das notas
media_geral <- round(x = mean(dados_csv$Media), digits = 1)

# Calcular a nota máxima e mínima
nota_maxima <- max(dados_csv$Media)
nota_minima <- min(dados_csv$Media)

cat("Média Geral das Notas:", media_geral, "\n")
cat("Maior Média:", nota_maxima, "\n")
cat("Menor Média:", nota_minima, "\n")

# Exportar os dados dos alunos aprovados para um novo arquivo CSV
write.csv(x = estudantes_aprovados, file = "dados/estudantes_aprovados.csv",
          row.names = FALSE)
write.csv(x = dados_csv, file = "dados/dados_csv_completo.csv",
          row.names = FALSE)


# Manipulação de Excel

install.packages("readxl")
install.packages("writexl")

library(readxl)
library(writexl)

# Importar arquivo
dados_excel <- read_excel(path = "dados/HR-Employee-Attrition.xlsx")

# Obter resumos estatísticos
summary(object = dados_excel)

# Média das idades
mean(x = dados_excel$Age)

# Mediana das idades
median(x = dados_excel$Age)

# Moda das idades
install.packages("modeest")
library("modeest")

mlv(x = dados_excel$Age, method = "mfv")

# Criar grupos de idade
dados_excel$Grupo_Idade <- cut(x = dados_excel$Age,
                              breaks = c(-Inf, 19, 29, Inf),
                              labels = c("Jovem", "Adulto Jovem", "Adulto"))
# Filtrar somente os jovens
dados_excel_jovens <- subset(x = dados_excel, Grupo_Idade == "Jovem")
View(x = dados_excel_jovens)

# Exportar arquivo
write_xlsx(x = dados_excel_jovens, path = "dados/dados_excel_jovens.xlsx")

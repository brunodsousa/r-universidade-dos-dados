# install.packages("DBI")
# install.packages("odbc")

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
# install.packages("readr")
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

# install.packages("readxl")
# install.packages("writexl")

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
# install.packages("modeest")
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



# Web Scraping

# install.packages("rvest")
# install.packages("dplyr")

library(rvest)
library(dplyr)

# URL da página da Wikipédia com a lista de países e capitais
url <- "https://pt.wikipedia.org/wiki/Lista_de_pa%C3%ADses_e_capitais_em_l%C3%ADnguas_locais"

# Ler o conteúdo da página
pagina <- read_html(x = url)

# Extrair a tabela de países e capitais
tabela_paises_capitais <- pagina %>% html_node("table.wikitable") %>% html_table()

colnames(tabela_paises_capitais)
# Renomeando colunas
tabela_paises_capitais <- rename(.data = tabela_paises_capitais,
                                 pais_exonimo = `País (exónimo)`,
                                 capital_exonimo = `Capital (exónimo)`,
                                 pais_endonimo = `País (endónimo)`,
                                 capital_endonimo = `Capital (endónimo)`,
                                 linguas_locais_oficiais = `Línguas locais oficiais (alfabeto/escrita)`)

# PNAD contínua

# install.packages("PNADcIBGE")
# install.packages("magrittr")

library(PNADcIBGE)
library(magrittr)

# install.packages("survey")
# install.packages("srvyr")

library(survey)
library(srvyr)

dados_pnadc <- get_pnadc(year = 2024, quarter = 1, vars = c("UF", "V2007",
                                                            "V2009", "V2010",
                                                            "V3001", "V4010",
                                                            "V4010", "VD2003", 
                                                            "VD3004", "VD4002",
                                                            "VD4004A", "VD4005",
                                                            "VD4008", "VD4010",
                                                            "VD4012", "VD4020",
                                                            "VD4023"))

pnad_042024 <- dados_pnadc$variables[,c(1:3, 8, 9, 10, 15:28)]

medicos <- subset(pnad_042024, V4010 == "2211" | V4010 == "2212")

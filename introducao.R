# EXERCÍCIOS PRÁTICOS

# VETORES

# 1. Crie um vetor com os números de 1 a 20 e calcule a soma de todos os 
# elementos
vetor_1 <- c(1:20)
sum(vetor_1)

# 2. Crie um vetor de 10 números aleatórios entre 1 e 100, e encontre o maior 
# valor no vetor
vetor_2 <- runif(n = 10, min = 1, max = 100)
max(vetor_2)

# 3. Crie dois vetores de 5 elementos cada, um contendo valores de vendas 
# do mês de janeiro e outro de fevereiro. Calcule a média das vendas totais 
# dos dois meses
vendas_janeiro <- c(100, 150, 200, 250, 300)
vendas_fevereiro <- c(110, 160, 210, 260, 310)
media_vendas <- mean(c(vendas_janeiro, vendas_fevereiro))

# MATRIZES

# 4. Crie uma matriz 3x3 com números de 1 a 9 e calcule a soma de todos os
# elementos
matriz_1 <- matrix(data = 1:9, nrow = 3, ncol = 3)
sum(matriz_1)

# 5. Crie uma matriz 4x4 com números aleatórios entre 1 e 100, e encontre o
# maior valor na matriz
matriz_2 <- matrix(data = floor(runif(n = 16, min = 1, max = 100)),
                   nrow = 4, ncol = 4)
max(matriz_2)

# 6. Crie duas matrizes 2x3 e calcule a soma, a multiplicação elementar e a
# transposta de uma delas
matriz_3 <- matrix(data = 1:6, nrow = 2, ncol = 3)
matriz_4 <- matrix(data = 7:12, nrow = 2, ncol = 3)
# soma
matriz_3 + matriz_4
# multiplicação
matriz_3 * matriz_4
# transposta
t(x = matriz_3)

# DATAFRAMES

# 7. Crie um dataframe com as colunas 'produto', 'preco' e 'quantidade', com
# pelo menos 3 registros, e calcule o valor total 
# de cada produto (preco * quantidade)
df_vendas <- data.frame(
  produto = c("A", "B", "C"),
  preco = c(10, 15, 20),
  quantidade = c(5, 3, 4)
)

df_vendas$total <- df_vendas$preco * df_vendas$quantidade

# 8. Crie um dataframe com as colunas 'nome', 'departamento' e 'salario'. 
# Filtre os registros onde o salário é maior que 5000 e ordene os resultados
# pelo nome
df_funcionarios <- data.frame(
  nome = c("Ana", "Bruno", "Carlos", "Diana", "Ariel"),
  departamento = c("Financeiro", "RH", "TI", "Marketing", "Vendas"),
  salario = c(1000, 6000, 1500, 2000, 5200)
)
df_funcionarios
# filtrando registros onde o salário é maior que 5000
df_filtrado <- subset(x = df_funcionarios, salario > 5000)
# ordenando resultados pelo nome
df_filtrado <- df_filtrado[order(df_filtrado$nome), ]

# 9. Crie um dataframe com dados de vendas (produto, vendedor, valor), agrupe
# por vendedor e calcule o total de vendas por vendedor.
df_vendas_2 <- data.frame(
  produto = c("Notebook", "Mouse", "Teclado", "Monitor", "Impressora"),
  vendedor = c("Ana", "Diana", "Carlos", "Diana", "Ana"),
  valor = c(2500, 50, 100, 800, 300)
)
# agrupando por vendedor e calculando o total de vendas
df_agrupado <- aggregate(x = valor ~ vendedor, data = df_vendas_2, sum)

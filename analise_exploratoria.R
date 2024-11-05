# install.packages("ggplot2")
library(ggplot2)

ggplot(data = mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  labs(x = "Peso (wt)", y = "Milhas por galão (mpg)",
       title = "Gráfico de Dispersão: Peso vs MPG")

# Dados fictícios de vendas mensais
meses <- 1:12
vendas <- c(100, 120, 110, 130, 150, 140, 160, 180, 170, 190, 200, 210)
dados_vendas <- data.frame(mes = meses, vendas = vendas)
dados_vendas

ggplot(data = dados_vendas, aes(x = mes, y = vendas)) +
  geom_line() +
  labs(x = "Mês", y = "Vendas",
       title = "Vendas Mensais ao Longo do Ano")

produtos <- c("Produto A", "Produto B", "Produto C")
vendas_produtos <- c(150, 200, 180)
dados_vendas_produtos <- data.frame(produto = produtos, 
                                    vendas = vendas_produtos)

ggplot(data = dados_vendas_produtos, aes(x = produtos, y = vendas, fill = produtos)) +
  geom_bar(stat = "identity") +
  labs(x = "Produto", y = "Vendas",
       title = "Total de Vendas por Produto")


# Dados fictícios de despesas mensais
categorias <- c("Alimentação", "Moradia", "Transporte", "Lazer", "Outros")
valores <- c(30, 25, 15, 10, 20)

dados_despesas <- data.frame(categoria = categorias, valor = valores)

ggplot(data = dados_despesas, aes(x = "", y = valor, fill = categoria)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  labs(title = "Distribuição de Despesas Mensais")


# Dados fictícios de pontuações de testes para dois grupos
grupo <- rep(x = c("Grupo A", "Grupo B"), each = 50)
pontuacao <- c(rnorm(n = 50, mean = 70, sd = 10),
               rnorm(n = 50, mean = 65, sd = 12))

dados_pontuacao_testes <- data.frame(grupo = grupo, pontuacao = pontuacao)

ggplot(data = dados_pontuacao_testes, aes(x = grupo, y = pontuacao, fill = grupo)) +
  geom_boxplot() +
  labs(x = "Grupo", y = "Pontuação",
       title = "Box Plot: Distribuição de Pontuações por Grupos") +
  theme_minimal()


ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species,
                        shape = Species)) +
  geom_point(size = 3) +
  labs(title = "Gráfico de Dispersão de Comprimento e Largura de Sépalas") +
  scale_color_manual(values = c("setosa" = "blue", "versicolor" = "green",
                                "virginica" = "red")) +
  theme_minimal()

# Exemplo: Modificando o tema do gráfico
ggplot(data = mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point() +
  labs(title = "Consumo de Combustível por Deslocamento do Motor") +
  theme_linedraw()

# Exemplo: Adicionando camadas de suavização e texto
ggplot(data = mtcars, aes(x = hp, y = mpg)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  geom_text(aes(label = rownames(mtcars)), nudge_y = 1) +
  labs(title = "Relação entre Potência e Consumo de Combustível")

# install.packages("tidyverse")
library(tidyverse)

dados_1 <- data.frame(
  sujeito = c("A", "B", "C"),
  tratamento_1 = c(5.2, 3.8, 4.1),
  tratamento_2 = c(6.0, 4.9, 5.7)
)

dados_organizados <- dados_1 %>% 
  pivot_longer(cols = starts_with("tratamento"),
               names_to = "tratamento",
               values_to = "valor")


dados_2 <- tibble(
  nome = c("Ana", "Bruno", "Carlos", "Daniela"),
  idade = c(23, 35, 28, 40),
  salario = c(5000, 7000, 6000, 8000)
)

dados_selecionados <- dados_2 %>% select(nome, salario)

dados_filtrados <- dados_2 %>% filter(idade > 30)

dados_mutados <- dados_2 %>% mutate(aumento_salarial = salario * 1.2)

dados_resumidos <- dados_2 %>% summarise(media_idade = mean(idade),
                                       total_salario = sum(salario))

dados_agrupados <- dados_2 %>% 
  group_by(nome) %>% 
  summarise(media_salario = mean(salario))


dados_3 <- tibble(
  modelo = c("A", "B", "C", "D", "A", "C", "C"),
  gasto = c(5000, 7000, 6000, 8000, 1000, 2000, 3000)
)

dados_agrupados_2 <- dados_3 %>%
  group_by(modelo) %>% 
  summarize(gasto = sum(gasto))


dados_3 <- tibble(
  nome = c("Ana", "Bruno", "Carlos", NA, "Daniela"),
  idade = c(23, 35, NA, 40, 28),
  salario = c(5000, 7000, 6000, 8000, NA)
)

dados_limpos <- dados_3 %>% 
  filter(!is.na(nome)) %>% 
  mutate(idade = ifelse(test = is.na(idade), 
                        yes = mean(idade, na.rm = TRUE), 
                        no = idade))
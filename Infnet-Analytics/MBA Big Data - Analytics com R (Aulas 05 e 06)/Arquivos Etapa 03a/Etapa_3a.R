# Disciplina: Big Data Analytics
# 
# Transformações

# -------------------------
# INSTALAÇÃO DE PACOTES
# -------------------------

#install.packages("dplyr", dependencies=TRUE)
#install.packages("reshape2", dependencies=TRUE)
#install.packages("tidyr", dependencies=TRUE)

# -------------------------
# APLICANDO A FUNÇÃO APPLY EM DIMENSÕES
# -------------------------

# Cria um dataframe aleatório.
set.seed(54321)
x <- matrix(rnorm(9), ncol = 3)

# Calcula a média das linhas, linha a linha.
xa1 <- apply(x, 1, mean)

# Calcula a média das colunas, coluna a coluna.
xa2 <- apply(x, 2, mean)

# -------------------------
# APLICANDO FUNÇÕES EM LISTAS (LAPPLY()) - RETORNA UMA LISTA.
# -------------------------

# Criando uma lista de matrizes. 
# A função 't()' gera a matriz transposta.
lista_de_matrizes <- list(x = x, tx = t(x))

# Calculando a matriz inversa de ambas as matrizes.
lapply(lista_de_matrizes, solve)

# Calculando o determinante de ambas as matrizes.
lapply(lista_de_matrizes, det)

# -------------------------
# APLICANDO FUNÇÕES EM LISTAS (SAPPLY()) - RETORNA UM VETOR.
# -------------------------

# Calculando o determinante de ambas as matrizes, agora com sapply().
sapply(lista_de_matrizes, det)

# -------------------------
# A FUNÇÃO REPLICATE().
# -------------------------

# Criando 1000 repetições de médias de 100 valores aleatórios.
set.seed(54321)
sims <- replicate(100000, mean(rnorm(100)))

# Visualizando o histograma.
hist(sims, col = "lightblue")

# -------------------------
# A FUNÇÃO MAPPLY() - APPLY() "MULTIVARIADO". RETORNA VETOR OU ARRAY
# Para quando você tem várias estruturas de dados diferentes
# (e.g. vetores, listas) e você quer aplicar a função para os 
# primeiros elementos de cada e então os segundos, etc.
# -------------------------

# Gerando objetos aleatórios.
x1 <- rnorm(100)
x2 <- rnorm(100)

# Aplicando a média na lista composta pelos dois objetos criados e 
# eliminando frações dos resultados a cada um dos dois.
mapply(mean, x = list(x1, x2), trim = list(0.1, 0.2))

# A função acima equivale a:
mean(x1, trim = 0.1)
mean(x2, trim = 0.2)

# -------------------------
# CARREGANDO DADOS
# -------------------------

dados <- read.csv2("Housing_Dataset.csv")

# -------------------------
# MANIPULANDO O DATASET
# -------------------------

# Vamos inserir uma nova coluna contendo o preço por m2.
dados$pm2 <- dados$preco/dados$m2

# Podemos executar a mesma operação com a função with()
dados$pm2_2 <- with(dados, preco/m2)

# Analisando a estrutura do dataframe.
str(dados)

# Uma nova forma de olhar um subconjunto do dataframe.
subconjunto <- subset(dados, bairro == "Bairro_D", select=c(bairro, preco))

# Passando um filtro com índices lógicos.
# Selecionando os imóveis que estavam à venda 
# com valor acima de de 1 milhão de reais.
selecao <- with(dados, tipo=="venda" & preco > 1000000)
sum(selecao) # quantos imóveis?

# Armazenando o filtro.
venda_maior1m <- dados[selecao,]

# Usando agora a função subset.
venda_maior1m_2 <- subset(dados, tipo == "venda" & preco > 1e6)

# Criando categorias discretas para a variável pm2 e salvando no dataframe.
# Ex.: até 50m2, de 50m2 a 100m2.
dados$m2_cat <- cut(dados$m2,
                    breaks= c(0, 50, 150, 200, 250, Inf),
                    labels=c("de 0 a 50 m2", "de 50 a 150 m2",
                             "de 150 a 200 m2","de 200 a 250 m2",
                             "mais de 250 m2") )
str(dados$m2_cat)

# Eliminando NAs. 
# Cuidado: estaremos eliminando todas as observações
#          que cotenham ao menos um NA em alguma coluna.

unicos <- na.omit(dados)

# -------------------------
# TÉCNICA
# DAC - DIVIDIR, APLICAR e COMBINAR ou
# SAC - SPLIT, APPLY and COMBINE
# -------------------------

# Suponha agora que queiramos tirar as médias dos preços. Como temos dados de 
# venda e aluguel, não faz sentido tirar uma média de todo o dataset.
# Vamos fazer a operação de modo artesanal.

# 1) Separar a base em duas bases diferentes: aluguel e venda.
aluguel <- unicos[unicos$tipo == "aluguel", ]
venda <- unicos[unicos$tipo == "venda", ]

# 2) Calcular a média para cada um dos objetos.
media_aluguel <- mean(aluguel$preco)
media_venda <- mean(venda$preco)

# 3) Combinar os resultados em um único objeto.
medias = c(aluguel = media_aluguel, venda = media_venda)
medias

# Agora vamos ver formas mais rápidas de fazer as mesmas operações acima, 
# aplicando técnica SAC.

# Usando tapply.
# TAPPLY() - aplicar a função à subsetores de um vetor e estes são 
# definidos por outro vetor.
tapply(X = unicos$preco, INDEX = unicos$tipo, FUN = mean)

# Usando aggregate.
aggregate(x = list(media = unicos$preco), by = list(tipo = unicos$tipo),
          FUN = mean)

# Usando o pacote dplyr (mais sobre este pacote adiante).
library(dplyr)
unicos %>% group_by(tipo) %>% summarise(media = mean(preco))

# Vamos mais uma vez aplicar a técnica SAC. 
# Usando uma nova função: split().

# 1) Dividir o data.frame segundo uma lista de fatores
alug_venda <- split(unicos$preco, unicos$tipo)

# Criamos uma lista alug_venda composta de dois vetores: 
# um para aluguel e outro para venda.
str(alug_venda)

# Agora vamos aplicar uma função já conhecida a cada um dos 
# elementos da lista.
medias_2 <- lapply(alug_venda, mean)
medias_2

# Queremos agora um vetor no lugar de uma lista. 
# Podemos usar a função unlist().
unlist(medias_2)

# Se quisermos fazer as duas operações anteriores combinadas 
# (olha a simplificação!), podemos usar sapply().
sapply(alug_venda, mean)

# Finalmente, vamos aplicar a função summary() para cada um dos elementos.
# Vamos analisar os resultados no PPTX.
lapply(alug_venda, summary)

# -------------------------
# IDENTIFICANDO E ELIMINANDO OUTLIERS
# -------------------------

# Eliminando outliers do dataframe.
# Filtrando a venda.
ok.venda <- with(unicos, tipo == "venda" &
                   pm2 > 3000 &
                   pm2 < 20000)

# Filtrando o aluguel.
ok.aluguel <- with(unicos, tipo == "aluguel" &
                     pm2 > 25 &
                     pm2 < 100)

# Juntando os dois resultados.
ok <- (ok.venda | ok.aluguel)

# Separando outliers e limpos.
outliers <- unicos[!ok,]
limpos <- unicos[ok,]

# -------------------------
# USANDO A FUNÇÃO TAPPLY()
# TAPPLY() - aplicar a função à subsetores de um vetor e estes são 
# definidos por outro vetor.
# -------------------------

# Calculando a mediana do metro quadrado para aluguel e para venda
tapply(unicos$pm2, unicos$tipo, median)

# Agora queremos mediana para aluguel e venda, separada por bairro:
tapply(unicos$pm2, list(unicos$bairro, unicos$tipo), median)

# Vejamos aluguel e venda, separados por tipo de imóvel e por bairro. 
# Criaremos um array de três dimensões:
tabelas <- tapply(unicos$pm2, list(unicos$imovel, unicos$tipo, unicos$bairro), median)
str(tabelas)

# A primeira dimensão é o tipo do imóvel; a segunda dimensão divide entre 
# venda e aluguel e a terceira dimensão separa por bairros. 
# Podemos filtrar em qualquer uma das três.

# Selecionando apenas o Bairro_K.
tabelas[ , ,"Bairro_K"]

# Selecionando apenas vendas por tipo de imóvel e bairro.
tabelas[ ,"venda", ]

# Agora perguntamos: qual a mediana do preço por metro quadrado 
# dos apartamentos, separados por tamanho? E por quartos?
aps <- unicos[unicos$imovel == "apartamento", ]
aps2 <- limpos[limpos$imovel == "apartamento", ]
with(aps2, tapply(pm2, m2_cat, median))
with(aps2, tapply(pm2, quartos, median))

# Distribuição de apartamentos por quartos e metragem.
with(aps2, tapply(quartos, list(m2_cat, quartos), length))

# -------------------------
# USANDO A FUNÇÃO AGGREGATE()
# -------------------------

# A função aggregate() é similar à tapply() porém, ao invés de 
# retornar um array, retorna um dataframe com uma coluna para 
# cada índice e apenas uma coluna de valor.
# A função aggregate() pode ser usada de duas formas.

# Calculando a mediana do preço por metro quadrado, separada por bairro,
# venda ou aluguel, e tipo de imóvel. 
# Atenção para a diferença do formato deste resultado para o formato da tapply().
pm2_bairro_tipo_imovel <- aggregate(formula = pm2 ~ bairro + tipo + imovel,
                                    data = unicos,
                                    FUN = median)
head(pm2_bairro_tipo_imovel)

# Vamos agora agregar mais de uma variável.
# Calculando a mediana do preço, metro quadrado e preço por metro quadrado
# dos valores de aluguel de apartamento. 
# Tudo isso pode ser passado diretamente à aggregate().
mediana_aluguel <- aggregate(cbind(preco, m2, pm2) ~ bairro,
                             data = limpos,
                             subset = (limpos$tipo == "aluguel" &
                                         limpos$imovel == "apartamento"),
                             FUN = median)
mediana_aluguel[order(mediana_aluguel$pm2, decreasing = TRUE), ]

# -------------------------
# O PACOTE DPLYR
# -------------------------

# Exemplo de uso do operador pipe.
library(dplyr)

# Exemplo 1.
Consulta1 <- 
  unicos %>% filter(imovel == "apartamento", tipo == "venda") %>%
  group_by(bairro) %>%
  summarise(Mediana_Preco = median(preco),
            Mediana_M2 = median(m2),
            Mediana_pm2 = median(pm2),
            Obs = length(pm2)) %>%
  filter(Obs > 30) %>%
  arrange(desc(Mediana_pm2))

# Exemplo 2.
consulta2 <-
  unicos %>% filter(imovel == "apartamento",
                     tipo == "aluguel",
                     bairro %in% c("Bairro_A", "Bairro_D"),
                     preco < 2200)

# Exemplo 3.
consulta3 <- 
  unicos %>% filter(imovel == "apartamento") %>%
                   select(bairro, preco, m2) %>% mutate(pm2 = preco/m2) %>%
                  arrange(desc(pm2))

# -------------------------
# A FUNÇÃO MERGE
# -------------------------

# Exemplo
dados1 <- aggregate(formula = pm2 ~ bairro,
                    data = limpos,
                    subset = (limpos$tipo == "aluguel"),
                    FUN = median)
dados2 <- aggregate(formula = pm2 ~ bairro,
                    data = limpos,
                    subset = (limpos$tipo == "venda"),
                    FUN = median)
names(dados1)[2] <- "aluguel"
names(dados2)[2] <- "venda"

merge_all_false <- merge(dados1, dados2, all = FALSE)
merge_all_true <- merge(dados1, dados2, all = TRUE)

str(merge_all_false)
str(merge_all_true)

# -------------------------
# EXEMPLOS DE MERGE NO DPLYR
# -------------------------

# Merge com all = FALSE
innerjoin <- inner_join(dados1, dados2)

# Merge com all = TRUE
fulljoin <- full_join(dados1, dados2)

# -------------------------
# O PACOTE RSHAPE2
# -------------------------

# Exemplo de melt().
# Dados no formato wide.
ap_wide <- tapply(aps$preco, list(aps$bairro, aps$m2_cat), median)
ap_wide[1:2, 1:3]
# Carrega o pacote e transforma em formato long
library(reshape2)
ap_long <- melt(ap_wide)
head(ap_long, 2)

# Exemplo de dcast().
long <- aggregate(pm2 ~ bairro + tipo + imovel + quartos,
                  data = limpos,
                  median)
head(long, 2)

wide <- dcast(data = long,
              formula = imovel + quartos ~ tipo + bairro,
              value.var = "pm2", sum)
wide[1:2, 1:4]

# Exemplo de acast().
long <- aggregate(pm2 ~ bairro + tipo + imovel + quartos,
                  data = limpos,
                  median)
head(long, 2)

cast2 <- acast(long,
               imovel~quartos~tipo~bairro,
               value.var="pm2", sum)
str(cast2, vec.len=2)

# -------------------------
# O PACOTE TIDYR
# -------------------------

# Exemplo de uso do tidyr.
library(tidyr)
library(dplyr)
tidy_wide <- long %>%
            spread(imovel, pm2)
head(tidy_wide)

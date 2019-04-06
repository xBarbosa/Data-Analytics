# Disciplina: Big Data Analytics com R

# -------------------------
# AGRUPAMENTOS
# DATASET: Terremotos mundiais dos últimos 7 dias com magnitude acima de 1.
# http://earthquake.usgs.gov/earthquakes/
# AUTOR: Fabrício J. Barth (adaptado)
# -------------------------

# Carregando os dados para um dataframe.
eData <- read.csv("1.0_week.csv")

# Verificando o que temos no dataframe.
names(eData)
dim(eData)
sapply(eData, class)

# Vamos utilizar os atributos magnitude e depth para identificar abalos sísmicos similares.

# Inspecionando a variável 'mag'.
summary(eData$mag)
hist(eData$mag)

# Inspecionando a variável 'depth'. 
summary(eData$depth)
hist(eData$depth)

# Podemos perceber que a amplitude destas variáveis é bem diferente. 
# Para que possamos utilizar um algoritmo de agrupamento sobre estas variáveis 
# é necessário normaliza-las, ou seja, transformar as variáveis das dimensões originais
# para dimensões entre [0,1].
# Considerando a distância Euclidiana, mais utilizada nas aplicações, um problema ocorre 
# quando um dos atributos assume valores em um intervalo relativamente grande,
# podendo sobrepujar os demais atributos.

eData$MagnitudeNorm <- eData$mag/max(eData$mag)
eData$DepthNorm <- eData$depth/max(eData$depth)

# Função para geração do gráfico do método do cotovelo.
elbow <- function(dataset) {
  wss <- numeric(15)
  for (i in 1:15) wss[i] <- sum(kmeans(dataset, centers = i, nstart = 100)$withinss)
  plot(1:15, wss, type = "b", main = "Elbow method", xlab = "Number of Clusters", 
       ylab = "Within groups sum of squares", pch = 8)
}

# Executando o método do cotovelo.
elbow(eData[, 23:24])

# Podemos considerar que o número de clusters mais adequado é 4.

# Executando o modelo.
set.seed(1234) # Para reprodução posterior.
clusterModel <- kmeans(eData[, 23:24], centers = 4, nstart = 100)

par(mfrow = c(1, 2)) # Parâmetro que permite plotar os gráficos lado a lado.

# Visualizando os agrupamentos com os valores normalizados.
plot(eData[, 23], eData[, 24], col = clusterModel$cluster, pch = 19, xlab = "Magnitude", 
     ylab = "Depth", main = "Valores normalizados")

# Visualizando os agrupamentos com os valores originais.
plot(eData[, 5], eData[, 4], col = clusterModel$cluster, pch = 19, xlab = "Magnitude", 
     ylab = "Depth", main = "Valores originais")

# Detalhes sobre os agrupamentos.
clusterModel

# Verificando o conteúdo dos agrupamentos.
c1 <- eData[clusterModel$cluster == 1, ]
c2 <- eData[clusterModel$cluster == 2, ]
c3 <- eData[clusterModel$cluster == 3, ]
c4 <- eData[clusterModel$cluster == 4, ]


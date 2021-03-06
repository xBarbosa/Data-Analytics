# Disciplina: Big Data Analytics com R

# -------------------------
# AGRUPAMENTOS
# DATASET: Terremotos mundiais dos �ltimos 7 dias com magnitude acima de 1.
# http://earthquake.usgs.gov/earthquakes/
# AUTOR: Fabr�cio J. Barth (adaptado)
# -------------------------

# Carregando os dados para um dataframe.
eData <- read.csv("1.0_week.csv")

# Verificando o que temos no dataframe.
names(eData)
dim(eData)
sapply(eData, class)

# Vamos utilizar os atributos magnitude e depth para identificar abalos s�smicos similares.

# Inspecionando a vari�vel 'mag'.
summary(eData$mag)
hist(eData$mag)

# Inspecionando a vari�vel 'depth'. 
summary(eData$depth)
hist(eData$depth)

# Podemos perceber que a amplitude destas vari�veis � bem diferente. 
# Para que possamos utilizar um algoritmo de agrupamento sobre estas vari�veis 
# � necess�rio normaliza-las, ou seja, transformar as vari�veis das dimens�es originais
# para dimens�es entre [0,1].
# Considerando a dist�ncia Euclidiana, mais utilizada nas aplica��es, um problema ocorre 
# quando um dos atributos assume valores em um intervalo relativamente grande,
# podendo sobrepujar os demais atributos.

eData$MagnitudeNorm <- eData$mag/max(eData$mag)
eData$DepthNorm <- eData$depth/max(eData$depth)

# Fun��o para gera��o do gr�fico do m�todo do cotovelo.
elbow <- function(dataset) {
  wss <- numeric(15)
  for (i in 1:15) wss[i] <- sum(kmeans(dataset, centers = i, nstart = 100)$withinss)
  plot(1:15, wss, type = "b", main = "Elbow method", xlab = "Number of Clusters", 
       ylab = "Within groups sum of squares", pch = 8)
}

# Executando o m�todo do cotovelo.
elbow(eData[, 23:24])

# Podemos considerar que o n�mero de clusters mais adequado � 4.

# Executando o modelo.
set.seed(1234) # Para reprodu��o posterior.
clusterModel <- kmeans(eData[, 23:24], centers = 4, nstart = 100)

par(mfrow = c(1, 2)) # Par�metro que permite plotar os gr�ficos lado a lado.

# Visualizando os agrupamentos com os valores normalizados.
plot(eData[, 23], eData[, 24], col = clusterModel$cluster, pch = 19, xlab = "Magnitude", 
     ylab = "Depth", main = "Valores normalizados")

# Visualizando os agrupamentos com os valores originais.
plot(eData[, 5], eData[, 4], col = clusterModel$cluster, pch = 19, xlab = "Magnitude", 
     ylab = "Depth", main = "Valores originais")

# Detalhes sobre os agrupamentos.
clusterModel

# Verificando o conte�do dos agrupamentos.
c1 <- eData[clusterModel$cluster == 1, ]
c2 <- eData[clusterModel$cluster == 2, ]
c3 <- eData[clusterModel$cluster == 3, ]
c4 <- eData[clusterModel$cluster == 4, ]


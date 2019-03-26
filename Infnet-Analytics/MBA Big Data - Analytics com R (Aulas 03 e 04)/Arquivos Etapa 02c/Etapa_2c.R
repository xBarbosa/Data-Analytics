# Disciplina: Big Data Analytics
# 
# Construir análises de dados simples utilizando R

# -------------------------
# INSTALAÇÃO DE PACOTES
# -------------------------

#install.packages("ggplot2", dependencies=TRUE)
#install.packages("scatterplot3d", dependencies=TRUE)
#install.packages("lattice", dependencies=TRUE)
#install.packages("party", dependencies=TRUE)
#install.packages("tm", dependencies=TRUE)
#install.packages("SnowballC", dependencies=TRUE)
#install.packages("wordcloud", dependencies=TRUE)
#install.packages("corrplot", dependencies=TRUE)
#install.packages("deldir", dependencies=TRUE)
#install.packages(c("sp", "maps", "maptools", "mapproj"), dependencies=TRUE)

# -------------------------
# BOXPLOTS
# -------------------------

# DATASET: IRIS

# Criando Boxplots simples para as 4 variáveis do dataset
boxplot(Sepal.Length~Species, data=iris, main="Sepal Length")
boxplot(Sepal.Width~Species, data=iris, main="Sepal Width")
boxplot(Petal.Length~Species, data=iris, main="Petal Length")
boxplot(Petal.Width~Species, data=iris, main="Petal Width")

# Criando Boxplots com formatos diferentes
boxplot(Sepal.Length~Species, data=iris, main="Sepal Length", notch=TRUE)

# -------------------------
# HISTOGRAMAS
# -------------------------

# DATASET: IRIS

# Criando histogramas das 4 variáveis
hist(iris$Sepal.Length)
hist(iris$Sepal.Width)
hist(iris$Petal.Length)
hist(iris$Petal.Width)

# Olhando os histogramas como densidades
plot(density(iris$Sepal.Length))
plot(density(iris$Sepal.Width))
plot(density(iris$Petal.Length))
plot(density(iris$Petal.Width))

# -------------------------
# MATRIZ DE SCATTERPLOTS
# -------------------------

# DATASET: IRIS

# Fazendo uma matriz de scatterplots,
# incluindo a correlação no painel superior
panel.pearson <- function(x, y, ...) {
horizontal <- (par("usr")[1] + par("usr")[2]) / 2; 
vertical <- (par("usr")[3] + par("usr")[4]) / 2; 
text(horizontal, vertical, format(abs(cor(x,y)), digits=2)) 
}
pairs(iris[1:4], main="Iris Dataset com Correlações", pch=21, bg=c("red","green3","blue")[unclass(iris$Species)], upper.panel=panel.pearson)

#------

# Fazendo mais uma matriz de scatterplots,
# incluindo a correlação no painel superior mas agora com proporcionalidade.
panel.corprop <- function(x, y, ...)
{
  par(usr = c(0, 1, 0, 1))
  txt <- as.character(format(cor(x, y), digits=2))
  text(0.5, 0.5, txt, cex = 6* abs(cor(x, y)))
}
pairs(iris[1:4], main="Iris Dataset com Correlações de Tamanho Proporcional", pch=21, bg=c("red","green3","blue")[unclass(iris$Species)], upper.panel=panel.corprop)

#------

# Mais uma matriz de scatterplots, 
# desta vez com legendas na diagonal e mantendo apenas a diagional superior.
pairs(iris[1:4], main="Iris Dataset com Etiquetas", pch=21, bg=c("red","green3","blue")[unclass(iris$Species)],lower.panel=NULL,labels=c("SL","SW","PL","PW"),font.labels=2,cex.labels=4.5) 

#------

# Outra matriz de scatterplots,
# desta vez com histogramas na diagonal.
panel.hist <- function(x, ...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(usr[1:2], 0, 1.5) )
  h <- hist(x, plot = FALSE)
  breaks <- h$breaks; nB <- length(breaks)
  y <- h$counts; y <- y/max(y)
  rect(breaks[-nB], 0, breaks[-1], y, col = "cyan", ...)
}
pairs(iris[1:4], main="Iris Dataset com Histogramas", pch=21, 
      bg=c("red","green3","blue")[unclass(iris$Species)], 
      diag.panel = panel.hist)

#------

# Matriz de scatterplots com diversas informações
# incluídas.
panel.lm <- function (x, y, col = par("col"), bg = NA, pch = par("pch"),
                     cex = 1, col.smooth = "black", ...)
{
  points(x, y, pch = pch, col = col, bg = bg, cex = cex)
  abline(stats::lm(y ~ x), col = col.smooth, ...)
}

pairs(iris[1:4], main="Iris Dataset com Diversas Informações", pch=21, 
      bg=c("red","green3","blue")[unclass(iris$Species)], 
      upper.panel=panel.corprop,
      diag.panel = panel.hist,
      lower.panel = panel.lm)

# -------------------------
# MATRIZ DE CORRELAÇÔES
# -------------------------

# DATASET: IRIS

library(corrplot)

# Gerando a matriz de correlações.
iriscor <- cor(iris[1:4])

# Arredondando para duas casas decimais.
round(iriscor, digits=2)

# Visualização da matriz de correlações 1.
corrplot(iriscor)

#------

# Visualização da matriz de correlações 2.
corrplot(iriscor, method="shade", shade.col=NA, tl.col="black", tl.srt=45)

#------

# Visualização da matriz de correlações 3.

# Criando uma paleta de cores mais clara para facilitar a visualização do texto.
col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))

# A opção 'AOE' diz respeito a 'Angular Order of Eigenvectors'. 
# Esta opção deixa itens correlacionados mais próximos.
# Além disso, retiramos a legenda, pois ela não é mais necessária.
corrplot(iriscor, method="shade", shade.col=NA, tl.col="black", tl.srt=45,
         col=col(200), addCoef.col="black", addcolorlabel="no", order="AOE")

# -------------------------
# CONTOUR E 3DPLOTS
# -------------------------

# DATASET: VOLCANO

# Usando a função Contour()
filled.contour(volcano, color=terrain.colors, 
               asp=1, plot.axes=contour(volcano, add=T))

# Usando a função persp()
persp(volcano, theta=25, phi=30, expand=0.5, col="lightblue")

# -------------------------
# SCATTERPLOT COM GGPLOT2
# -------------------------

# DATASET: IRIS

library(ggplot2)
qplot(Sepal.Length, Sepal.Width, data=iris, facets=Species ~.)

# -------------------------
# EXEMPLO DE WORDCLOUD
#
# CASO QUEIRAM EXECUTAR TODO O EXEMPLO, 
# EVITEM A MÁQUINA VIRTUAL DEVIDO AO 
# TAMANHO DO DATASET!
# -------------------------

# DATASET: QUESTÕES NA COMPETIÇÃO JEOPARDY
# (FONTE: USUÁRIO 'TREXMATT' DO REDDIT)

# Carregando as bibliotecas necessárias.
library(tm)
library(SnowballC)
library(wordcloud)

# Carregando o dataset.
#jeopQ <- read.csv('JEOPARDY_CSV.csv', stringsAsFactors = FALSE)

# Criando o 'corpus' de questões a partir do dataset.
#jeopCorpus <- Corpus(VectorSource(jeopQ$Question))

# Transformando o corpus em 'plain text'.
#jeopCorpus <- tm_map(jeopCorpus, PlainTextDocument)

# Removendo pontuação e 'stopwords'. 
#jeopCorpus <- tm_map(jeopCorpus, removePunctuation)
#jeopCorpus <- tm_map(jeopCorpus, removeWords, c(stopwords('english')))

# Fazendo 'stemming', ou seja, mantendo apenas o radical das palavras.
# Ex.1.: learning -> learn.
# Ex.2.: walked -> walk.
#jeopCorpus <- tm_map(jeopCorpus, stemDocument)

# Carregando o RData com o processamento anterior já executado.
load("Wordcloud.RData")

# Visualizando o wordcloud.
wordcloud(jeopCorpus, max.words = 100, random.order = FALSE, 
          colors = brewer.pal(8,"Spectral"))

# -------------------------
# EXEMPLO DE DIAGRAMA DE VORONOI
# -------------------------

# DATASET: U.S.A AIRPORT LOCATIONS
# FONTE: http://flowingdata.com/2016/04/12/voronoi-diagram-and-delaunay-triangulation-in-r/
# D3.js SIMILAR: http://bl.ocks.org/mbostock/4360892

# Carregando os dados
airports <- read.csv("airport-locations.tsv", sep="\t", stringsAsFactors=FALSE)

# Usando uma função para manter apenas os estados contíguos.
source("latlong2state.R")
airports$state <- latlong2state(airports[,c("longitude", "latitude")])
airports_contig <- na.omit(airports)

# Projeções
library(mapproj)
airports_projected <- mapproject(airports_contig$longitude, airports_contig$latitude, 
                                 "albers", param=c(39,45))
# Visualização como mapa de pontos.
par(mar=c(0,0,0,0))
plot(airports_projected, asp=1, type="n", bty="n", xlab="", ylab="", axes=FALSE)
points(airports_projected, pch=20, cex=0.1, col="red")

# Visualização como diagrama de Voronoi
library(deldir)
vtess <- deldir(airports_projected$x, airports_projected$y)
plot(vtess, wlines="tess", wpoints="none", number=FALSE, add=TRUE, lty=1)



############################
# ESTES EXEMPLOS SERÃO COBERTOS MAIS TARDE,
# QUANDO FALARMOS DOS ALGORITMOS PROPRIAMENTE
# DITOS.
############################

# -------------------------
# EXEMPLO DE ÁRVORES DE DECISÃO
# -------------------------

#DATASET: IRIS

# ConfIgurando a semente para reprodução posterior,
# criando dois conjuntos, um de treinamento e outro
# de teste (com 70% e 30% dos dados, respectivamente).
set.seed(54321)
ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.7, 0.3))
trainData <- iris[ind==1,]
testData <- iris[ind==2,]

# Executando o algoritmo de árvore de decisão com o pacote "party".
library(party)

# Especificando que "Species" é a variável dependente e as demais as independentes. 
myFormula <- Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width
iris_ctree <- ctree(myFormula, data=trainData)

# Matriz de confusão para verificar o poder de predição do modelo.
table(predict(iris_ctree), trainData$Species)

# Verificando as regras criadas pelo modelo e olhando a árvore.
print(iris_ctree)
plot(iris_ctree)

# Uma outra árvore, agora mais simples.
plot(iris_ctree, type="simple")

# Testando o modelo no conjunto de testes
testPred <- predict(iris_ctree, newdata = testData)
table(testPred, testData$Species)

# -------------------------
# EXEMPLO DE REGRESSÃO
# -------------------------

# DATASET: COLLEGE STUDENTS PERFORMANCE

# Carregando o dataset.
cp <- read.csv("college-perf.csv")

# PERF contém a performance dos alunos como 'High', 'Medium' e 'Low'.
# Aqui ordenamos também os dados, já que o R ordena alfabeticamente por padrão.
cp$Perf <- ordered(cp$Perf, levels = c("Low", "Medium", "High"))

# PRED contém a predição, executada por meio de um algoritmo de classificação.
cp$Pred <- ordered(cp$Pred, levels = c("Low", "Medium", "High"))

# Criando a matriz de confusão.
tab <- table(cp$Perf, cp$Pred, dnn = c("Actual", "Predicted"))
tab

# Apresentando e arredondando os valores como percentuais.
round(prop.table(tab, 1)*100, 1)

# Visualizando a matriz de confusão como 'mosaicplot'.
mosaicplot(tab, color = TRUE)

# -------------------------
# EXEMPLO DE REGRESSÃO 3D
# -------------------------

# DATASET: AUSTRALIAN CONSUMER PRICE INDEX (CPI)

# Criando o conjunto de dados.
year <- rep(2008:2010, each = 4)
quarter <- rep(1:4, 3)
cpi <- c(162.2, 164.6, 166.5, 166.0,
         166.2, 167.0, 168.6, 169.5,
         171.0, 172.1, 173.3, 174.0)

# Calculando a correlação entre CPI e as demais variáveis.
cor(year,cpi)
cor(quarter,cpi)

# Executando a regressão linear.
# Variável dependente: CPI
# Variáveis independentes: year, quarter
fit <- lm(cpi~ year + quarter)
fit

# Visualizando uma superfície de decisão tridimensional
# (neste caso, um plano de decisão)
library(scatterplot3d)
s3d <- scatterplot3d(year, quarter, cpi, highlight.3d=T,
                     type="h", lab=c(2,3))
s3d$plane3d(fit)

# -------------------------
# EXEMPLO DE CLUSTERING (AGRUPAMENTO)
# -------------------------

# DATASET: IRIS

# Eliminando a variável "Species".
iris2 <- iris[1:4]

# Executando o algoritmo de clusterização chamado
# 'Kmeans' para 3 clusters.
(kmeans.result <- kmeans(iris2, 3))

# COmparando o resultado do agrupamento com a distribuição
# original das espécies.
table(iris$Species, kmeans.result$cluster)

# Visualizando os grupos e seus centros.
plot(iris2[c("Sepal.Length", "Sepal.Width")], 
     col = kmeans.result$cluster)
points(kmeans.result$centers[,c("Sepal.Length",
       "Sepal.Width")], col=1:3, pch=8, cex=2)

# -------------------------
# EXEMPLO DE CLUSTERING HIERÁRQUICO (DENDROGRAMA)
# -------------------------

# DATASET: IRIS

idx <- sample(1:dim(iris)[1], 40)
irisSample <- iris[idx,]
irisSample$Species <- NULL
hc <- hclust(dist(irisSample), method="ave")
plot(hc, hang = -1, labels=iris$Species[idx])

# Separando os três grupos
rect.hclust(hc, k=3)
groups <- cutree(hc, k=3)

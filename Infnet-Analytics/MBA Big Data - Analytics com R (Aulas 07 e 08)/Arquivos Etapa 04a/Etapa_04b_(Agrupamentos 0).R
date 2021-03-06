# Disciplina: Big Data Analytics com R

# -------------------------
# EXEMPLO DE CLUSTERING (AGRUPAMENTO)
# -------------------------

# DATASET: IRIS

# Eliminando a vari�vel "Species".
iris2 <- iris[1:4]

# Executando o algoritmo de agrupamentos chamado
# 'K-means' para 3 grupos.
set.seed(1234) # Para reprodu��o posterior.
(kmeans.result <- kmeans(iris2, 3))

# Comparando o resultado do agrupamento com a distribui��o
# original das esp�cies.
table(iris$Species, kmeans.result$cluster)

# Visualizando os grupos e seus centros.
plot(iris2[c("Sepal.Length", "Sepal.Width")], 
     col = kmeans.result$cluster)
points(kmeans.result$centers[,c("Sepal.Length",
                                "Sepal.Width")], col=1:3, pch=8, cex=2)

# -------------------------
# EXEMPLO DE AGRUPAMENTO HIER�RQUICO (DENDROGRAMA)
# -------------------------

# DATASET: IRIS

idx <- sample(1:dim(iris)[1], 40)
irisSample <- iris[idx,]
irisSample$Species <- NULL
hc <- hclust(dist(irisSample), method="ave")
plot(hc, hang = -1, labels=iris$Species[idx])

# Separando os tr�s grupos
rect.hclust(hc, k=3)
groups <- cutree(hc, k=3)


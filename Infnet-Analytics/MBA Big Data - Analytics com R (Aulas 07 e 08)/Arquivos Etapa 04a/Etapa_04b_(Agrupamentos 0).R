# Disciplina: Big Data Analytics com R

# -------------------------
# EXEMPLO DE CLUSTERING (AGRUPAMENTO)
# -------------------------

# DATASET: IRIS

# Eliminando a variável "Species".
iris2 <- iris[1:4]

# Executando o algoritmo de agrupamentos chamado
# 'K-means' para 3 grupos.
set.seed(1234) # Para reprodução posterior.
(kmeans.result <- kmeans(iris2, 3))

# Comparando o resultado do agrupamento com a distribuição
# original das espécies.
table(iris$Species, kmeans.result$cluster)

# Visualizando os grupos e seus centros.
plot(iris2[c("Sepal.Length", "Sepal.Width")], 
     col = kmeans.result$cluster)
points(kmeans.result$centers[,c("Sepal.Length",
                                "Sepal.Width")], col=1:3, pch=8, cex=2)

# -------------------------
# EXEMPLO DE AGRUPAMENTO HIERÁRQUICO (DENDROGRAMA)
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


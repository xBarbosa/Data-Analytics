# Disciplina: Big Data Analytics com R

# -------------------------
# EXEMPLO DE AGRUPAMENTO HIER�RQUICO
# -------------------------

# DATASET: IRIS

# Executando o modelo.
# O crit�rio de proximidade padr�o � o "complete linkage method" (maior dist�ncia).
set.seed(1234) # Para reprodu��o posterior.
clusters <- hclust(dist(iris[, 3:4]))

# Visualizando.
plot(clusters)

# Cortando o dendrograma em 4 agrupamentos e verificando o resultado.
clusterCut4 <- cutree(clusters, 4)
table(clusterCut4, iris$Species)

# Agora cortando o dendrograma em 3 agrupamentos e verificando o resultado.
clusterCut3 <- cutree(clusters, 3)
table(clusterCut3, iris$Species)

# Finalmente, cortando o dendrograma em 2 agrupamentos e verificando o resultado.
clusterCut2 <- cutree(clusters, 2)
table(clusterCut2, iris$Species)

# Vamos alterar o crit�rio de proximidade para "mean linkage clustering"
# (m�dia das dist�ncias de todos os pares de observa��es).
clusters2 <- hclust(dist(iris[, 3:4]), method = 'average')
plot(clusters2)

# Cortando o dendrograma em 3 agrupamentos e verificando o resultado.
clusterCut3a <- cutree(clusters2, 3)
table(clusterCut3a, iris$Species)


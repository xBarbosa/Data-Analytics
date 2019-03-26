# Disciplina: Big Data Analytics com R

# -------------------------
# INSTALAÇÃO DE PACOTES
# -------------------------

install.packages("party", dependencies=TRUE)

# Instalando os pacotes
library(party) # Árvores de decisão.

# -------------------------
# EXEMPLO DE ÁRVORES DE DECISÃO
# -------------------------

#DATASET: IRIS

# Configurando a semente para reprodução posterior,
# criando dois conjuntos, um de treinamento e outro
# de teste (com 70% e 30% dos dados, respectivamente).
set.seed(54321)
ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.7, 0.3))
trainData <- iris[ind==1,]
testData <- iris[ind==2,]

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

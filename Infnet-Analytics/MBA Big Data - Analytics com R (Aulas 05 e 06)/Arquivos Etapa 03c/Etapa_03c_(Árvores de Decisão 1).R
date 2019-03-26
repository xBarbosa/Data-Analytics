# Disciplina: Big Data Analytics com R


# -------------------------
# INSTALAÇÃO DE PACOTES
# -------------------------

install.packages("rpart", dependencies=TRUE)
install.packages("rpart.plot", dependencies=TRUE)
install.packages("rattle", dependencies=TRUE)

# -------------------------
# ÁRVORES DE DECISÃO
# AUTOR: Jason Browniee (adaptado)
# -------------------------

# -------------------------
# ÁRVORES DE DECISÃO (CLASSIFICAÇÃO)
# DATASET: IRIS
# -------------------------

# Instalando os pacotes
library(rpart) # Árvores de decisão.
library(rpart.plot) # visualização das árvores de decisão.
library(rattle)	# Visualizações.

# Criando o modelo.
fit <- rpart(Species~., data=iris)

# Resumo.
summary(fit)

# Fazendo predições.
# O parâmetro "type='class'" é utilizado para árvores de classificação.
predictions <- predict(fit, iris[,1:4], type="class")

# Matriz de confusão das predições.
table(predictions, iris$Species)

# Imprimindo as regras.
print(fit)

# Gráfico com 'rpart.plot'.
prp(fit)

# Gráfico com 'rattle'.
fancyRpartPlot(fit)

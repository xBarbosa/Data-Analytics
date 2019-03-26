# Disciplina: Big Data Analytics com R

# -------------------------
# INSTALAÇÃO DE PACOTES
# -------------------------

#install.packages("rpart", dependencies=TRUE)
#install.packages("rpart.plot", dependencies=TRUE)
#install.packages("rattle", dependencies=TRUE)
#install.packages("RWeka", dependencies=TRUE)
#install.packages("ipred", dependencies=TRUE)
#install.packages("randomForest", dependencies=TRUE)
#install.packages("C50", dependencies=TRUE)

# -------------------------
# ÁRVORES DE DECISÃO (DIFERENTES ALGORITMOS)
# DATASET: IRIS
# AUTOR: Jason Browniee (adaptado)
# -------------------------

# Instalando os pacotes
library(rpart) # Árvores de decisão.
library(rpart.plot) # visualização das árvores de decisão.
library(rattle)	# Visualizações.
library(RWeka) # Algoritmos J48 e PART.
library(ipred) # Bagging.
library(randomForest) # Random Forest.
library(C50) # Algoritmo C5.0.

# -------------------------
# CLASSIFICATION AND REGRESSION TREES (CART)
# Faz a divisão da árvore com base nos valores que minimizam uma função de custo,
# como soma dos mínimos quadrados.
# -------------------------

# Criando o modelo.
fit1 <- rpart(Species~., data=iris)
# Resumo.
summary(fit1)
# Fazendo predições.
predictions1 <- predict(fit1, iris[,1:4], type="class")
# Matriz de confusão das predições.
table(predictions1, iris$Species)
# Gráfico com 'rattle'.
fancyRpartPlot(fit1)


# -------------------------
# ALGORITMO C4.5
# Cria a árvore de forma a maximixar o ganho de informação (information gain)
# (diferença de entropia). Chamado de J48 no Weka.
# Entropia: quantidade necessária de informação para identificar a classe de um caso
# Ganho de informação: é a redução esperada da entropia ao utilizarmos um atributo na árvore.
# Bom post explicativo (inglês): http://stackoverflow.com/questions/1859554/what-is-entropy-and-information-gain
# -------------------------

# Criando o modelo.
fit2 <- J48(Species~., data=iris)
# Resumo.
summary(fit2)
# Fazendo predições.
predictions2 <- predict(fit2, iris[,1:4])
# Matriz de confusão das predições.
table(predictions2, iris$Species)
# Gráfico da árvore.
plot(fit2)

# -------------------------
# PART
# Sistema de regras que cria árvores de decisão C4.5 podadas e extrai regras, retirando
# então os dados podados do conjunto de treinamento. O processo é repetido até que 
# todas as instâncias sejam cobertas pelas regras extraídas.
# 
# Sem visualização com gráfico!
# -------------------------

# Criando o modelo.
fit3 <- PART(Species~., data=iris)
# Resumo.
summary(fit3)
# Fazendo predições.
predictions3 <- predict(fit3, iris[,1:4])
# Matriz de confusão das predições.
table(predictions3, iris$Species)

plot(fit3)

# -------------------------
# BAGGING CART
# Bootstrapped Aggregation (Bagging) é um método ensemble, ou seja,
# cria múltiplos modelos do mesmo tipo a partir de amostras diferentes 
# do conjunto completo de dados. Os resultados de cada modelo separado 
# são combinados para oferecer um resultado melhor.
# 
# Sem visualização com gráfico!
# -------------------------

# Criando o modelo.
fit4 <- bagging(Species~., data=iris)
# Resumo.
summary(fit4)
# Fazendo predições.
predictions4 <- predict(fit4, iris[,1:4], type="class")
# Matriz de confusão das predições.
table(predictions4, iris$Species)

# -------------------------
# RANDOM FOREST
# Variação do Bagging de árvores de decisão que reduz os atributos de criação de uma 
# árvore de decisão a uma amostra aleatória, a cada ponto de decisão.
#
# Sem visualização com gráfico!
# -------------------------

# Criando o modelo.
fit5 <- randomForest(Species~., data=iris)
# Resumo.
summary(fit5)
# Fazendo predições.
predictions5 <- predict(fit5, iris[,1:4])
# Matriz de confusão das predições.
table(predictions5, iris$Species)


# -------------------------
# ALGORITMO C5.0
# Evolução do algoritmo C4.5 que teve seu código fonte liberado recentemente.
# -------------------------

# Criando o modelo.
# p parâmetro 'trials' indica o número de iterações desejado.
fit6 <- C5.0(Species~., data=iris, trials=10)
# Resumo.
print(fit6)
# Fazendo predições.
predictions6 <- predict(fit6, iris)
# Matriz de confusão das predições.
table(predictions6, iris$Species)
# Gráfico da árvore.
plot(fit6)


# Disciplina: Big Data Analytics com R

# -------------------------
# INSTALA��O DE PACOTES
# -------------------------

#install.packages("rpart", dependencies=TRUE)
#install.packages("rpart.plot", dependencies=TRUE)
#install.packages("rattle", dependencies=TRUE)
#install.packages("RWeka", dependencies=TRUE)
#install.packages("ipred", dependencies=TRUE)
#install.packages("randomForest", dependencies=TRUE)
#install.packages("C50", dependencies=TRUE)

# -------------------------
# �RVORES DE DECIS�O (DIFERENTES ALGORITMOS)
# DATASET: IRIS
# AUTOR: Jason Browniee (adaptado)
# -------------------------

# Instalando os pacotes
library(rpart) # �rvores de decis�o.
library(rpart.plot) # visualiza��o das �rvores de decis�o.
library(rattle)	# Visualiza��es.
library(RWeka) # Algoritmos J48 e PART.
library(ipred) # Bagging.
library(randomForest) # Random Forest.
library(C50) # Algoritmo C5.0.

# -------------------------
# CLASSIFICATION AND REGRESSION TREES (CART)
# Faz a divis�o da �rvore com base nos valores que minimizam uma fun��o de custo,
# como soma dos m�nimos quadrados.
# -------------------------

# Criando o modelo.
fit1 <- rpart(Species~., data=iris)
# Resumo.
summary(fit1)
# Fazendo predi��es.
predictions1 <- predict(fit1, iris[,1:4], type="class")
# Matriz de confus�o das predi��es.
table(predictions1, iris$Species)
# Gr�fico com 'rattle'.
fancyRpartPlot(fit1)


# -------------------------
# ALGORITMO C4.5
# Cria a �rvore de forma a maximixar o ganho de informa��o (information gain)
# (diferen�a de entropia). Chamado de J48 no Weka.
# Entropia: quantidade necess�ria de informa��o para identificar a classe de um caso
# Ganho de informa��o: � a redu��o esperada da entropia ao utilizarmos um atributo na �rvore.
# Bom post explicativo (ingl�s): http://stackoverflow.com/questions/1859554/what-is-entropy-and-information-gain
# -------------------------

# Criando o modelo.
fit2 <- J48(Species~., data=iris)
# Resumo.
summary(fit2)
# Fazendo predi��es.
predictions2 <- predict(fit2, iris[,1:4])
# Matriz de confus�o das predi��es.
table(predictions2, iris$Species)
# Gr�fico da �rvore.
plot(fit2)

# -------------------------
# PART
# Sistema de regras que cria �rvores de decis�o C4.5 podadas e extrai regras, retirando
# ent�o os dados podados do conjunto de treinamento. O processo � repetido at� que 
# todas as inst�ncias sejam cobertas pelas regras extra�das.
# 
# Sem visualiza��o com gr�fico!
# -------------------------

# Criando o modelo.
fit3 <- PART(Species~., data=iris)
# Resumo.
summary(fit3)
# Fazendo predi��es.
predictions3 <- predict(fit3, iris[,1:4])
# Matriz de confus�o das predi��es.
table(predictions3, iris$Species)

plot(fit3)

# -------------------------
# BAGGING CART
# Bootstrapped Aggregation (Bagging) � um m�todo ensemble, ou seja,
# cria m�ltiplos modelos do mesmo tipo a partir de amostras diferentes 
# do conjunto completo de dados. Os resultados de cada modelo separado 
# s�o combinados para oferecer um resultado melhor.
# 
# Sem visualiza��o com gr�fico!
# -------------------------

# Criando o modelo.
fit4 <- bagging(Species~., data=iris)
# Resumo.
summary(fit4)
# Fazendo predi��es.
predictions4 <- predict(fit4, iris[,1:4], type="class")
# Matriz de confus�o das predi��es.
table(predictions4, iris$Species)

# -------------------------
# RANDOM FOREST
# Varia��o do Bagging de �rvores de decis�o que reduz os atributos de cria��o de uma 
# �rvore de decis�o a uma amostra aleat�ria, a cada ponto de decis�o.
#
# Sem visualiza��o com gr�fico!
# -------------------------

# Criando o modelo.
fit5 <- randomForest(Species~., data=iris)
# Resumo.
summary(fit5)
# Fazendo predi��es.
predictions5 <- predict(fit5, iris[,1:4])
# Matriz de confus�o das predi��es.
table(predictions5, iris$Species)


# -------------------------
# ALGORITMO C5.0
# Evolu��o do algoritmo C4.5 que teve seu c�digo fonte liberado recentemente.
# -------------------------

# Criando o modelo.
# p par�metro 'trials' indica o n�mero de itera��es desejado.
fit6 <- C5.0(Species~., data=iris, trials=10)
# Resumo.
print(fit6)
# Fazendo predi��es.
predictions6 <- predict(fit6, iris)
# Matriz de confus�o das predi��es.
table(predictions6, iris$Species)
# Gr�fico da �rvore.
plot(fit6)


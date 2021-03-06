# Disciplina: Big Data Analytics com R


# -------------------------
# INSTALA��O DE PACOTES
# -------------------------

install.packages("rpart", dependencies=TRUE)
install.packages("rpart.plot", dependencies=TRUE)
install.packages("rattle", dependencies=TRUE)

# -------------------------
# �RVORES DE DECIS�O
# AUTOR: Jason Browniee (adaptado)
# -------------------------

# -------------------------
# �RVORES DE DECIS�O (CLASSIFICA��O)
# DATASET: IRIS
# -------------------------

# Instalando os pacotes
library(rpart) # �rvores de decis�o.
library(rpart.plot) # visualiza��o das �rvores de decis�o.
library(rattle)	# Visualiza��es.

# Criando o modelo.
fit <- rpart(Species~., data=iris)

# Resumo.
summary(fit)

# Fazendo predi��es.
# O par�metro "type='class'" � utilizado para �rvores de classifica��o.
predictions <- predict(fit, iris[,1:4], type="class")

# Matriz de confus�o das predi��es.
table(predictions, iris$Species)

# Imprimindo as regras.
print(fit)

# Gr�fico com 'rpart.plot'.
prp(fit)

# Gr�fico com 'rattle'.
fancyRpartPlot(fit)

# Disciplina: Big Data Analytics com R

# -------------------------
# INSTALA��O DE PACOTES
# -------------------------

#install.packages("readr", dependencies=TRUE)
#install.packages("dplyr", dependencies=TRUE)
#install.packages("party", dependencies=TRUE)
#install.packages("rpart", dependencies=TRUE)
#install.packages("rpart.plot", dependencies=TRUE)
#install.packages("rattle", dependencies=TRUE)

# -------------------------
# �RVORES DE DECIS�O - TITANIC
# AUTOR: Robert Ness
# -------------------------

# Instalando os pacotes
library(readr) # Leitura dos dados.
library(dplyr) # Para uso do 'pipe'.
library(party) # �rvores de decis�o.
library(rpart) # �rvores de decis�o.
library(rpart.plot) # Visualiza��o de �rvores de decis�o.
library(rattle) # Visualiza��o de �rvores de decis�o.


# -------------------------
# PROBLEMA
# Quais fatores poderiam levar � sobreviv�ncia?
# Cada linha representa um passageiro, as colunas s�o as 'features'. Principais:
#    survived: '0' caso tenha morrido, '1' se sobreviveu.
#    embarked: porto de embarque ((C)herbourg, (Q)ueenstown,(S)outhampton).
#    sex: g�nero.
#    sibsp: N�mero de irm�os/c�njuge a bordo.
#    parch: Number of pais/filhos a bordo.
#    fare: tarifa paga.
# -------------------------

# Carregando o conjunto de dados.
load("titanic.Rdata")

# Matriz de scatterplots.
pairs(titanic3, main="TItanic", pch=21, 
      bg=c("red","green3","blue")[unclass(titanic3$survived)],
      lower.panel=NULL, font.labels=2, cex.labels=2) 

# Rodando o modelo (rpart).
rtree_fit <- rpart(survived ~ ., titanic3) 

# Vizualizando o modelo.
# Simples.
rpart.plot(rtree_fit)
# Melhor.
fancyRpartPlot(rtree_fit, cex=0.6)

# Rodando o modelo (party).
tree_fit <- ctree(survived ~ ., data = titanic3)

# Vizualizando o modelo.
plot(tree_fit, type="simple")



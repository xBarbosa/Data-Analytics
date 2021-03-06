# Disciplina: Big Data Analytics com R


# -------------------------
# INSTALA��O DE PACOTES
# -------------------------

#install.packages("rpart", dependencies=TRUE)
#install.packages("rpart.plot", dependencies=TRUE)
#install.packages("rattle", dependencies=TRUE)

# -------------------------
# �RVORES DE DECIS�O
# AUTOR: Robert I. Kabacoff (adaptado)
# -------------------------

# -------------------------
# �RVORES DE DECIS�O (CLASSIFICA��O)
# DATASET: KYPHOSIS (PREDI��O DE UM TIPO DE DEFORMA��O (KYPHOSIS) 
#                    AP�S UMA INTERVEN��O CIR�RGICA)
# -------------------------

# Instalando os pacotes
library(rpart) # �rvores de decis�o.

# Criando o modelo.
fit <- rpart(Kyphosis ~ Age + Number + Start, method="class", data=kyphosis)

# Resumo.
summary(fit)

# Gr�fico com 'rattle'.
fancyRpartPlot(fit)

# -------------------------
# �RVORES DE DECIS�O (REGRESS�O)
# DATASET: CU.SUMMARY (PREDI��O DE CONSUMO DE CARRO (MILHAS POR GAL�O) 
#                      COM BASE EM PRE�O, PA�S, CONFIABILIDADE E TIPO DE CARRO. 
#                     O DATASET CONT�M INFORMA��ES DE CARROS RETIRADOS DA
#                      REVISTA 'CONSUMER REPORTS' DE ABRIL, 1990.
# -------------------------

# Criando o modelo.
fit2 <- rpart(Mileage~Price + Country + Reliability + Type, method="anova", data=cu.summary)

# Resumo.
summary(fit2)

# Gr�fico com 'rattle'.
fancyRpartPlot(fit2)

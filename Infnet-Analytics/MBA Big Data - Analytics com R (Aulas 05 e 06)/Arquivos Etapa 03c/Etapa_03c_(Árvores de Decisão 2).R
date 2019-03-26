# Disciplina: Big Data Analytics com R


# -------------------------
# INSTALAÇÃO DE PACOTES
# -------------------------

#install.packages("rpart", dependencies=TRUE)
#install.packages("rpart.plot", dependencies=TRUE)
#install.packages("rattle", dependencies=TRUE)

# -------------------------
# ÁRVORES DE DECISÃO
# AUTOR: Robert I. Kabacoff (adaptado)
# -------------------------

# -------------------------
# ÁRVORES DE DECISÃO (CLASSIFICAÇÃO)
# DATASET: KYPHOSIS (PREDIÇÃO DE UM TIPO DE DEFORMAÇÃO (KYPHOSIS) 
#                    APÓS UMA INTERVENÇÃO CIRÚRGICA)
# -------------------------

# Instalando os pacotes
library(rpart) # Árvores de decisão.

# Criando o modelo.
fit <- rpart(Kyphosis ~ Age + Number + Start, method="class", data=kyphosis)

# Resumo.
summary(fit)

# Gráfico com 'rattle'.
fancyRpartPlot(fit)

# -------------------------
# ÁRVORES DE DECISÃO (REGRESSÃO)
# DATASET: CU.SUMMARY (PREDIÇÃO DE CONSUMO DE CARRO (MILHAS POR GALÃO) 
#                      COM BASE EM PREÇO, PAÍS, CONFIABILIDADE E TIPO DE CARRO. 
#                     O DATASET CONTÉM INFORMAÇÕES DE CARROS RETIRADOS DA
#                      REVISTA 'CONSUMER REPORTS' DE ABRIL, 1990.
# -------------------------

# Criando o modelo.
fit2 <- rpart(Mileage~Price + Country + Reliability + Type, method="anova", data=cu.summary)

# Resumo.
summary(fit2)

# Gráfico com 'rattle'.
fancyRpartPlot(fit2)

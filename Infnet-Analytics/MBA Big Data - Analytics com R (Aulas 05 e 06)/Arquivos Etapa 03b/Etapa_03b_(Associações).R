# Disciplina: Big Data Analytics com R

# -------------------------
# INSTALA��O DE PACOTES
# -------------------------

#install.packages("arules", dependencies=TRUE)
#install.packages("arulesViz", dependencies=TRUE)

# -------------------------
# AN�LISE DE ASSOCIA��ES
# AUTOR: Flavio Barros (adaptado)
# -------------------------

# Instalando os pacotes
library(arules)
library(arulesViz)

# Carregando o conjunto de dados.
groceries <- read.transactions(file = 'groceries.txt', sep = ',', rm.duplicates = T)

# Verificando os dados.
summary(groceries)

# Observando algumas transa��es.
# Cada linha da matriz representa uma cesta de compras.
inspect(groceries[1:10]) 

# Calculando o suporte para cada item e imprimindo gr�fico de itens e seus suportes.
itemFrequency(groceries[,1:169])
itemFrequencyPlot(groceries[,1:20])

#Visualizando gr�fico de itens com suporte > 0,1.
itemFrequencyPlot(groceries, support = 0.06)

# Mais um gr�fico, agora alterando os eixos.
itens <- itemFrequency(groceries)
itens <- itens[order(itens, decreasing = T)] # Ordenando os itens.
dotchart(itens)

# Mesmos gr�ficos, menos itens.
# Pegando os 10 itens mais negociados.
dotchart(itens[1:20], cex = 0.8)
itemFrequencyPlot(groceries, topN=20, cex = 0.6) 

# Usando o algoritmos Apriori para descobrir as regras de associa��o.
regras <- apriori(groceries, parameter = list(support=0.001, confidence=0.5, minlen = 2))

# Verificando as regras.
summary(regras)

# Inspecionando as regras e ordenando-as por confian�a e lift.
inspect(regras[1:10])
inspect(sort(regras[1:50], by = 'confidence'))
inspect(sort(regras[1:50], by = 'lift'))

# Visualizando as regras como um diagrama de dispers�o.
plot(regras, method = 'scatterplot', shading=NA)

# Selecionando regras com confian�a > 0,8.
subregras <- regras[quality(regras)$confidence > 0.8]

# Visualizando as regras em um gr�fico suporte x confian�a + ordem.
plot(subregras, method = 'two-key plot', shading=NA)

# Fazendo o gr�fico de dispers�o suporte por lift.
plot(regras, measure=c("support", "lift"), shading="confidence")

# Visualizando regras agrupadas.
plot(subregras, method="grouped", control = list(k=40), cex = 0.7)

plot(subregras[1:20], method="graph", shading=NA)



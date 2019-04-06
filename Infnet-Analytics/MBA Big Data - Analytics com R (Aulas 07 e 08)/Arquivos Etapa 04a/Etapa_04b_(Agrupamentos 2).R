# Disciplina: Big Data Analytics com R

# -------------------------
# AGRUPAMENTOS
# DATASET: Chatterjee-Price Attitude Data
# https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/attitude.html
# AUTOR: Felipe Rego
# -------------------------


# Instalando o pacote para pegar o conjunto de dados
library(datasets)

# Verificando a estrutura de dados.
str(attitude)

# Resumo do conjunto de dados.
summary(attitude)

# Criando um subconjunto do conjunto de dados "attitude".
dat = attitude[,c(3,4)]

# Visualizando o subconjunto.
plot(dat, main = "% de respostas favoráveis nos tópicos
     Aprendizagem e Privilégios", pch =20, cex =2)

# Vamos tentar descobrir como os departamentos se assemelham em relação às opiniões de 
# seus funcionários em relação a estes dois tópicos usando o K-médias.

# Executando o K-médias com 2 agrupamentos.
# O parâmetro 'nstart' tenta múltiplas configurações iniciais para os centróides e 
# repassa a melhor. 
# Neste exemplo, tentaremos 100 inicializações de centróides.
# Esta é um parâmetro altamente recomendado para evitarmos problemas como os vistos em sala.

set.seed(1234) # Para reprodução posterior.
km1 = kmeans(dat, 2, nstart=100)

# Visualizando.
plot(dat, col =(km1$cluster +1) , main="Resultado do K-médias com 2 agrupamentos", pch=20, cex=2)

# Inicialmente precisamos descobrir o número ideal de agrupamentos.
# Para isso, vamos usar o "Método do cotovelo".
# Consiste em verificar o ponto (quantidade de agrupamentos) a partir do qual a alteração 
# de quantidade de agrupamentos já não seja significativa. 
# https://en.wikipedia.org/wiki/Determining_the_number_of_clusters_in_a_data_set

mydata <- dat
wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))
for (i in 2:15) wss[i] <- sum(kmeans(mydata, centers=i)$withinss)
plot(1:15, wss, type="b", xlab="Número de agrupamentos",
     ylab="Soma dos quadrados dentro dos grupos",
     main="Método do cotovelo",
     pch=20, cex=2)

# Podemos ver que o ponto onde não temos mais grande alteração é  
# a partir de 6 agrupamentos. Não é lá muito objetivo, mas na falta 
# de coisa melhor, vamos focar com este.

# Executando o K-médias com 6 agrupamentos.
km2 = kmeans(dat, 6)

# Visualizando.
plot(dat, col =(km2$cluster +1) , main="Resultado do K-médias para 6 agrupamentos", pch=20, cex=2)


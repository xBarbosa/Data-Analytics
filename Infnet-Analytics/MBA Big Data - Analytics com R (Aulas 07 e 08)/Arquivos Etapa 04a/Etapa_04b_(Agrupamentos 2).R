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
plot(dat, main = "% de respostas favor�veis nos t�picos
     Aprendizagem e Privil�gios", pch =20, cex =2)

# Vamos tentar descobrir como os departamentos se assemelham em rela��o �s opini�es de 
# seus funcion�rios em rela��o a estes dois t�picos usando o K-m�dias.

# Executando o K-m�dias com 2 agrupamentos.
# O par�metro 'nstart' tenta m�ltiplas configura��es iniciais para os centr�ides e 
# repassa a melhor. 
# Neste exemplo, tentaremos 100 inicializa��es de centr�ides.
# Esta � um par�metro altamente recomendado para evitarmos problemas como os vistos em sala.

set.seed(1234) # Para reprodu��o posterior.
km1 = kmeans(dat, 2, nstart=100)

# Visualizando.
plot(dat, col =(km1$cluster +1) , main="Resultado do K-m�dias com 2 agrupamentos", pch=20, cex=2)

# Inicialmente precisamos descobrir o n�mero ideal de agrupamentos.
# Para isso, vamos usar o "M�todo do cotovelo".
# Consiste em verificar o ponto (quantidade de agrupamentos) a partir do qual a altera��o 
# de quantidade de agrupamentos j� n�o seja significativa. 
# https://en.wikipedia.org/wiki/Determining_the_number_of_clusters_in_a_data_set

mydata <- dat
wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))
for (i in 2:15) wss[i] <- sum(kmeans(mydata, centers=i)$withinss)
plot(1:15, wss, type="b", xlab="N�mero de agrupamentos",
     ylab="Soma dos quadrados dentro dos grupos",
     main="M�todo do cotovelo",
     pch=20, cex=2)

# Podemos ver que o ponto onde n�o temos mais grande altera��o �  
# a partir de 6 agrupamentos. N�o � l� muito objetivo, mas na falta 
# de coisa melhor, vamos focar com este.

# Executando o K-m�dias com 6 agrupamentos.
km2 = kmeans(dat, 6)

# Visualizando.
plot(dat, col =(km2$cluster +1) , main="Resultado do K-m�dias para 6 agrupamentos", pch=20, cex=2)


#install.packages(c("ggplot2", "ggthemes", "reshape2"))

#EXEMPLO

# Carregando os pacotes necessários
library(ggplot2)
library(reshape2)

# Configurando a coluna de datas corretamente
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y"))

# Carregando os dados
dados <- read.csv("Dados/PETR4_VALE5.csv", colClasses=c('myDate','numeric','numeric'),  header = TRUE, sep= ";", dec = ",")

# Ajustando os dados para gráfico
meltdados <- melt(dados,id="Date")

# Criando o gráfico
ggplot(meltdados,aes(x=Date,y=value,colour=variable,group=variable)) + 
  geom_line() +
  theme(axis.text.x = element_text(angle=90, hjust=1))
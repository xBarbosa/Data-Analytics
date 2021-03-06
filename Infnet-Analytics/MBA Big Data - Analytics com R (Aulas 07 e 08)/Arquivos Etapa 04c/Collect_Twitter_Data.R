# Bloco: Business Intelligence e Big Data Analytics: Valor
# Disciplina: Big Data Analytics com R
# 
# -------------------------
# COLETA, TRATAMENTO E PROCESSAMENTO DE POSTAGENS NO TWITTER
# USO DA API DO TWITTER
# AUTOR: Yanchang Zhao
# -------------------------

# Instalando os pacotes
#install.packages("twitteR", dependencies=TRUE)
#install.packages("maps", dependencies=TRUE)
#install.packages("geosphere", dependencies=TRUE)
#install.packages("RColorBrewer", dependencies=TRUE)

# Carregando os pacotes
library(twitteR) # Patote de interface com a API do Twitter.
library(maps) # Pacote para manipula��o de mapas.
library(geosphere) # Pacote manipula��o de mapas.
library(RColorBrewer) # Pacote para manipula��o de cores.

#Carregando a rotina que far� a visualiza��o final.
source("twitterMap.R")

# Coletando dados do Twitter
# Mais informa��es em http://geoffjentry.hexdump.org/twitteR.pdf
consumer_key <- "ZHmBiyB7laXhAPypYjwRXJ5c8"
consumer_secret <- "eTzefsPHkDSQd3tnqig8JYkU3m7JVsTGwpMqpfWEJWo0OfECQw"
access_token <- "2157851631-Q7v2KWPCyyKaUD1JcaK8CXoctkmz9veX5ZxSjMa"
access_secret <- "pwngI4v79F8q8biE2f9UGsNZmWT1DalPd58HR6db5RRRX"
twitter_username <- "cmcf71"

# Dados da aplica��o criada no Twitter e do usu�rio.
#consumer_key <- ""
#consumer_secret <- ""
#access_token <- ""
#access_secret <- ""
#twitter_username <- ""

# Autentica��o
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

# S� � poss�vel pegar 3200 tweets por vez.
# Cuidado com as restri��es de uso!
tweets <- userTimeline(twitter_username, n = 300)

user <- getUser(twitter_username) # Captura dados do usu�rio.
user$toDataFrame() 
friends <- user$getFriends() # Quem o usu�rio segue?
followers <- user$getFollowers() # Quem segue o usu�rio?
followers2 <- followers[[1]]$getFollowers() # Quem segue os seguidores do usu�rio?

# gerando PDF com geolocaliza��o dos seguidores.
twitterMap(twitter_username,plotType="followers")

# gerando PDF com geolocaliza��o dos seguidos.
twitterMap(twitter_username,plotType="following")




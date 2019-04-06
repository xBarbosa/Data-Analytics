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
library(maps) # Pacote para manipulação de mapas.
library(geosphere) # Pacote manipulação de mapas.
library(RColorBrewer) # Pacote para manipulação de cores.

#Carregando a rotina que fará a visualização final.
source("twitterMap.R")

# Coletando dados do Twitter
# Mais informações em http://geoffjentry.hexdump.org/twitteR.pdf
consumer_key <- "ZHmBiyB7laXhAPypYjwRXJ5c8"
consumer_secret <- "eTzefsPHkDSQd3tnqig8JYkU3m7JVsTGwpMqpfWEJWo0OfECQw"
access_token <- "2157851631-Q7v2KWPCyyKaUD1JcaK8CXoctkmz9veX5ZxSjMa"
access_secret <- "pwngI4v79F8q8biE2f9UGsNZmWT1DalPd58HR6db5RRRX"
twitter_username <- "cmcf71"

# Dados da aplicação criada no Twitter e do usuário.
#consumer_key <- ""
#consumer_secret <- ""
#access_token <- ""
#access_secret <- ""
#twitter_username <- ""

# Autenticação
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

# Só é possível pegar 3200 tweets por vez.
# Cuidado com as restrições de uso!
tweets <- userTimeline(twitter_username, n = 300)

user <- getUser(twitter_username) # Captura dados do usuário.
user$toDataFrame() 
friends <- user$getFriends() # Quem o usuário segue?
followers <- user$getFollowers() # Quem segue o usuário?
followers2 <- followers[[1]]$getFollowers() # Quem segue os seguidores do usuário?

# gerando PDF com geolocalização dos seguidores.
twitterMap(twitter_username,plotType="followers")

# gerando PDF com geolocalização dos seguidos.
twitterMap(twitter_username,plotType="following")




# Disciplina: Big Data Analytics com R
# 
# -------------------------
# AUTOR: Saurav Kaushik, 2017
#
# OUTRAS REFERÊNCIAS
# Curso-R Web Scraping <http://material.curso-r.com/scrape/>
# An introduction to web scraping using R <https://medium.freecodecamp.org/an-introduction-to-web-scraping-using-r-40284110c848>
# DataCamp Web Scraping in R: rvest Tutorial <https://www.datacamp.com/community/tutorials/r-web-scraping-rvest>
# -------------------------

# Instalando pacotes.
#install.packages('rvest')
#install.packages('ggplot2')

# Carregando pacotes.
library('rvest')
library('ggplot2')

# Definindo a URL do website que faremos o scraping.
url <- 'http://www.imdb.com/search/title?count=25&release_date=2018,2018&title_type=feature'
# Lendo o código HTML.
webpage <- read_html(url)

# Capturando os rankings via CSS selectors.
rank_data_html <- html_nodes(webpage,'.text-primary')
#Convertendo rankings para texto.
rank_data <- html_text(rank_data_html)
# Inspecionando.
head(rank_data)
# Convertendo para numérico.
rank_data<-as.numeric(rank_data)
# Inspecionando novamente
head(rank_data)


# Capturando os títulos via CSS selectors.
title_data_html <- html_nodes(webpage,'.lister-item-header a')
# Convertendo para texto.
title_data <- html_text(title_data_html)
# Inspecionando.
head(title_data)


# Capturando as descrições via CSS selectors.
description_data_html <- html_nodes(webpage,'.ratings-bar+ .text-muted')
# Convertendo para texto.
description_data <- html_text(description_data_html)
# Inspecionando.
head(description_data)
# Eliminando os '\n'.
description_data<-gsub("\n","",description_data)
# Inspecionando novamente.
head(description_data)


# Capturando os tempos de projeção via CSS selectors.
runtime_data_html <- html_nodes(webpage,'.text-muted .runtime')
# Convertendo para texto.
runtime_data <- html_text(runtime_data_html)
# Inspecionando.
head(runtime_data)
#Removendo 'mins' e convertendo para numérico.
runtime_data<-gsub(" min","",runtime_data)
runtime_data<-as.numeric(runtime_data)
# Inspecionando novamente.
head(runtime_data)


# Capturando os gêneros via CSS selectors.
genre_data_html <- html_nodes(webpage,'.genre')
# Convertendo para texto.
genre_data <- html_text(genre_data_html)
# Inspecionando.
head(genre_data)
# Removendo os '\n'.
genre_data<-gsub("\n","",genre_data)
# Removendo espaços em excesso.
genre_data<-gsub(" ","",genre_data)
# Mantendo apenas a primeira entrada de gênero para cada filme.
genre_data<-gsub(",.*","",genre_data)
# Convertendo para Factor.
genre_data<-as.factor(genre_data)
# Inspecionando novamente.
head(genre_data)


# Capturando as notas via CSS selectors.
rating_data_html <- html_nodes(webpage,'.ratings-imdb-rating strong')
# Convertendo para texto.
rating_data <- html_text(rating_data_html)
# Inspecionando.
head(rating_data)
# Convertendo para numérico.
rating_data<-as.numeric(rating_data)
# Inspecionando novamente.
head(rating_data)


# Capturando os votos via CSS selectors.
votes_data_html <- html_nodes(webpage,'.sort-num_votes-visible span:nth-child(2)')
# Convertendo para texto.
votes_data <- html_text(votes_data_html)
# Inspecionando.
head(votes_data)
# Removendo as vírgulas.
votes_data<-gsub(",","",votes_data)
# Convertendo para numérico.
votes_data<-as.numeric(votes_data)
# Inspecionando novamente.
head(votes_data)


# Capturando a informação dos diretores via CSS selectors.
directors_data_html <- html_nodes(webpage,'.text-muted+ p a:nth-child(1)')
# Convertendo para texto.
directors_data <- html_text(directors_data_html)
# Inspecionando.
head(directors_data)
# Convertendo em Factors.
directors_data<-as.factor(directors_data)


# Capturando as informações de atores via CSS selectors.
actors_data_html <- html_nodes(webpage,'.lister-item-content .ghost+ a')
# Convertendo para texto.
actors_data <- html_text(actors_data_html)
# Inspecionando.
head(actors_data)
# Convertendo para Factors.
actors_data<-as.factor(actors_data)


# Capturando a receita bruta via CSS selectors.
gross_data_html <- html_nodes(webpage,'.ghost~ .text-muted+ span')

# Convertendo para texto.
gross_data <- html_text(gross_data_html)

# Inspecionando.
head(gross_data)

# Removendo os símbolos '$' e 'M'.
gross_data<-gsub("M","",gross_data)
gross_data<-substring(gross_data,2,6)
# Verificando o tamanho.
length(gross_data)

# Com frequência este tipo de dado não está no IMDB.
# Vamo fazer uma inspeção visual na página para verificar.
# Incluindo NAs para as entradas sem dados deste tipo.
for (i in c(3,9)){
  a<-gross_data[1:(i-1)]
  b<-gross_data[i:length(gross_data)]
  gross_data<-append(a,list("NA"))
  gross_data<-append(gross_data,b)
}
# Convertendo para numérico.
gross_data<-as.numeric(gross_data)
# Inspecionando.
head(gross_data)
# Verificando novamente o tamanho.
length(gross_data)


# Criando um DF com todas as informações coletadas.
movies_df<-data.frame(Rank = rank_data, 
                      Title = title_data,
                      Description = description_data, 
                      Runtime = runtime_data,
                      Genre = genre_data, 
                      Rating = rating_data,
                      Votes = votes_data, 
                      Gross_Earning_in_Mil = gross_data,
                      Director = directors_data, 
                      Actor = actors_data)

# Verificando a estrutura do DF.
str(movies_df)

# VAMOS TENTAR RESPONDER ALGUMAS PERGUNTAS A PARTIR DOS DADOS E COM 
# USO DE VISUALIZAÇÕES.

# Pergunta 1
# Qual gênero apresenta filmes de maior duração?
qplot(data = movies_df,Runtime,fill = Genre,bins = 20)

# Pergunta 2
# Qual gênero teve maior nota para durações acima de 130 minutos??
ggplot(movies_df,aes(x=Runtime,y=Rating))+
       geom_point(aes(size=Votes,col=Genre))

# Pergunta 3
# Qual gênero teve maior receita bruta, considerando durações entre 100 e 120 mins.
ggplot(movies_df,aes(x=Runtime,y=Gross_Earning_in_Mil))+
       geom_point(aes(size=Rating,col=Genre))

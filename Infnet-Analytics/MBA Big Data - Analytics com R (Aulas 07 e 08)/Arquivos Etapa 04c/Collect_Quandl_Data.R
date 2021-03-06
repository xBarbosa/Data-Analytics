# Bloco: Business Intelligence e Big Data Analytics: Valor
# Disciplina: Big Data Analytics com R
# 
# -------------------------
# COLETA, TRATAMENTO E PROCESSAMENTO DE DADOS DO QUANDL
# USO DA API DO QUANDL
# SITE: https://www.quandl.com/tools/r
# -------------------------

# -------------------------
# INSTALA��O DE PACOTES
# -------------------------
#install.packages("Quandl")

# -------------------------
# CARREGANDO PACOTES
# -------------------------
library(Quandl)

# -------------------------
# CONFIGURANDO A API KEY
# -------------------------

# The Quandl R package is free. 
# If you would like to make more than 50 calls a day, however, you will need to 
# create a free Quandl account and set your API key:
Quandl.api_key("3Ec5a5xzML7gVrq_A9LR")

#Quandl.api_key("YOUR_API_KEY_HERE")

# -------------------------
# FAZENDO CHAMADAS B�SICAS
# -------------------------

# Coletando o �ndice Bovespa di�rio e carregando em um data frame.
# Voc� precisar� saber o "Quandl code" de cada um dos datasets que queira baixar. 
mydata = Quandl("BCB/7")

# -------------------------
# MANIPULANDO OS DADOS DURANTE A COLETA
# -------------------------

# Configurando datas de in�cio e fim.
mydata = Quandl("BCB/7", start_date="2003-12-31", end_date="2008-12-31")

# COletando dados de diferentes datasets.
# Vamos coletar dados de fechamento de mercado para Microsoft e Apple, nos E.U.A.
mydata = Quandl(c("WIKI/MSFT", "WIKI/AAPL"))

# Alterando a frequ�ncia de coleta de dados.
# 'collapse' pega a �ltima observa��o do per�odo.
mydata = Quandl("BCB/7", collapse="annual")

# Fazendo c�lculos b�sicos com os dados.
# Aqui calculamos o retorno di�rio linear.
mydata = Quandl("BCB/7", transform="rdiff")

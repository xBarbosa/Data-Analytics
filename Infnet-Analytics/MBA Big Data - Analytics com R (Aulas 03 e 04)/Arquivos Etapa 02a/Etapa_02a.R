# Disciplina: Big Data Analytics com R
# 
# Construir análises de dados simples utilizando R

####################################
# Manipulando arquivos e pastas
####################################

# Qual é a pasta de trabalho atual? 
getwd()

# Podemos alterar a pasta de trabalho a qualquer momento.
setwd("D:/Dados")
getwd()

# Perceba que o separador é diferente do habitual do Windows, pois a 
# barra (“\”) é um comando especial da linguagem.
# Caso queira manter o padrão do Windows, basta usar duas barras.
setwd("D:\\Dados")

# A função file.path() cria o caminho no formato apropriado e pode 
# ser usada para criação de caminhos de forma dinâmica durante a execução de um script.
caminho = file.path("C:","pasta_1", "pasta_2","meu_arquivo.txt")

# Lista arquivos e pastas.
list.files()
# Listar pastas e subpastas.
list.dirs()

# Verificando a existência de um arquivo.
file.exists("teste.txt")
file.exists("teste1.txt")

# Removendo arquivo
file.remove("teste.txt")
file.exists("teste.txt")

# Criando e removendo pastas
dir.create("Nova Pasta")
list.dirs()
file.remove("Nova Pasta")
list.dirs()

# Podemos também usar comandos do SO diretamente.
shell("md teste")

####################################
# Formatos de arquivos próprios do R
# RData ou rda: salva um ou vários objetos da área de trabalho. 
#               Espera pelo mesmo nome ao ser carregado.
# rds: salva apenas um objeto. Pode ser carregado com nome diferente.
####################################

# Manipulando RData e rda
mtcars <- mtcars

# Salvando como RData
save(mtcars, file="mtcars.RData")
rm(mtcars)
ls()

# Carregando o arquivo
load(file = "mtcars.RData")
ls()

# Salvando como rds
saveRDS(mtcars, file="mtcars.rds")
rm(mtcars)

# carregando o objeto com nome diferente
dados <- readRDS("mtcars.rds")
ls()

####################################
# Dados e o R
# Para analisarmos dados precisamos carregar os mesmos para processá-los na linguagem R.
# Os dados podem estar em diversos formatos de texto, exemplos comuns:
#               CSV (Comma Separated Values);
#               JSON (JavaScript Object Notation);
#               XML (Extensible Markup Language). 
####################################

####################################
# Lendo dados em CSV
####################################

# Lendo um CSV
auto <- read.csv("auto-mpg.csv", header=TRUE, sep=",")

# Verificando o resultado:
names(auto)

# Vamos tentar importar o arquivo "auto-mpg-noheader.csv". 
# Veremos que o R definirá um cabeçalho após a importação.
auto <- read.csv("auto-mpg-noheader.csv", header=FALSE)
head(auto,20)

# Agora importando de outra forma.
# Neste caso o R usa os dados da primeira observação como cabeçalho.
auto <- read.csv("auto-mpg-noheader.csv")
head(auto)

# Usando o parâmetro col.names para especificar nomes para as colunas.
auto <- read.csv("auto-mpg-noheader.csv", header=FALSE, 
                 col.names = c("YY", "", "cyl", "dis","hp", "wt", "acc", "year", "car_name"))
head(auto)

# Valores ausentes

# Colocando o R para considerar blanks como NAs em atributos categóricos e variáveis do tipo texto.
faltando <- read.csv("missing-data.csv", na.strings="")

####################################
# Conhecendo o objeto factors
####################################

# Criando um vetor.
apple_colors <- c('green','green','yellow','red','red','red','green')

# Criando um objeto do tipo factor.
factor_apple <- factor(apple_colors)

# Apresentando o objeto criado.
print(factor_apple)
print(nlevels(factor_apple))

#Contabilizando as ocorrências
table(factor_apple)

####################################
# Lendo dados diretamente de websites
####################################

dat <- read.csv("http://www.exploredata.net/ftp/WHO.csv")


####################################
# Lendo dados em XML
####################################

# Instalando pacotes.
#install.packages("XML")

# Carregando o pacote.
library(XML)

# Inicializando.
url <- "cd_catalog.xml"

# Fazendo o "parsing" do arquivo e pegando o root node.
xmldoc <- xmlParse(url)
rootNode <- xmlRoot(xmldoc)
rootNode[1]

# Extraindo os dados do XML. 
# Usamos uma função que varre iterativamente todos os filhos do root node e armazena em uma matriz. 
data <- xmlSApply(rootNode, function(x) xmlSApply(x, xmlValue))

# Conventendo em data frame.
catalogo.cd <- data.frame(t(data),row.names=NULL)

# Verificando os resultados.
head(catalogo.cd)

####################################
# Lendo dados em JSON
####################################

# Instalando pacotes.
#install.packages("jsonlite")

# Carregando o pacote.
library(jsonlite)

# Carregando dados dos arquivos JSON.
dat.1 <- fromJSON("students.json")
dat.2 <- fromJSON("student-courses.json")

# Carregando um arquivo JSON da web.
url <- "http://finance.yahoo.com/webservice/v1/symbols/allcurrencies/quote?format=json"
jsonDoc <- fromJSON(url)

# Extraindo dados para os data frames.
dat <- jsonDoc$list$resources$resource$fields

# Verificando os resultados.
head(dat)
head(dat.1)
head(dat.2)


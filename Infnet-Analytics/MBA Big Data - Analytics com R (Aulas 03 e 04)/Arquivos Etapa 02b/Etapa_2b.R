# Disciplina: Big Data Analytics
# 
# Construir análises de dados simples utilizando R


# Criando três vetores
x1 <- 10
x2 = 20
assign("x3", 30)
#------------------------
# Cria novo vetor com x1, 2, 3 e x2.
x3 <- c(x1, 2, 3, x2)
x3
#------------------------
# Cria vetor com "a", "b" e "c"
x4 <- c("a", "b", "c")
x4
#------------------------
# Numeric
num <- c(522.34, 23, 456)
# Integer (atenção ao 'L')
int <- c(5L, 73L)
# Complex (atenção ao 'i')
compl <- c(10i, 3 + 5i)
# Caracter (atenção às aspas)
txt <- c("aspas duplas", 'aspas simples', "aspas 'dentro' do texto")
# Logic (maiúsculas!)
logi <- c(TRUE, FALSE, TRUE)
#------------------------
class(num)
class(int)
class(compl)
class(txt)
class(logi)
#------------------------
is.numeric(num)
is.character(num)

is.character(txt)
is.logical(txt)
#------------------------
str(x3)
str(num)
str(int)
str(compl)
str(txt)
str(logi)
#------------------------
num
names(num) <- c("num1","num2","num3")
num
names(num)
#------------------------
num[1] # Primeiro elemento
num[c(1,2)] # Elementos 1 e 2
num[c(1,3)] # Elementos 1 e 3
num[c(3,1,2)] # Alterando a ordem
#------------------------
num["num1"]
num["num2"]
num[c("num1", "num3")]
#------------------------
# Seleciona apenas o 1o elemento
num[c(TRUE, FALSE, FALSE)]
# Seleciona apenas o 3o elemento
num[c(FALSE, FALSE, TRUE)]
# Seleciona o 1o e o 3o elemento
num[c(TRUE, FALSE, TRUE)]
#------------------------
num

# Alterando o 1o elemento 100
num[1] <- 100
num

# Alterando o 2o e 3o elementos
num[2:3] <- c(12.3, -10)
num
#------------------------
order(num) # Índices p/ ordenação crescente

num[order(num)] # Ordena o vetor num

sort(num)
#------------------------
# Criando uma sequência de 1 a 10
1:100

# Criando uma sequência de -1 a -10
# Atenção: não é criada na ordem dos 
# inteiros!
-1:(-10)
#------------------------
seq(from = 1, to = 10, by = 3)

rep(1, times = 10)

rep(c(1,2), times = 5)
#------------------------
# Soma
1 + 20
# Soma vetorizada
c(1,2,3) + c(4,5,6)

# Subtração
200 - 2
# Subtração vetorizada
c(1,2,3) - c(4,5,6)

# Divisão
200 / 15
# Divisão
c(2,4,6) / c(1,2,3)

# Multiplicação
2*10
# Multiplicação vetorizada
c(10,9,8) * c(1,2,3)

# Exponenciação
4^2
# Exponenciação vetorizada
c(2,2,2) ^ c(1,2,3)

# Divisão inteira
7 %/% 3
# Divisão inteira vetorizada
c(7,7) %/% c(3,2)

# Módulo (resto da divisão)
7 %% 3
# Módulo vetorizado
c(7,7) %% c(3,2)
#------------------------
# Operação
x <- c(1, 2, 3, 4)
x * 2

# Equivale à
x * c(2, 2, 2, 2)
#------------------------
# Operação
x <- c(1, 2, 3, 4)
x * c(2, 3)

# Equivale à
x * c(2, 3, 2, 3)
#------------------------
# Operação
x * c(2, 3, 1)

# Warning message:
# In x * c(2, 3, 1) : 
#   longer object length is not a multiple of shorter object length
#------------------------
x <- c(1,2,-3, 4, -20.3)

abs(x) # Valor absoluto

log(x) # Logaritmo natural
# Warning message:
#   In log(x) : NaNs produced

exp(x) # Exponencial

sqrt(x) #Raiz quadrada
# Warning message:
#   In log(x) : NaNs produced

factorial(1000) # Fatorial (5*4*3*2*1)
#------------------------
sin(pi) # Seno
cos(pi) # Cosseno
tan(pi) # Tangente, etc.
#------------------------
x <- c(1,2,-3, 4, -20.3)

mean(x) # Média

sum(x) # Somatório

prod(x) # Produtório

cumsum(x) # Somatório acumulado

cumprod(x) # Produtório acumulado

y <- 1:5

var(x) # Variância

sd(x) # Desvio-padrão

median(x) # Mediana

cov(x, y) # Covariância

cor(x, y) # Correlação entre x e y

min(x) # Mínimo

max(x) # Máximo

cummin(x) # Mínimo "acumulado"

cummax(x) # Máximo "acumulado"

diff(x) # Diferença
#------------------------
x <- 10
y <- 20
x == y

x <- c(10, 20, 30)
y <- c(10, 10, 30)
x == y

# Montando um vetor com elementos de x # que são iguais a y 
x[x == y]

# Coerção! Converte x para texto e 
# compara textualmente.
x <- c(10, 20)
y <- c("10", "20")
x == y

# Cuidado com a coercao, pois podem ser
# gerados resultados inesperados:
20 > "100"
# Resultado correto pela ordem alfabética.
#------------------------
identical(x, y)

# Atenção com os casos abaixo!
# O que está acontecendo?
identical(sin(pi), 0)
identical(0.1, 0.3 - 0.2)
#------------------------
# Resultado falso, incorreto!
sin(pi) == 0

# Resultado verdadeiro, correto!
all.equal(sin(pi), 0)
#------------------------
abs(sin(pi) - 0) < 1e-12
#------------------------
x <- c(1,2,3,4,5)
y <- c("1","3","2","4","5");

# Armazena o resultado da comparação em
# "resultado"
resultado <- (x >= y)
resultado

# Usa o vetor 'resultado' para fazer um 
# subconjunto x
x[resultado]
#------------------------
as.numeric(resultado)

sum(resultado)
#------------------------
c(TRUE, FALSE) & c(TRUE, TRUE)

c(TRUE, FALSE) | c(TRUE, TRUE)
#------------------------
# Define a semente da simulação
set.seed(11)

# simula 1000 observações seguindo
# distribuição normal(5, 2)
x <- rnorm(1000, 5, 2)

# Existe algum x maior que 10?
any(x > 10)

# Todos os x estão entre -20 e 20?
all(x > -20 & x < 20)
#------------------------
which(c(TRUE, FALSE, TRUE))

# Quais as posições dos elementos de x
# maiores do que 10?
which(x > 10)
#------------------------
x <- 1:5
y <- c(1:3, 6:10)

# Conjunto dos elementos de x que 
# não estão em y
setdiff(x, y)

# Conjunto dos elementos de x que
# estão em y
intersect(x, y)

# Conjunto união de x e y
union(x, y)

# Quais elementos de x estão em y?
x %in% y
#------------------------
Data <- "11 de outubro de 2016"

Data <- as.Date(Data, format="%d de %B de %Y")
str(Data)
#------------------------
Data + 1

Data - 1

weekdays(Data)

Data > "2016-10-01"

months(Data + 31)

quarters(Data)

seq.Date(from = Data, by = 1, length.out = 10L)
#------------------------
Data <- "11 de outubro de 2014 às 19h e 40m"
ct <- as.POSIXct(Data,format="%d de %B de %Y às %Hh e %Mm")
ct

lt <- as.POSIXlt(Data, format="%d de %B de %Y às %Hh e %Mm")
lt
#------------------------
ct + 3600 # Soma uma hora
ct

lt - 60 # Subtrai um minuto
ct

months(ct)

weekdays(lt)
#------------------------


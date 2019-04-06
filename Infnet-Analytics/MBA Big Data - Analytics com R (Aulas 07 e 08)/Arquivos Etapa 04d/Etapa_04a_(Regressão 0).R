# Disciplina: Big Data Analytics com R
# Construir análise preditiva	

# -------------------------
# EXEMPLO DE REGRESSÃO 3D
# DATASET: AUSTRALIAN CONSUMER PRICE INDEX (CPI)
# -------------------------

# Instalando pacotes
#install.packages("scatterplot3d", dependencies=TRUE)

# Carregando pacotes
library(scatterplot3d)

# Criando o conjunto de dados.
year <- rep(2008:2010, each = 4)
quarter <- rep(1:4, 3)
cpi <- c(162.2, 164.6, 166.5, 166.0,
         166.2, 167.0, 168.6, 169.5,
         171.0, 172.1, 173.3, 174.0)


# Executando a regressão linear.
# Variável dependente: CPI
# Variáveis independentes: year, quarter
fit <- lm(cpi~ year + quarter)
fit

# Visualizando uma superfície de decisão tridimensional
# (neste caso, um plano de decisão)
library(scatterplot3d)
s3d <- scatterplot3d(year, quarter, cpi, highlight.3d=T,
                     type="h", lab=c(2,3))
s3d$plane3d(fit)

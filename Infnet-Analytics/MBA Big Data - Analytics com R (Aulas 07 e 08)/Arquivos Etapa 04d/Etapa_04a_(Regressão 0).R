# Disciplina: Big Data Analytics com R
# Construir an�lise preditiva	

# -------------------------
# EXEMPLO DE REGRESS�O 3D
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


# Executando a regress�o linear.
# Vari�vel dependente: CPI
# Vari�veis independentes: year, quarter
fit <- lm(cpi~ year + quarter)
fit

# Visualizando uma superf�cie de decis�o tridimensional
# (neste caso, um plano de decis�o)
library(scatterplot3d)
s3d <- scatterplot3d(year, quarter, cpi, highlight.3d=T,
                     type="h", lab=c(2,3))
s3d$plane3d(fit)

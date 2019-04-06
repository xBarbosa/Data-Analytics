# Disciplina: Big Data Analytics com R
# Construir análise preditiva	

# -------------------------
# EXEMPLO DE REGRESSÃO MÚLTIPLA
# DATASET: VAMOS GERAR UM CONJUNTO DE DADOS A PARTIR DE UMA MATRIZ DE COVARIÂNCIAS.
# OBJETIVO: AVALIAR COMO MÉTRICAS DE STRESS E SATISFAÇÃO NO TRABALHO AFETAM 
#           O COMPROMETIMENTO DE ENFERMEIRAS COM UM HOSPITAL.
# COMPONENTES:
# Commit: Commitment to their hospital (criterion here)
# Exhaust: Emotional exhaustion (one of the three components of burnout)
# Depers: Depersonalization (one of the three components of burnout)
# Accompl: Accomplishment (one of the three components of burnout)
# WorkSat: Work satisfaction
# WFC: Work-family conflict
#
# AUTOR: Eric Mayor
#
# -------------------------

# Instalando pacotes
#install.packages("MASS", dependencies=TRUE)

# Carregando pacotes
library(psych)
library(MASS)

# Carregando a matriz e gerando um dataset de 40 observações, a partir desta.
# Probabilidades menores que 0,05 são significantes (95%).
# Podemos ver que 'commitment' está significativamente correlacionado com 'exhaustion';
# 'work satisfaction' não está correlacionado com 'accomplishment' e 'work-family conflict';
# 'work-family conflict' não está correlacionado com 'depersonalization' e 'accomplishment'.

matcov = unlist(read.csv("matcov.txt", header=F))
covs = matrix(matcov, 6, 6)
means = c(4.47,14.95,4.87,36.08,5,1.88)
set.seed(987)
nurses = data.frame(mvrnorm(n=40, means, covs))
colnames(nurses)= c("Commit","Exhaus","Depers","Accompl",
                      "WorkSat","WFC")
corr.test(nurses)

# Visualizando.
# Podemos ver uma relação linear negativa entre 'commitment' e 'exhaustion' e 'WFC'.
# Podemos ver uma relação linear positiva entre 'commitment' e 'work satisfaction'.
plot(nurses)

# Executando a regressão.
# Na parte de baixo da saída, podemos ver o seguinte:
# O p-valor para a estatística F é significante a 95% de confiança.
# 55% da variância pe explicada pelo modelo (R-Squared).

model1 = lm(Commit ~ Exhaus + Depers + Accompl, data = nurses)
summary(model1)

# Verificando a normalidade dos resíduos.
# Podemos ver um desvio da normal.
hist(resid(model1), main="Histograma dos resíduos",
     xlab="Resíduos")

# Validando este desvio com um teste estatístico de normalidade.
shapiro.test(resid(model1))

# Analisando o Q-Q Plot.
plot(model1, which=c(2,2))

# Fazendo predições.
matcov2 = unlist(read.csv("matcov2.txt", header = F))
covs2 = matrix(matcov2, 6, 6)
means2 = c(4.279, 13.152, 5.156, 39.28, 5.153, 1.875)
set.seed(987)
nurses2 = data.frame(mvrnorm(n=40, means2, covs2))
colnames(nurses2)= c("Commit","Exhaus","Depers","Accompl",
                       "WorkSat","WFC")

predicted = predict.lm(model1, nurses2)

# Verificando a correlação entre os dados reais de compromisso do segundo dataset e a 
# previsão.
# Como a correlação é significativa, apesar da correlação não parecer muito alta,
# podemos ir em frente e usar o modelo..
cor.test(predicted, nurses2$Commit)



# Disciplina: Big Data Analytics com R
# Construir an�lise preditiva	

# -------------------------
# EXEMPLO DE REGRESS�O LOG�STICA
# DATASET: MTCARS
# OBJETIVO: PREVER SE A ESTRUTURA DO MOTOR � EM 'V' OU EM LINHA ('0' OU '1', RESPECTIVAMENTE
#           NA VARI�VEL DEPENDENTE 'vs') A PARTIR DA VARI�VEL INDEPENDENTE 'hp' 
#           (POT�NCIA).
# -------------------------

# Instalando pacotes
#install.packages("dplyr", dependencies=TRUE)
#install.packages("ggplot2", dependencies=TRUE)


# Carregando pacotes
library(dplyr)
library(ggplot2)

# Estat�stica descritiva da vari�vel 'VS' contra a 'HP'.
# 'VS' - Motor com configura��o em V (0) ou Straight - em linha (1).
# 'HP' - Pot�ncia.
mtcars %>%
  group_by(vs) %>%
  summarise("N" = n(),
            "Missing" = sum(is.na(hp)),
            "Media" = mean(hp),
            "DesvPad" = sd(hp),
            "Minimo" = min(hp),
            "Q1" = quantile(hp, 0.25),
            "Mediana" = quantile(hp, 0.50),
            "Q3" = quantile(hp, 0.75),
            "Maximo" = max(hp))

# Boxplot.
ggplot(mtcars) +
  geom_boxplot(aes(x = factor(vs), y = hp))

# Executando o modelo logit.
# ajuste_glm <- glm(vs ~ hp, data = mtcars, family = binomial)
fit = glm(vs ~ hp, data=mtcars, family=binomial)
summary(fit)


# Matriz de confus�o.
table(mtcars$vs, predict(fit) > 0.5)

# Visualiza��o.
newdat <- data.frame(hp=seq(min(mtcars$hp), max(mtcars$hp),len=100))
newdat$vs = predict(fit, newdata=newdat, type="response")
plot(vs~hp, data=mtcars, col="red4")
lines(vs ~ hp, newdat, col="green4", lwd=2)


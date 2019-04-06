# Disciplina: Big Data Analytics com R
# Construir análise preditiva	

# -------------------------
# EXEMPLO DE REGRESSÃO LOGÍSTICA
# DATASET: MTCARS
# OBJETIVO: PREVER SE A ESTRUTURA DO MOTOR É EM 'V' OU EM LINHA ('0' OU '1', RESPECTIVAMENTE
#           NA VARIÁVEL DEPENDENTE 'vs') A PARTIR DA VARIÁVEL INDEPENDENTE 'hp' 
#           (POTÊNCIA).
# -------------------------

# Instalando pacotes
#install.packages("dplyr", dependencies=TRUE)
#install.packages("ggplot2", dependencies=TRUE)


# Carregando pacotes
library(dplyr)
library(ggplot2)

# Estatística descritiva da variável 'VS' contra a 'HP'.
# 'VS' - Motor com configuração em V (0) ou Straight - em linha (1).
# 'HP' - Potência.
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


# Matriz de confusão.
table(mtcars$vs, predict(fit) > 0.5)

# Visualização.
newdat <- data.frame(hp=seq(min(mtcars$hp), max(mtcars$hp),len=100))
newdat$vs = predict(fit, newdata=newdat, type="response")
plot(vs~hp, data=mtcars, col="red4")
lines(vs ~ hp, newdat, col="green4", lwd=2)


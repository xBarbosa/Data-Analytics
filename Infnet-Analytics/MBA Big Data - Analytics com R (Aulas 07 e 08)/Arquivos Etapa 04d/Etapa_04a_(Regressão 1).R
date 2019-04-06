# Disciplina: Big Data Analytics com R
# Construir análise preditiva	

# -------------------------
# EXEMPLO DE REGRESSÃO LINEAR
# DATASET: IRIS DATASET
# -------------------------

# Analisando a relação entre Petal Length e Petal Width.
plot(iris$Petal.Length ~ iris$Petal.Width,
     main = "Relação entre Petal Length e Petal Width",
     xlab = "Petal Width", ylab = "Petal Length")
iris.lm = lm(iris$Petal.Length ~ iris$Petal.Width)
abline(iris.lm) # Adiciona a linha resultante da regressão à visualização.

# Calculando a inclinação, 1o. Método.
# Correlação * DP-dependente / DP-independente.
SlopeCoef = cor(iris$Petal.Length,iris$Petal.Width) *
  (sd(iris$Petal.Length) / sd(iris$Petal.Width))
SlopeCoef

# Calculando a inclinação, 2o. Método.
# Definição formal.
coeffs = function (y,x) {
  ( (length(y) * sum( y*x)) -
        (sum( y) * sum(x)) ) /
    (length(y) * sum(x^2) - sum(x)^2)
}
coeffs(iris$Petal.Length, iris$Petal.Width)

# Calculando a inclinação, 3o. Método.
# Função LM.
iris.lm

# Calculando a inclinação e o intercepto.
regress = function (y,x) {
 slope = coeffs(y,x)
 intercept = mean(y) - (slope * mean(x))
 model = c(intercept, slope)
 names(model) = c("intercept", "slope")
 model
}
model = regress(iris$Petal.Length, iris$Petal.Width)
model

# Calculando os resíduos.
resids = function (y,x, model) {
  y - model[1] - (model[2] * x)
}
Residuals = resids(iris$Petal.Length, iris$Petal.Width, model)
head(round(Residuals,2)) # Usando a função acima.
head(round(residuals(iris.lm),2)) # Usando a função LM.

# Visualizando o gráfico Quantil-Quantil (Q-Q Plot).
# A linha diagonal é a referência para uma distribuição normal.
# Como podemos ver, nossos resíduos estão bem alinhados então podemos considerar
# a distribuição dos resíduos como normal (um dos requisitos para uma boa regressão).

plot(iris.lm, which=c(2,2))


# Calculando a significância.
# SE (Standard Error - Erro Padrão): valor que indica a precisão da estimativa.
# t Score: valor que será usado para o cálculo da significância estatística.
# sig: significância estatística (se for ZERO a estimativa pode ser usada)


Significance = function (y, x, model) {
 SSE = sum (resids(y,x,model)^2)
 DF = length(y)-2
 S = sqrt ( SSE / DF)
 SEslope = S / sqrt(sum( (x-mean(x))^2 ))
 tslope = model[2] / SEslope
 sigslope = 2*(1-pt(abs(tslope),DF))
 SEintercept = S * sqrt((1/length(y) +
                          mean(x)^2 / sum( (x- mean(x))^2)))
 tintercept = model[1] / SEintercept
 sigintercept = 2*(1-pt(abs(tintercept),DF))
 RES = c(SEslope, tslope, sigslope, SEintercept,
          tintercept, sigintercept)
 names(RES) = c("SE inclinação", "t inclinação", "sig inclinação",
                    "SE intercepto", "t intercepto", "sig intercepto")
 RES
}

# Calculando pela função acima.
round(Significance(iris$Petal.Length,iris$Petal.Width, model), 3)

summary(iris.lm) # Via função LM.



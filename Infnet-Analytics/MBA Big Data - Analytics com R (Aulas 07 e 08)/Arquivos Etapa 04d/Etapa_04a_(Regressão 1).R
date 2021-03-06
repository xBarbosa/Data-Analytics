# Disciplina: Big Data Analytics com R
# Construir an�lise preditiva	

# -------------------------
# EXEMPLO DE REGRESS�O LINEAR
# DATASET: IRIS DATASET
# -------------------------

# Analisando a rela��o entre Petal Length e Petal Width.
plot(iris$Petal.Length ~ iris$Petal.Width,
     main = "Rela��o entre Petal Length e Petal Width",
     xlab = "Petal Width", ylab = "Petal Length")
iris.lm = lm(iris$Petal.Length ~ iris$Petal.Width)
abline(iris.lm) # Adiciona a linha resultante da regress�o � visualiza��o.

# Calculando a inclina��o, 1o. M�todo.
# Correla��o * DP-dependente / DP-independente.
SlopeCoef = cor(iris$Petal.Length,iris$Petal.Width) *
  (sd(iris$Petal.Length) / sd(iris$Petal.Width))
SlopeCoef

# Calculando a inclina��o, 2o. M�todo.
# Defini��o formal.
coeffs = function (y,x) {
  ( (length(y) * sum( y*x)) -
        (sum( y) * sum(x)) ) /
    (length(y) * sum(x^2) - sum(x)^2)
}
coeffs(iris$Petal.Length, iris$Petal.Width)

# Calculando a inclina��o, 3o. M�todo.
# Fun��o LM.
iris.lm

# Calculando a inclina��o e o intercepto.
regress = function (y,x) {
 slope = coeffs(y,x)
 intercept = mean(y) - (slope * mean(x))
 model = c(intercept, slope)
 names(model) = c("intercept", "slope")
 model
}
model = regress(iris$Petal.Length, iris$Petal.Width)
model

# Calculando os res�duos.
resids = function (y,x, model) {
  y - model[1] - (model[2] * x)
}
Residuals = resids(iris$Petal.Length, iris$Petal.Width, model)
head(round(Residuals,2)) # Usando a fun��o acima.
head(round(residuals(iris.lm),2)) # Usando a fun��o LM.

# Visualizando o gr�fico Quantil-Quantil (Q-Q Plot).
# A linha diagonal � a refer�ncia para uma distribui��o normal.
# Como podemos ver, nossos res�duos est�o bem alinhados ent�o podemos considerar
# a distribui��o dos res�duos como normal (um dos requisitos para uma boa regress�o).

plot(iris.lm, which=c(2,2))


# Calculando a signific�ncia.
# SE (Standard Error - Erro Padr�o): valor que indica a precis�o da estimativa.
# t Score: valor que ser� usado para o c�lculo da signific�ncia estat�stica.
# sig: signific�ncia estat�stica (se for ZERO a estimativa pode ser usada)


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
 names(RES) = c("SE inclina��o", "t inclina��o", "sig inclina��o",
                    "SE intercepto", "t intercepto", "sig intercepto")
 RES
}

# Calculando pela fun��o acima.
round(Significance(iris$Petal.Length,iris$Petal.Width, model), 3)

summary(iris.lm) # Via fun��o LM.



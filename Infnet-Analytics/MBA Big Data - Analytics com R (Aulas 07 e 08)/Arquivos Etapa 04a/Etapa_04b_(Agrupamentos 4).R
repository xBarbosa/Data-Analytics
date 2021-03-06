# Disciplina: Big Data Analytics com R

# -------------------------
# AGRUPAMENTOS
# DATASET: Imagem "Taking a Break" 1024 x 768
# http://www.desktopdress.com/desktop-wallpapers/animals-birds-pictures/taking-a-break#800x600
# AUTOR: DeZyre K-Means Clustering Tutorial
# https://www.dezyre.com/data-science-in-r-programming-tutorial/k-means-clustering-techniques-tutorial
#
# PROBLEMA:
# Quantas cores devem existir na imagem a ser utilizada no exemplo?
# Esta simples imagem possui mais de 124 mil combina��es �nicas de cores!
# Nosso objetivo � reproduzir a imagem utilizando menos cores (um tipo de compress�o).
# Idealmente, tentaremos algo pr�ximo � 3 ou 4 cores.
# Para tal vamos considerar a imagem como uma cole��o de pixels, cada um representado por 
# 3 vari�veis (R, G, B).
# -------------------------

# Instalando pacotes.
#install.packages("jpeg", dependencies = TRUE)
#install.packages("ggplot2", dependencies = TRUE)

# Carregando bibliotecas.
library("jpeg")
library("ggplot2")

# Lendo a imagem
dog_img<-readJPEG("taking-a-break.jpg")

# Capturando as caracter�sticas da imagem.
img_Dm <- dim(dog_img)

# Armazenando canais RGB em um dataframe.
img_RGB <- data.frame(
  x_axis = rep(1:img_Dm[2], each = img_Dm[1]),
  y_axis = rep(img_Dm[1]:1, img_Dm[2]),
  Red = as.vector(dog_img[,,1]),
  Green = as.vector(dog_img[,,2]),
  Blue = as.vector(dog_img[,,3])
)

# Visualizando a imagem original.
ggplot(data = img_RGB, aes(x = x_axis, y = y_axis)) +
  geom_point(colour = rgb(img_RGB[c("Red", "Green", "Blue")])) +
  labs(title = "Imagem Original") +
  xlab("x-axis") +
  ylab("y-axis")

# Iniciando a  aplica��o da t�cnica de agrupamentos.

# Fun��o que gera o c�lculo que ser� utilizado no m�todo do cotovelo.
wssplot <- function(data, nc=15, seed=1234){
  wss <- (nrow(data)-1)*sum(apply(data,2,var))
  for (i in 2:nc){
    set.seed(seed)
    wss[i] <- sum(kmeans(data, centers=i)$withinss)}
  plot(1:nc, wss, type="b", xlab="N�mero de grupos",
       ylab="Soma dos quadrados (internos aos grupos)")}

wssplot(img_RGB[c(3,4,5)],25)

# Executando o algoritmo K-m�dias.

set.seed(1234) # Para reprodu��o posterior.
k_cluster <- 5
k_img_clstr <- kmeans(img_RGB[, c("Red", "Green", "Blue")],
                      centers = k_cluster)
k_img_colors <- rgb(k_img_clstr$centers[k_img_clstr$cluster,])

# Visualizando a imagem comprimida.
ggplot(data = img_RGB, aes(x = x_axis, y = y_axis)) +
  geom_point(colour = k_img_colors) +
  labs(title = paste("Agrupamento K-m�dias de", k_cluster, "cores")) +
  xlab("x") +
  ylab("y")

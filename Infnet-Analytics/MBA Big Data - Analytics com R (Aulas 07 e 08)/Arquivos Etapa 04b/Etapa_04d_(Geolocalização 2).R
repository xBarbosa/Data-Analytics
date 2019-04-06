# Disciplina: Big Data Analytics com R

# -------------------------
# EXEMPLOs DE MAPAS 'POLIGONAIS'
# FONTE: http://www.milanor.net/
# -------------------------

# Instalando pacotes
#install.packages("rworldmap", dependencies=TRUE)
#install.packages("ggmap", dependencies=TRUE)

# Carregando pacotes
library(rworldmap)
library(ggmap)

# Este pacote apresenta mapas como polígonos espaciais, melhores quando queremos 
# colorir internamente.

# Visualizando um mapa-mundi.
mapamundi <- getMap(resolution = "low")
plot(mapamundi)

# Neste caso, para fazermos um zoom, temos que experimentar um pouco com as coordenadas.
# Tentando um mapa da Europa.
plot(mapamundi, xlim = c(-20, 59), ylim = c(35, 71), asp = 1)

# Tentando minimizar a tentativa-e-erro para os pontos extremos. 
# Pontos extremos do Brasil: https://en.wikipedia.org/wiki/List_of_extreme_points_of_Brazil
# A função 'geocode' captura as coordenadas de uma localidade usando o Google Maps.
brasil.limits <- geocode(c("Monte Caburai, Roraima",
                           "Barra do Chui, Rio Grande do Sul",
                           "Serra do Divisor, Acre",
                           "Ilhas Martin Vaz, Espirito Santo")
                           )
brasil.limits

# Visualizando somente o Brasil.
plot(mapamundi, xlim = range(brasil.limits$lon), ylim = range(brasil.limits$lat), asp = 1)

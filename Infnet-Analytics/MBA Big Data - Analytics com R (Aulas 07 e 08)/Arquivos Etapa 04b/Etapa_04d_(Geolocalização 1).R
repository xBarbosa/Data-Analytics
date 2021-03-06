# Disciplina: Big Data Analytics com R

# -------------------------
# EXEMPLOs DE MAPAS 'RASTER'
# DATASET: GOOGLE MAPS
# FONTE: http://www.milanor.net/
# -------------------------

# Instalando pacotes
#install.packages("ggplot2", dependencies=TRUE)
#install.packages("ggmap", dependencies=TRUE)
#install.packages("mapproj", dependencies=TRUE)

# Carregando pacotes
library(ggplot2)
library(ggmap)
library(mapproj)

# Os mapas produzidos por ggmap s�o do tipo 'raster'. Podem ser utilizados para
# plotarmos pontos por cima por�m ruins para trabalhar com colora��o de mapas. 

# Configurando e autenticando na API.
# https://developers.google.com/maps/documentation/geocoding/get-api-key
register_google(key = 'AIzaSyD4uWlZhZyZkMYvCAKiZPd2VYQXIV0qgj4', write = TRUE)

# Visualizando o mapa da Europa.
# Assim pegamos o mapa do Google Maps.
# O par�metro 'location' deve ser preenchido com a busca que se quer.
# O par�metro 'zoom' vai de 0 a 21, sendo zero o mapa-mundi, centrado no par�metro acima..
europa <- get_map(location = 'Germany', zoom = 15 )
ggmap(europa) # Visualizando.


# Pegando o mapa do Brasil.
brasil <- get_map(location = 'Brazil', zoom = 4)
ggmap(brasil) # Visualizando.

# Pegando o mapa do Rio de Janeiro.
riodejaneiro <- get_map(location = 'Rio de Janeiro', zoom = 12)
ggmap(riodejaneiro) # Visualizando.




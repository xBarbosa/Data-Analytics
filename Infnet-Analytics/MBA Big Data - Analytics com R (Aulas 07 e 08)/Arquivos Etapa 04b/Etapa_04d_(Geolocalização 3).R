# Disciplina: Big Data Analytics com R

# -------------------------
# VISUALIZANDO DADOS EM MAPAS
# DATASETS: OpenFlights (https://github.com/jpatokal/openflights)
# FONTE: http://www.milanor.net/
# -------------------------

# Instalando pacotes
#install.packages("rworldmap", dependencies=TRUE)
#install.packages("plyr", dependencies=TRUE)
#install.packages("ggmap", dependencies=TRUE)

# Carregando pacotes
library(rworldmap)
library(plyr)
library(ggmap)

# Capturando dados de aeroportos do reposit�rio OpenFlights.
airports <- read.csv("airports.dat", header = FALSE)
colnames(airports) <- c("ID", "name", "city", "country", "IATA_FAA", "ICAO", "lat", "lon", "altitude", "timezone", "DST")
head(airports)

# Visualizando o mapa.
newmap <- getMap(resolution = "low")
plot(newmap, xlim = c(-20, 59), ylim = c(35, 71), asp = 1)

# Visualizando aeroportos.
points(airports$lon, airports$lat, col = "red", cex = .6)

# Capturando dados de rotas do reposit�rio OpenFlights.
routes <- read.csv("routes.dat", header=F)
colnames(routes) <- c("airline", "airlineID", "sourceAirport", "sourceAirportID", "destinationAirport", "destinationAirportID", "codeshare", "stops", "equipment")
head(routes)

# Fazendo a contagem de partidas e chegadas de cada aeroporto.
departures <- ddply(routes, .(sourceAirportID), "nrow")
names(departures)[2] <- "flights"
arrivals <- ddply(routes, .(destinationAirportID), "nrow")
names(arrivals)[2] <- "flights"

# Adidionando a informa��o de partidas e chegadas ao dataframe original.
airportD <- merge(airports, departures, by.x = "ID", by.y = "sourceAirportID")
airportA <- merge(airports, arrivals, by.x = "ID", by.y = "destinationAirportID")

# O objetivo � apresentar os aeroportos no mapa da Europa como c�rculos
# com �rea proporcional ao n�mero de partidas.

# Capturando o mapa.
map <- get_map(location = 'Europe', zoom = 4)

# Preparando para visualiza��o com o ggmap.
# 'geom_point' adiciona a camada de pontos de dados.
# 'aes' indica como os pontos ser�o gerados. 'lon' est� relacionado ao eixo x e 'lat' ao y.
# 'size' indica como ser�o os tamamhos dos pontos, neste caso proporcionais � raiz quadrada
#        do valor da vari�vel 'flights'.
# 'data' � o dataset.
# 'alpha' controla a transpar�ncia dos pontos
mapPoints <- ggmap(map) +
  geom_point(aes(x = lon, y = lat, size = sqrt(flights)), data = airportD, alpha = .5)

# Arrumando a legenda para apresentar o n�mero de voos e n�o a raiz quadrada.
mapPointsLegend <- mapPoints +
  scale_size_area(breaks = sqrt(c(1, 5, 10, 50, 100, 500)), labels = c(1, 5, 10, 50, 100, 500), name = "departing routes")

mapPointsLegend

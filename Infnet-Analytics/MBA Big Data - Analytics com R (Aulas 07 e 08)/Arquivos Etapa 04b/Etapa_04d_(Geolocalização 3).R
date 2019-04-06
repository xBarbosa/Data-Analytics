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

# Capturando dados de aeroportos do repositório OpenFlights.
airports <- read.csv("airports.dat", header = FALSE)
colnames(airports) <- c("ID", "name", "city", "country", "IATA_FAA", "ICAO", "lat", "lon", "altitude", "timezone", "DST")
head(airports)

# Visualizando o mapa.
newmap <- getMap(resolution = "low")
plot(newmap, xlim = c(-20, 59), ylim = c(35, 71), asp = 1)

# Visualizando aeroportos.
points(airports$lon, airports$lat, col = "red", cex = .6)

# Capturando dados de rotas do repositório OpenFlights.
routes <- read.csv("routes.dat", header=F)
colnames(routes) <- c("airline", "airlineID", "sourceAirport", "sourceAirportID", "destinationAirport", "destinationAirportID", "codeshare", "stops", "equipment")
head(routes)

# Fazendo a contagem de partidas e chegadas de cada aeroporto.
departures <- ddply(routes, .(sourceAirportID), "nrow")
names(departures)[2] <- "flights"
arrivals <- ddply(routes, .(destinationAirportID), "nrow")
names(arrivals)[2] <- "flights"

# Adidionando a informação de partidas e chegadas ao dataframe original.
airportD <- merge(airports, departures, by.x = "ID", by.y = "sourceAirportID")
airportA <- merge(airports, arrivals, by.x = "ID", by.y = "destinationAirportID")

# O objetivo é apresentar os aeroportos no mapa da Europa como círculos
# com área proporcional ao número de partidas.

# Capturando o mapa.
map <- get_map(location = 'Europe', zoom = 4)

# Preparando para visualização com o ggmap.
# 'geom_point' adiciona a camada de pontos de dados.
# 'aes' indica como os pontos serão gerados. 'lon' está relacionado ao eixo x e 'lat' ao y.
# 'size' indica como serão os tamamhos dos pontos, neste caso proporcionais à raiz quadrada
#        do valor da variável 'flights'.
# 'data' é o dataset.
# 'alpha' controla a transparência dos pontos
mapPoints <- ggmap(map) +
  geom_point(aes(x = lon, y = lat, size = sqrt(flights)), data = airportD, alpha = .5)

# Arrumando a legenda para apresentar o número de voos e não a raiz quadrada.
mapPointsLegend <- mapPoints +
  scale_size_area(breaks = sqrt(c(1, 5, 10, 50, 100, 500)), labels = c(1, 5, 10, 50, 100, 500), name = "departing routes")

mapPointsLegend

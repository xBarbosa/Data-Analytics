# Disciplina: Big Data Analytics com R

# -------------------------
# EXEMPLO DE DIAGRAMA DE VORONOI
# DATASET: U.S.A AIRPORT LOCATIONS
# FONTE: http://flowingdata.com/2016/04/12/voronoi-diagram-and-delaunay-triangulation-in-r/
# D3.js SIMILAR: http://bl.ocks.org/mbostock/4360892
# -------------------------

# Instalando pacotes
#install.packages("deldir", dependencies=TRUE)
#install.packages(c("sp", "maps", "maptools", "mapproj"), dependencies=TRUE)

# Carregando pacotes
library(mapproj) # Proje��es.
library(deldir) # Voronoi.


# Carregando os dados
airports <- read.csv("airport-locations.tsv", sep="\t", stringsAsFactors=FALSE)

# Usando uma fun��o para manter apenas os estados cont�guos.
source("latlong2state.R")
airports$state <- latlong2state(airports[,c("longitude", "latitude")])
airports_contig <- na.omit(airports)

# Proje��es
airports_projected <- mapproject(airports_contig$longitude, airports_contig$latitude, 
                                 "albers", param=c(39,45))

# Visualiza��o como mapa de pontos.
par(mar=c(0,0,0,0))
plot(airports_projected, asp=1, type="n", bty="n", xlab="", ylab="", axes=FALSE)
points(airports_projected, pch=20, cex=0.1, col="red")

# Visualiza��o como diagrama de Voronoi
vtess <- deldir(airports_projected$x, airports_projected$y)
plot(vtess, wlines="tess", wpoints="none", number=FALSE, add=TRUE, lty=1)

library("namespace")
library("raster")
library("sp")
library("rgdal")
library("maptools")
library("rgeos")
library("rJava")
library("xlsx")

#setwd("T:/Oyster Project/mels_git/coop/Coop_Data")
#coop<-read.csv("data/coop.csv", header= TRUE,sep=",")
#coordinates(coop)<-~Lon+Lat
#coop$Month<- as.numeric(coop$Month)
#coop$Year<- as.numeric(coop$Year)
#coop_split<- split(coop,list(coop$Year,coop$Month))
#class(coop)
#lapply(names(coop_split),
#       function(x)writeOGR(coop_split[x],
#                            file =paste0(x,'.shp'), row.names = FALSE, 
#                            col.names = FALSE, append = TRUE))
#

#Set the directory, as the project directory
coop<-read.csv("csv/coop.csv", header= TRUE,sep=",")

#Adding coordinates to the Lon and Lat
coordinates(coop)<-~Lon+Lat

#Saving the .csv as a shapefile
writeOGR(obj=coop, dsn="shp", layer="coop", driver="ESRI Shapefile")

data<- readOGR("shp/coop.shp") 

#The projection can be changed to any projection, in this case we are using 17 N 
proj4string(data) <- CRS("+proj=longlat + EPSG:32617")

#Adding both the year and month to a new column 
data$YM<- paste(data$Year,"_" ,data$Month)
  
# Creating unique instances of both year/month and just year  
unique <- unique(data$YM)

unqiue_year<- unique(data$Year)

#Save these shapefiles in the appropriate file
setwd("T:/Oyster Project/mels_git/coop/Coop_Data/shp")


#Per month, per year, saving as a shapefile
for (i in 1:length(unique)) {
  year <- data[data$YM == unique[i], ]
  writeOGR(year, dsn=getwd(), unique[i], driver="ESRI Shapefile",
           overwrite_layer=TRUE)
}

#Per year, saving as a shapefile
for (i in 1:length(unqiue_year)) {
  year2 <- data[data$Year == unqiue_year[i], ]
  writeOGR(year2, dsn=getwd(), unqiue_year[i], driver="ESRI Shapefile",
           overwrite_layer=TRUE)
}


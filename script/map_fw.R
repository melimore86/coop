library("ggplot2")
library("tidyverse")
library("zoo")
#library("rworldmap")
#library("rworldxtra")
library("sf")
library("rgeos")
library("maps")
library("mapdata")
library("maptools")
#library("wesanderson")
library("tidyr")
library("rgdal")
library("sp")
library("dplyr")


#Shapefile for the coast

shape <- sf::st_read(dsn = "T:/Oyster Project/mels_git/coop/Coop_Data/coast", layer = "fl_12k_2004_poly")

#Proposed Reef

propreef <- sf::st_read(dsn=path.expand("T:/Oyster Project/mels_git/coop/Coop_Data/shapefile"), layer = "LC_reef_elements")

#Cooperator data

coop<-read.csv("csv/coop.csv", header= TRUE,sep=",")

coop$Date <- as.Date( paste(coop$Year , coop$Month , coop$Day , sep = "." )  , format = "%Y.%m.%d" )

# Basic world map
usa <- map_data("usa")

coop_17<- filter(coop, format(coop$Date, '%Y') == "2017")

map_botsal_py<-
  ggplot()+
  geom_point(data = coop, aes(x=Lon, y=Lat,shape= Data_source, color=Bottom_sal))+
  geom_polygon(data = usa, aes(x=long, y = lat, group = group), fill = NA, color = "black") +
  geom_sf(data = propreef2, size=1.1, color= "black") +
  labs(x= "Longitude UTM 17N ", y= "Latitude UTM 17N", color= "Salinity- Bottom", shape= "Cooperator")+
  scale_color_gradient(low = "yellow", high = "red") +
  coord_sf(xlim = c(-83.05, -83.2), ylim = c(29.19, 29.3), expand = FALSE, datum = st_crs(26917))+
  guides(color = guide_legend(order = 1), 
         shape = guide_legend(order = 2)) +
  theme(panel.border = element_rect(color = "black", size = 0.5, fill = NA, linetype="solid"),axis.text.x = element_text(angle = 90, hjust = 1)) +
  facet_wrap(~Year) 
ggsave('map_botsal_py.png', height = 20, width = 20, dpi=300)

map_sursal_py<-
ggplot()+
  geom_point(data = coop, aes(x=Lon, y=Lat,shape= Data_source, color=Surface_sal))+
  geom_polygon(data = usa, aes(x=long, y = lat, group = group), fill = NA, color = "black") +
  geom_sf(data = propreef2, size=1.1, color= "black") +
  labs(x= "Longitude UTM 17N ", y= "Latitude UTM 17N", color= "Salinity- Surface", shape= "Cooperator")+
  scale_color_gradient(low = "yellow", high = "red") +
  coord_sf(xlim = c(-83.05, -83.2), ylim = c(29.19, 29.3), expand = FALSE, datum = st_crs(26917))+
  guides(color = guide_legend(order = 1), 
         shape = guide_legend(order = 2)) +
  theme(panel.border = element_rect(color = "black", size = 0.5, fill = NA, linetype="solid"),axis.text.x = element_text(angle = 90, hjust = 1)) +
  facet_wrap(~Year)
ggsave('map_sursal_py.png', height = 20, width = 20, dpi=300)

coop17_sur<- 
ggplot()+
  geom_point(data = coop_17, aes(x=Lon, y=Lat,shape= Data_source, color=Surface_sal), size=3)+
  geom_polygon(data = usa, aes(x=long, y = lat, group = group), fill = NA, color = "black") +
  geom_sf(data = propreef2, size=1.1, color= "black") +
  labs(x= "Longitude UTM 17N ", y= "Latitude UTM 17N", color= "Salinity- Surface", shape= "Cooperator")+
  scale_color_gradient(low = "yellow", high = "red") +
  coord_sf(xlim = c(-83.05, -83.2), ylim = c(29.19, 29.3), expand = FALSE, datum = st_crs(26917))+
  guides(color = guide_legend(order = 1), 
         shape = guide_legend(order = 2)) +
  theme(panel.border = element_rect(color = "black", size = 0.5, fill = NA, linetype="solid"),axis.text.x = element_text(angle = 90, hjust = 1)) 
ggsave('coop17_sur.png', height = 6, width = 6, dpi=200)

coop17_bot<- 
ggplot()+
  geom_point(data = coop_17, aes(x=Lon, y=Lat,shape= Data_source, color=Bottom_sal), size=3)+
  geom_polygon(data = usa, aes(x=long, y = lat, group = group), fill = NA, color = "black") +
  geom_sf(data = propreef2, size=1.1, color= "black") +
  labs(x= "Longitude UTM 17N ", y= "Latitude UTM 17N", color= "Salinity- Bottom", shape= "Cooperator", title= "Cooperator WQ 2017")+
  scale_color_gradient(low = "yellow", high = "red") +
  coord_sf(xlim = c(-83.05, -83.2), ylim = c(29.19, 29.3), expand = FALSE, datum = st_crs(26917))+
  guides(color = guide_legend(order = 1), 
         shape = guide_legend(order = 2)) +
  theme(panel.border = element_rect(color = "black", size = 0.5, fill = NA, linetype="solid"),axis.text.x = element_text(angle = 90, hjust = 1)) 
ggsave('coop17_bot.png', height = 6, width = 6, dpi=200)







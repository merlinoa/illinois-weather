library(dplyr)
library(rnoaa)
library(shiny)
library(threejs)

# We had some rendering problems serving these images directly, it
# seems to work more reliably if we send them as dataURIs.
earth_dark   <- system.file("images/world.jpg",package="threejs")
res <- storm_shp(year = 2013)
storm_data <- as.data.frame(storm_shp_read(res)[, 1:10])
storms <- unique(storm_data$Serial_Num)
#colors <- sample(colors(), length(storms), replace = TRUE)
colors <- paste(sample(0:255,size=length(storms),replace=TRUE),collapse=" ")
storms <- data.frame(storms, colors)
names(storms) <- c("Serial_Num", "colors")
storms_data <- left_join(storm_data, storms, by = "Serial_Num")
#col <- list(
#  earth_dark=list(img=earth_dark,bodycolor="#0011ff",emissive="#0011ff",lightcolor="#99ddff")
#)

shinyServer(function(input, output) {
  
  output$globe <- renderGlobe({
    globejs(lat = storms_data$coords.x2,
            long = storms_data$coords.x1,
            color = storms_data$colors,
            img = earth_dark,
            value = storms_data$wmo_wind / 20)
            #bodycolor="#0011ff",
            #emissive="#0011ff",
            #lightcolor="#99ddff")
  })
  
})
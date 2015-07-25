library(dplyr)
library(rnoaa)
library(shiny)
library(threejs)

earth_dark   <- system.file("images/world.jpg",package="threejs")
res <- storm_shp(year = 2013)
storm_data <- as.data.frame(storm_shp_read(res)[, 1:10])
storms <- unique(storm_data$Serial_Num)
colors <- c()
for (i in seq_along(storms)) {  
  colors[i] <- 
    paste0(
      c("#",
        sample(
          c("0", "1", "2", "3", "4", "5", "6", "7", "8" , "9",
            "A", "B", "C", "D", "E", "F"
          ),
          size = 6 ,
          replace=TRUE
        )
      ),
      collapse = ""
    )
}
storms <- data.frame(storms, colors)
storms$colors <- as.character(storms$colors)
names(storms) <- c("Serial_Num", "colors")
storms_data <- left_join(storm_data, storms, by = "Serial_Num")


shinyServer(function(input, output) {
  
  output$globe <- renderGlobe({
    globejs(lat = storms_data$coords.x2,
            long = storms_data$coords.x1,
            color = storms_data$colors,
            img = earth_dark,
            value = storms_data$wmo_wind / 40
            )
  })
  
})
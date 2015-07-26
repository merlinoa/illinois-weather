

earth_dark   <- system.file("images/world.jpg",package="threejs")
# load the data
load(file = "data/storm_data.rda")
# data was downloaded using the rnoaa package and the 
# following commentted out code
#res2010 <- storm_shp(year = 2010)
#res2011 <- storm_shp(year = 2011)
#res2012 <- storm_shp(year = 2012)
#res2013 <- storm_shp(year = 2013)
#res2014 <- storm_shp(year = 2014)
#storm_data2010 <- as.data.frame(storm_shp_read(res2010)[, 1:10])
#storm_data2011 <- as.data.frame(storm_shp_read(res2011)[, 1:10])
#storm_data2012 <- as.data.frame(storm_shp_read(res2012)[, 1:10])
#storm_data2013 <- as.data.frame(storm_shp_read(res2013)[, 1:10])
#storm_data2014 <- as.data.frame(storm_shp_read(res2014)[, 1:10])
#storm_data <- rbind(storm_data2010, storm_data2011, storm_data2012, storm_data2013, storm_data2014)
#storms <- unique(storm_data$Serial_Num)
#colors <- c()
#for (i in seq_along(storms)) {  
#  colors[i] <- 
#    paste0(
#      c("#",
#        sample(
#          c("0", "1", "2", "3", "4", "5", "6", "7", "8" , "9",
#            "A", "B", "C", "D", "E", "F"
#          ),
#          size = 6 ,
#          replace=TRUE
#        )
#      ),
#      collapse = ""
#    )
#}
#storms <- data.frame(storms, colors)
#storms$colors <- as.character(storms$colors)
#names(storms) <- c("Serial_Num", "colors")
#storm_data <- left_join(storm_data, storms, by = "Serial_Num")


shinyServer(function(input, output) {
  
  # subset storms by year
  storms_data <- reactive({
    storm_data[storm_data$Season == input$year, ]
  })
  
  
  output$globe <- renderGlobe({
    threejs::globejs(lat = storm_data$coords.x2,
            long = storm_data$coords.x1,
            color = storm_data$colors,
            img = earth_dark,
            value = storm_data$wmo_wind / 40
            )
  })
  
})
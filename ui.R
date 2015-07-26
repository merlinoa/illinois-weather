shinyUI(fluidPage(
  titlePanel("Storms"), 
  sidebarLayout( 
    sidebarPanel(
      selectInput(
        "year",
        label = "Year",
        choices = list(2010, 2011, 2012, 2013, 2014),
        multiple = TRUE
      )
    ),
    mainPanel(  
      threejs::globeOutput("globe") 
    ) 
  ) 
))
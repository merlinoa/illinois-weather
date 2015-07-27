shinyUI(fluidPage(
  titlePanel("Storms"), 
  sidebarLayout( 
    sidebarPanel(
      selectInput(
        "year",
        label = "Year",
        choices = list(2010, 2011, 2012, 2013, 2014),
        multiple = TRUE,
        selected = 2014
      )
    ),
    mainPanel(  
      threejs::globeOutput("globe") 
    ) 
  ) 
))
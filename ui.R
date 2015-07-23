shinyUI(fluidPage(
  titlePanel("Illinois Weather"), 
  sidebarLayout( 
    sidebarPanel(
      textInput("weather", "Weather", 
                value = "pracipitation") 
    ),
    mainPanel( 
      h3(textOutput("text")), 
      plotOutput("plot") 
    ) 
  ) 
))
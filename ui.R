shinyUI(fluidPage(
  titlePanel("Named Wind Storms"), 
  sidebarLayout( 
    sidebarPanel(
      selectInput(
        "year",
        label = "Year",
        choices = list(2010, 2011, 2012, 2013, 2014),
        multiple = TRUE,
        selected = 2013
      ),
      selectInput(
        "type",
        label = "Storm Category",
        choices = list(
                    "Tropical in Nature" = "TS",
                    "Extra Tropical" = "ET",
                    "Disturbance" = "DS",
                    "Sub Tropical" = "SS",
                    "Not Reported" = "NR",
                    "Conflicting Reports" = "MX"
                  ),
        multiple = TRUE,
        selected = c("TS", "ET")
      ),
      p("See the ", a("NOAA Guide" ,href = "ftp://eclipse.ncdc.noaa.gov/pub/ibtracs/documents/Storm_nature_assignment.pdf"),
        "to learn more about windstorm category")
    ),
    mainPanel(  
      threejs::globeOutput("globe") 
    ) 
  ) 
))
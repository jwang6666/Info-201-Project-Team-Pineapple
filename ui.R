#install.packages("shiny")
#install.packages("dplyr")
#install.packages("leaflet")
#install.packages("rsconnect")
library("shiny")
library("dplyr")
library("leaflet")
library("rsconnect")

my.ui <- fluidPage(
  sidebarLayout(
    mainPanel(
      textOutput("num_crime"),
      leafletOutput("mymap")
    ),
    sidebarPanel(
      sliderInput("sliderTime", label = "Time (Year)", min = 2012, 
                  max = 2018, value = c(2014, 2016), round = -1, step = 0.5,
                  sep = ""
      ),
      selectInput("selectCrime", "Type of Crime",
                  c("Burglary" = "bur",
                    "Robbery" = "rob",
                    "Assault" = "ass",
                    "Vehicle Theft" = "vt",
                    "Threats" = "thr",
                    "Homicide" = "hom")
      )
    )
  )
)

shinyUI(my.ui)
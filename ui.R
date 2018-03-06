#install.packages("shiny")
#install.packages("dplyr")
#install.packages("leaflet")
#install.packages("rsconnect")
#install.packages("ggplot2")
#install.packages("scales")
library("shiny")
library("dplyr")
library("leaflet")
library("rsconnect")
library("ggplot2")
library("scales")

my.ui <- fluidPage(
  titlePanel <- h1("Factors Correlated top Violent Crimes in Seattle"),
  
  sidebarLayout(
    mainPanel(
      tabsetPanel(type="tabs",
                  tabPanel("Introduction", textOutput("intro")),
                  tabPanel("Map",leafletOutput("mymap")),
                  tabPanel("Factors", plotOutput("distPlot")),
                  tabPanel("Table", imageOutput("table"),  textOutput("description"))
      )
      ),
    sidebarPanel(
      sliderInput("sliderTime", label = h3("Time (Year)"), min = 2012, 
                  max = 2018, value = c(2014, 2016), round = -1, step = 0.5,
                  sep = ""
      ),
      selectInput("selectCrime", h3("Type of Crime"),
                  c("Burglary" = "bur",
                    "Robbery" = "rob",
                    "Assault" = "ass",
                    "Vehicle Theft" = "vt",
                    "Threats" = "thr",
                    "Homicide" = "hom")
      ),
      selectInput("select", label = h3("Select Factor"), 
                  choices = list("Unemployment Rate" = 1, "Average Rent" = 2, "Cocaine 
                                 Arrests" = 3, "Consumer Index Price of Food" = 4), 
                  selected = 1),
      
      textOutput("variables")
    )
  )
)

shinyUI(my.ui)
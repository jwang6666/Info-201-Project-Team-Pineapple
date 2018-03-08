#install.packages("shiny")
#install.packages("dplyr")
#install.packages("leaflet")
#install.packages("rsconnect")
#install.packages("ggplot2")
#install.packages("scales")
#install.packages("shinythemes")
library("shiny")
library("dplyr")
library("leaflet")
library("rsconnect")
library("ggplot2")
library("scales")
library("markdown")
library("shinythemes")

my.ui <- navbarPage(
  "Factors Correlated to Violent Crimes in Seattle",
  theme = shinytheme("darkly"),
  
  tabPanel("Introduction",
             includeMarkdown("introduction.md")
  ),
  
  tabPanel("Map",
      
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
             )
           ),
      mainPanel(
        leafletOutput("mymap")
      )
      
  ),
  
  tabPanel("Correlated Factors",
           sidebarPanel(
             selectInput("select", label = h3("Select Factor"), 
                         choices = list("Unemployment Rate" = 1, "Average Rent" = 2, "Cocaine 
                                        Arrests" = 3, "Consumer Index Price of Food" = 4), 
                         selected = 1),
             
             textOutput("variables")
           ),
           
           mainPanel(plotOutput("distPlot")),
           textOutput("graph_description")
  ),
  
  tabPanel("Regression Table",

             imageOutput("table"),  
             textOutput("description")
           
  )

)

shinyUI(my.ui)

#Read in one of the csv file
crime_data <- read.csv("Data/2012_2017mViolent_Crimes.csv", stringsAsFactors=FALSE)

#Needed the "Occurred.Date.or.Date.Range.Start" column of crime_data to sort the data by time. 
#However, the data wasn't in "Date" data type, instead it was "character" data type.
#So, I changed it to "Date" data type. In turn, it allowed me to sort the data by time.
crime_data[, "Occurred.Date.or.Date.Range.Start"] <- as.Date(crime_data[, "Occurred.Date.or.Date.Range.Start"], "%m/%d/%Y")

my.server <- function(input, output) {
  #fully filtered crime_data is put into data
  data <- reactive({
    #figures out users preferred type of crime, and filters out that crime in crime_Data
    if(input$selectCrime == "bur") {
      crime_data <- filter(crime_data, Summarized.Offense.Description == "BURGLARY")
    } else if(input$selectCrime == "rob") {
      crime_data <- filter(crime_data, Summarized.Offense.Description == "ROBBERY")
    } else if(input$selectCrime == "ass") {
      crime_data <- filter(crime_data, Summarized.Offense.Description == "ASSAULT")
    } else if(input$selectCrime == "vt") {
      crime_data <- filter(crime_data, Summarized.Offense.Description == "VEHICLE THEFT")
    } else if(input$selectCrime == "thr") {
      crime_data <- filter(crime_data, Summarized.Offense.Description == "THREATS")
    } else {
      crime_data <- filter(crime_data, Summarized.Offense.Description == "HOMICIDE")
    }
    #changes "numerical" data type of input$sliderTime into "Date" data type for later filtering.
    first_value_input <- input$sliderTime[1]
    second_value_input <- input$sliderTime[2]
    if(first_value_input %% 1 == 0) {
      first_value_input <- paste0(first_value_input, "-01-01")
    } else {
      first_value_input <- round(first_value_input - 0.1)
      first_value_input <- paste0(first_value_input, "-07-02")
    }
    if(second_value_input %% 1 == 0) {
      second_value_input <- paste0(second_value_input, "-01-01")
    } else {
      second_value_input <- round(second_value_input - 0.1)
      second_value_input <- paste0(second_value_input, "-07-02")
    }
    first_value_input <- as.Date(first_value_input)
    second_value_input <- as.Date(second_value_input)
    #filters out the time within the range of time selected by the user
    crime_data <- filter(crime_data, Occurred.Date.or.Date.Range.Start >= first_value_input,
                         Occurred.Date.or.Date.Range.Start <= second_value_input)
    #returns the fully filtered out crime data to "data"
    return(crime_data)
  })
  
  #uses the filtered out crime data named "data()" to make a map
  #dont be surprised that "data" has brackets beside it like a function. Apparently, it's some weird syntax thing.
  #so "data()" is the same as "data" as mentioned above.
  output$mymap <- renderLeaflet({
    leaflet(quakes) %>% addTiles() %>%
      fitBounds(~min(-122.31), ~min(47.62), ~max(-122.29), ~max(47.65)) %>% 
      addMarkers(data()[, "Longitude"], data()[, "Latitude"], clusterOptions = markerClusterOptions())
  })
}

shinyServer(my.server)
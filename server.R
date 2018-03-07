crime_data <- read.csv("Data/2012_2017mViolent_Crimes.csv", stringsAsFactors=FALSE)
crime_data[, "Occurred.Date.or.Date.Range.Start"] <- as.Date(crime_data[, "Occurred.Date.or.Date.Range.Start"], "%m/%d/%Y")
crime_data2 <- read.csv('Data/violent_crimes.csv', stringsAsFactors = FALSE)
my.server <- function(input, output) {
  
  ## THIS IS MAP
  data <- reactive({
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
    crime_data <- filter(crime_data, Occurred.Date.or.Date.Range.Start >= first_value_input,
                         Occurred.Date.or.Date.Range.Start <= second_value_input)
    return(crime_data)
  })

  output$mymap <- renderLeaflet({
    leaflet(quakes) %>% addTiles() %>%
      fitBounds(~min(-122.31), ~min(47.62), ~max(-122.29), ~max(47.65)) %>% 
      addMarkers(data()[, "Longitude"], data()[, "Latitude"], clusterOptions = markerClusterOptions())
  })

  
  
  ##THIS IS CORRELATED FACTORS 
  output$distPlot <- renderPlot({
    
    if (input$select == 1){
      ggplot(data=crime_data2) +
        geom_point(mapping = aes(x = crime_data2$unemployment, y = crime_data2$violent_crimes)) +
        labs(x= "Unemployment Rate", y="Violent Crimes") 
    } else if (input$select == 2) {
      ggplot(data=crime_data2) +
        geom_point(mapping = aes(x = crime_data2$rents, y = crime_data2$violent_crimes)) +
        labs(x= "Average Rent", y="Violent Crimes") +
        scale_x_continuous(labels = dollar)
    } else if (input$select == 3) {
      ggplot(data=crime_data2) +
        geom_point(mapping = aes(x = crime_data2$cocaine_arrests, y = crime_data2$violent_crimes)) +
        labs(x= "Cocaine Arrests", y="Violent Crimes")      
    }else {
      ggplot(data=crime_data2) +
        geom_point(mapping = aes(x = crime_data2$food_index, y = crime_data2$violent_crimes)) +
        labs(x= "Consumer Price Index of Food", y="Violent Crimes")
    }
  })
  
  ##THIS IS DESCRIPTION UNDER REGRESSION TABLE
  output$description <-renderText("We ran a regression on four monthly variables including, unemployment,
                                  average rent, cocaine arrests, and consumer price index on food to determine their 
                                  correlations on violent crimes.")
  
  
  ##THIS IS EXPLANATION UNDER WIDGETS
  output$variables <- renderText({
    if(input$select == 1){"Violent crimes in Seattle increase by 11.78 when unemployment
      rate increase by 1%"
    } else if(input$select == 2) {
      "Violent crimes in Seattle increase by 0.20 when average rent
      increase by $1"
    } else if(input$select == 3) {
      "Violent crimes in Seattle decrease by 0.75 when the number of 
      cocaine arrests increase by $1"
    } else {
      "Violent crimes in Seattle decrease by 3.13 when Consumer Price
      Index of Food increase by 1"
    }
    })
  
  ##THIS IS STATISTICS TABLE
  output$table <- renderImage({
    filename = normalizePath("./data/regression_table.png")
    #~/Desktop/INFO 201/Info201-Project-Team-Pineapple/regression_table.png
    list(src = filename)
  }, deleteFile = FALSE)
   
  }

shinyServer(my.server)


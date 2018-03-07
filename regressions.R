library(dplyr)
library(lubridate)
library(ggplot2)
library(scales)
library(MASS)
set.seed(2018)
options(digits=4)

crime_data <- read.csv('~/Desktop/ECON 483/data/violent_crimes.csv', stringsAsFactors = FALSE)
cocain_data <- read.csv('~/Desktop/ECON 483/data/2008_2017_cocaine_arrests.csv', stringsAsFactors = FALSE)


#extracting the sum of cocain arrests per month after 2012
cocain_data$Date.Reported <- as.Date(cocain_data$Date.Reported, "%m/%d/%Y")
monthly_cocain_arrests <- cocain_data %>%
                            mutate(month = format(Date.Reported, "%m"), year = format(Date.Reported, "%Y")) %>%
                            group_by(month, year) %>%
                            filter(year >= 2012) %>%
                            count() %>%
                            arrange(by = year)'

'

#regressions by month and year
crime_data <- na.omit(crime_data)       
crime_month <- lm(violent_crimes ~  unemployment + rents + cocaine_arrests + food_index, data = crime_data)

crime_year <- lm(violent_crimes ~  unemployment + homeless_population + rents + cocaine_arrests + poverty_population 
                            + median_household_income + graduation + seattle_population, data = crime_data)
#dropping homeless variable
crime_year_drop <- lm(violent_crimes ~  unemployment + rents + cocaine_arrests + food_index + poverty_population 
                            + median_household_income + graduation + seattle_population, data = crime_data)
#yearly crime regression with log
crime_year_log <- lm(violent_crimes ~  unemployment + rents + cocaine_arrests + log10(poverty_population)
                            + log10(median_household_income) + graduation + log10(seattle_population) + log10(homeless_population), data = crime_data)

#robust tests
robust_crime_month <- rlm(violent_crimes ~  unemployment + rents + cocaine_arrests + food_index, data = crime_data)
robust_crime_year <- rlm(violent_crimes ~  unemployment + rents + cocaine_arrests + food_index + poverty_population 
                                    + median_household_income + seattle_population + graduation, data = crime_data)
# scatter graph 
rents_scatter_graph <- ggplot(data=crime_data) +
                      geom_point(mapping = aes(x = crime_data$rents, y = crime_data$violent_crimes)) +
                      labs(x="Rents", y="Violent Crimes") +
                      scale_x_continuous(labels = dollar)

food_scatter_graph <- ggplot(data=crime_data) +
                        geom_point(mapping = aes(x = crime_data$food_index, y = crime_data$violent_crimes)) +
                        labs(x="Food Index", y="Violent Crimes")





# Checking correlation for rents and homeless population
rents_homeless <-  lm(homeless_population ~ rents, data = crime_data)


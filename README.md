# Info-201-Project-Team-Pineapple
Project Name: **Factors Correlated to Violent Crimes in Seattle**

Group Members: Chihyun, Patrick, Jiahui, Akhila

Shinyapps.io Link: 

## What Does Our Web Application Do?
Our Project aims to provide a 



Our input includes three parts:
1. A slider bar that let users choose time range between 2012 to 2018.
1. A select box that let users choose type of crime they are interested in.
1. Another select box that let users choose what factors they want to look in that influences violent crimes. 

Our output includes four parts:
1. A  brief description that introduces what our application do and how to use it.
1. A map that responses to the first and the second input, shows locations of a specific type of violent crime happened in a specific period of time. Also, this map is adjustable, which can show users the distribution of violent crimes macroscopically in Seattle as well as the location of every crime details to blocks.
1. A scattergraph that responses to the third input, shows the correlation between a specific factor and violent crimes. 
1. A regression table with statistic data of how the four factors are correlated to violent crimes in Seattle.

Four outputs are orgainzed by a tabset panel, which provides a neat user interface for our audience. 

## Where Did Our Data From?

Our team gathered data from various sources:
1. Violent crimes, crime location, and illegal drug arrests were gathered from the [Seattle Police Department website](https://www.seattle.gov/police/information-and-data)
1. unemployment rate, Seattle population, homeless population, high school graduation rate, and median household income were collected from [US census bureau](https://www.census.gov/data.html), [Seattle Government website](http://www.seattle.gov/services-and-information), and [Talkpoverty.org](https://talkpoverty.org/state-year-report/washington-2017-report/)

We merged data from various sources into two `.csv` tables: 
1. `2012_2017mViolent_Crimes.csv` which contains information such as crime types, crime locations(longitude and latitude) and crime times
1. `violent_crimes.csv` which contains information such as unemployment rates, rents, cocaine arrests, food index, and orgainzed by months.


## Who is our Targeted User?

## Our Code


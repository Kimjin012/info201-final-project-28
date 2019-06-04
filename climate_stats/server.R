#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(R.utils)

# Define server logic
shinyServer(function(input, output) {
  
  # Data set of average atmoshpiric C02 levels, collected by NOAA.
  global_c02 <- read.csv(file = "../data/record_globe.csv", stringsAsFactors = FALSE, sep = ",")
  # Data set of atmoshperic C02 emmisions from various sources, collected by NOAA.
  global_c02_types <- read.csv(file = "../data/global.1751_2014.csv", stringsAsFactors = FALSE, sep = ",")
  
  output$message <- reactive({
    paste(input$range[1])
  })
  
  # Render the plot of C02 based on input source.
  output$c02_types <- renderPlot({
    global_c02_types %>% filter(Year >= input$range[1], Year <= input$range[2]) %>%  ggplot() +
      geom_line(aes(x = Year, y = Total, color = "Total")) +
      geom_line(aes(x = Year, y = Gas_Fuel, color = "Gas Fuel")) +
      geom_line(aes(x = Year, y = Liquid_Fuel, color = "Liquid Fuel")) +
      geom_line(aes(x = Year, y = Solid_Fuel, color = "Solid Fuel")) +
      geom_line(aes(x = Year, y = Cement_Production, color = "Cement Production")) +
      geom_line(aes(x = Year, y = Gas_Flairing, color = "Gas Flaring")) +
      geom_line(aes(x = Year, y = Per_Capita, color = "Per Capita (metric tons)")) +
      ggtitle(paste("Atmospheric C02 Levels")) +
      xlab("Year") + 
      ylab("Million Metric Tons of Atmoshperici C02")
  })
  
  # Render the plot of average atmosheric C02 levels.
  output$c02_plot <- renderPlot({
    global_c02 %>% filter(average >= 0) %>% filter(year >= input$range[1], year <= input$range[2]) %>% ggplot() + #Removes negative values, which represent missing data.
      geom_line(aes(x = decimal, y = average, color = "C02")) +
      geom_line(aes(x = decimal, y = trend, color = "Trend")) +
      ggtitle("Average Atmoshperic C02 Levels") +
      xlab("Year") + 
      ylab("C02 parts per Million")
  })
  
})

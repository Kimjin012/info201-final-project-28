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
  global_c02 <- read.csv(file = "data/record_globe.csv", stringsAsFactors = FALSE, sep = ",")
  # Data set of atmoshperic C02 emmisions from various sources, collected by NOAA.
  global_c02_types <- read.csv(file = "data/global.1751_2014.csv", stringsAsFactors = FALSE, sep = ",")
  
  output$message <- reactive({
    paste(input$range[2])
  })
  
  # Render the plot of C02 based on input source.
  output$c02_types <- renderPlot({
    c02_types <- global_c02_types %>% filter(Year >= input$range[1], Year <= input$range[2])
    #if(1 %in% input$co_2_type) {
     # global_c02_types <- 
    #}
    #for(column_name in input$co_2_type) {
    #  global_c02_types <- select(global_c02_types, -c(UQ(column_name)))
    #}
    c02_types <- select(c02_types, Year, Total, Per_Capita, UQ(input$co_2_type))
      temp <- ggplot(c02_types)
      temp <- temp + geom_line(aes(x = Year, y = Total, color = "Total"))
      if("Gas_Fuel" %in% colnames(c02_types))  {
        temp <- temp + geom_line(aes(x = Year, y = Gas_Fuel, color = "Gas Fuel"))
      }
      if("Liquid_Fuel" %in% colnames(c02_types))  {
        temp <- temp + geom_line(aes(x = Year, y = Liquid_Fuel, color = "Liquid Fuel")) 
      }
      if("Solid_Fuel" %in% colnames(c02_types))  {
        temp <- temp + geom_line(aes(x = Year, y = Solid_Fuel, color = "Solid Fuel")) 
      }
      if("Cement_Production" %in% colnames(c02_types))  {
        temp <- temp + geom_line(aes(x = Year, y = Cement_Production, color = "Cement Production")) 
      }
      if("Gas_Flairing" %in% colnames(c02_types))  {
        temp <- temp + geom_line(aes(x = Year, y = Gas_Flairing, color = "Gas Flairing")) 
      }
      temp <- temp +
      geom_line(aes(x = Year, y = Per_Capita, color = "Per Capita (metric tons)")) +
      ggtitle(paste("Atmospheric C02 Levels")) +
      xlab("Year") + 
      ylab("Million Metric Tons of Atmoshperici C02")
      return(temp)
  })
  
  # Render the plot of average atmosheric C02 levels.
  output$c02_plot <- renderPlot({
    temp2 <- global_c02 %>% filter(average >= 0) %>% filter(year >= input$global_range[1], year <= input$global_range[2])
    result <-  ggplot(temp2) + #Removes negative values, which represent missing data.
      geom_line(aes(x = decimal, y = average, color = "C02")) +
      geom_line(aes(x = decimal, y = trend, color = "Trend")) +
      ggtitle("Average Atmoshperic C02 Levels") +
      xlab("Year") + 
      ylab("C02 parts per Million")
    return(result)
  })
  
  
})

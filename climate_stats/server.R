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

data <- read.csv(file = "../record_globe.csv", stringsAsFactors = FALSE, sep = ",")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$c02_plot <- renderPlot({
    data %>% filter(average >= 0) %>% ggplot() +
      geom_line(aes(x = decimal, y = average)) +
      xlab("Year") + 
      ylab("C02 parts per Million")
  })
  
})

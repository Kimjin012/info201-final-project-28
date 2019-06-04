#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(R.utils)

c02_types <- read.csv(file = "../data/global.1751_2014.csv", stringsAsFactors = FALSE, sep = ",")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Title here"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      # User Input for slelecting a Atmosphiric C02 Emmision Type
      selectInput("select", label = h3("Select Emmision Type"), 
                  choices = colnames(c02_types)[-1], 
                  selected = 1)
    ), 
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("c02_types"),
      plotOutput("c02_plot")
    )
  )
))

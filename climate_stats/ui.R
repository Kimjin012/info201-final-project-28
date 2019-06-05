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

c02_types <- read.csv(file = "data/global.1751_2014.csv", stringsAsFactors = FALSE, sep = ",")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Global Carbon Dioxide Atmopsheric Levels"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      # User Input for slelecting a Atmosphiric C02 Emmision Type
      sliderInput("range", label = h3("Years Range for Carbon Dioxide Type Emissions"), min = 1751, 
                  max = 2019, value = c(1751,2019)),
      sliderInput("global_range", label = h3("Years Range for Global Emissions"), min = 1980, 
                  max = 2018, value = c(1980,2018)),
      checkboxGroupInput("co_2_type",
                    "Show CO2 emission sources",
                    choices = list ("Gas Fuel" = "Gas_Fuel",
                                    "Liquid Fuel" = "Liquid_Fuel",
                                    "Solid Fuel" = "Solid_Fuel",
                                    "Cement Production" = "Cement_Production",
                                    "Gas Flairing" = "Gas_Flairing"),
                    selected = c("Gas_Fuel", "Liquid_Fuel", "Solid_Fuel", "Cement_Production","Gas_Flairing"))
    ), 
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("c02_types"),
      plotOutput("c02_plot")
    )
  )
))

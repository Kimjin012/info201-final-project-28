
library(shiny)
library(ggplot2)
library(dplyr)
library(R.utils)
library(tidyr)


global_c02 <- read.csv(file = "data/record_globe.csv", stringsAsFactors = FALSE, sep = ",")
# Data set of atmoshperic C02 emmisions from various sources, collected by NOAA.
global_c02_types <- read.csv(file = "data/global.1751_2014.csv", stringsAsFactors = FALSE, sep = ",")

temp_1 <- global_c02 %>% filter(average >= 0) %>% 
  ggplot() + #Removes negative values, which represent missing data.
  geom_line(aes(x = decimal, y = average, color = "C02")) +
  geom_line(aes(x = decimal, y = trend, color = "Trend")) +
  ggtitle("Average Atmoshperic C02 Levels") +
  xlab("Year") + 
  ylab("C02 parts per Million")

temp <- ggplot(global_c02_types)+
  geom_line(aes(x = Year, y = Total, color = "Total"))+
  geom_line(aes(x = Year, y = Gas_Fuel, color = "Gas Fuel")) +
  geom_line(aes(x = Year, y = Liquid_Fuel, color = "Liquid Fuel")) +
  geom_line(aes(x = Year, y = Solid_Fuel, color = "Solid Fuel")) +
  geom_line(aes(x = Year, y = Cement_Production, color = "Cement Production")) +
  geom_line(aes(x = Year, y = Gas_Flairing, color = "Gas Flairing"))  +
  geom_line(aes(x = Year, y = Per_Capita, color = "Per Capita (metric tons)")) +
  ggtitle(paste("Atmospheric C02 Levels")) +
  xlab("Year") + 
  ylab("Million Metric Tons of Atmoshperici C02")


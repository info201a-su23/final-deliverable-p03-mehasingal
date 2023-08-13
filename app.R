library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(lubridate)
library(tidyr)


# Load the UI and server components from separate files
source("ui.r")
source("server.r")

# Run the app
shinyApp(ui, server)

# Generates URL for shiny.io web page, run this after each change to update link

# install.packages("rsconnect")
library(rsconnect)
rsconnect::deployApp(appDir = "~/Desktop/INFO/info201/code/shiny-practice-mehasingal")




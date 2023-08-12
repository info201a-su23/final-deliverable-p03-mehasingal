library(shiny)
library(dplyr)
library(plotly)


# Load the UI and server components from separate files
source("ui.r")
source("server.r")

# Run the app
shinyApp(ui, server)

# Generates URL for shiny.io web page, run this after each change to update link

# install.packages("rsconnect")
library(rsconnect)
rsconnect::deployApp(appDir = "~/Desktop/INFO/info201/code/shiny-practice-mehasingal")
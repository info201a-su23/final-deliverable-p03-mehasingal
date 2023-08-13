library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(lubridate)
library(tidyr)
library(rsconnect)


# Load the UI and server components from separate files
source("ui.r")
source("server.r")

# Run the app
shinyApp(ui, server)

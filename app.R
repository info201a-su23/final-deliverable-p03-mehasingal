library(shiny)
library(ggplot2)
library(dplyr)
library(tidyr)
library(plotly)

data <- read.csv("maryland_crash_report.csv")
data$Crash.Date.Time <- as.POSIXct(data$Crash.Date.Time, format = "%m/%d/%Y %I:%M:%S %p")
data$Year <- format(data$Crash.Date.Time, "%Y")
data$Year <- as.numeric(data$Year)

ui <- fluidPage(
  titlePanel("Collision Types in Maryland from 2015-2023"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("year",
                  "Select Years:",
                  min = min(data$Year),
                  max = max(data$Year),
                  value = c(min(data$Year), max(data$Year))),  # Ensure the value is within min and max
      hr(),
      fluidRow(column(7, verbatimTextOutput("range")))
      
    ),
    
    mainPanel(
      plotlyOutput("collision_bargraph")
      
    )
  )
)

server <- function(input, output) {
  filtered_data <- data %>% 
    select(Collision.Type, Year)
  
  output$collision_bargraph <- renderPlotly({
    filtered_years <- input$year[1]:input$year[2]
    filtered_data_year <- filtered_data %>% filter(Year %in% filtered_years)
    
    collision_occurance <- table(filtered_data_year$Collision.Type)
    collision_occurance_df <- as.data.frame(collision_occurance)
    colnames(collision_occurance_df) <- c("Collision Type", "Count")
    
    collision_graph <- ggplot(collision_occurance_df, aes(x = `Collision Type`, y = Count)) +
      geom_bar(stat = "identity", fill = "purple") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      labs(title = "Total Occurrence of Collision Types", x = "Collision Type", y = "Count")
    
    ggplotly(collision_graph)
  })
  
  output$range <- renderPrint({ input$year })
}

shinyApp(ui, server)
library(shiny)
library(ggplot2)
library(dplyr)
library(tidyr)
library(plotly)

data <- read.csv("maryland_crash_report.csv")

ui <- fluidPage(
  titlePanel("Collision Types in Maryland from 2015-2023"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("year",
                  "Select Years:",
                  min = min(data$year),
                  max = max(data$year),
                  value = c(2015, 2020)),
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
    select(Collision.Type)
  
  collision_occurance <- table(data$Collision.Type)
  collision_occurance_df <- as.data.frame(collision_occurance)
  colnames(collision_occurance_df) <- c("Collision Type", "Count")
  
  output$collision_bargraph <- renderPlotly({
    collision_graph <- ggplot(collision_occurance_df, aes(x = `Collision Type`, y = Count)) +
      geom_bar(stat = "identity", fill = "purple") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      labs(title = "Total Occurrence of Collision Types in Maryland from 2015-2023", x = "Collision Type", y = "Count")
    
    ggplotly(collision_graph)
  })
  
  output$range <- renderPrint({ input$year })
}

shinyApp(ui, server)





library(shiny)
library(ggplot2)
library(dplyr)
library(tidyr)
library(plotly)
library(lubridate)

data <- read.csv("https://data.montgomerycountymd.gov/api/views/mmzv-x632/rows.csv?accessType=DOWNLOAD")
data$Date <- as.POSIXct(data$Date, format = "%m/%d/%Y %I:%M:%S %p")
data$Year <- year(data$Date)

ui <- fluidPage(
  titlePanel("Collision Types in Maryland from 2015-2023"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("yearRange",
                  "Select Years:",
                  min = min(data$Year),
                  max = max(data$Year),
                  value = c(2015, 2020)),
      hr(),
      fluidRow(column(7, verbatimTextOutput("range")))
    ),
    mainPanel(
      plotlyOutput("collision_bargraph")
    )
  )
)

server <- function(input, output) {
  filtered_data <- reactive({
    data %>%
      filter(Year >= input$yearRange[1], Year <= input$yearRange[2])
  })
  
  output$collision_bargraph <- renderPlotly({
    collision_occurance <- table(filtered_data()$Collision.Type)
    collision_occurance_df <- as.data.frame(collision_occurance)
    colnames(collision_occurance_df) <- c("Collision Type", "Count")
    
    collision_graph <- ggplot(collision_occurance_df, aes(x = `Collision Type`, y = Count)) +
      geom_bar(stat = "identity", fill = "purple") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      labs(title = "Total Occurrence of Collision Types", x = "Collision Type", y = "Count")
    
    ggplotly(collision_graph)
  })
  
  output$range <- renderPrint({
    input$yearRange
  })
}

shinyApp(ui, server)

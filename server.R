library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(lubridate)
library(tidyr)

data <- read.csv("maryland_crash_report.csv")
data <- data %>%
  mutate(Year = year(as.POSIXct(Crash.Date.Time, format = "%m/%d/%Y %I:%M:%S %p")))

# Define server logic
server <- function(input, output) {
  
  # Jessica's graph code
  #filtered_data <- reactive({
    #data %>%
      #filter(Year >= input$yearRange[1], Year <= input$yearRange[2])
  #})
  
  output$collision_bargraph <- renderPlotly({
    
    collision_occurance <- table(data$Collision.Type)
    collision_occurance_df <- as.data.frame(collision_occurance)
    colnames(collision_occurance_df) <- c("Collision Type", "Count")
    
    collision_graph <- ggplot(collision_occurance_df, aes(x = `Collision Type`, y = Count)) +
      geom_bar(stat = "identity", fill = "purple") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      labs(title = "Total Occurrence of Collision Types", x = "Collision Type", y = "Count")
    
    ggplotly(collision_graph)
  })
  
  # Meha's graph code
  output$interactive_plot <- renderPlotly({
    filtered_crashes <- data %>%
      filter(Driver.Substance.Abuse == "ALCOHOL CONTRIBUTED")
    
    count_data <- filtered_crashes %>%
      group_by(Year) %>%
      summarise(Count = n())
    
    crash_graph <- ggplot(count_data, aes(x = Year, y = Count)) +
      geom_bar(stat = "identity", fill = "blue", color = "blue") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      labs(title = "Number of Alcohol-Related Vehicle Crashes Over Time in Maryland",
           x = "Year", y = "Number of Crashes")
    
    ggplotly(crash_graph)
  })
  
  # Chufeng's graph code 
  output$injury_plot <- renderPlotly({
    top_makes <- data %>%
      count(Vehicle.Make) %>%
      arrange(desc(n)) %>%
      head(10) %>%
      pull(Vehicle.Make)
    
    filtered_data <- data %>%
      filter(Vehicle.Make %in% top_makes)
    
    # Use selectInput widget to allow users to choose Injury Severity
    selected_severity <- input$severity_choice
    
    summary_data <- filtered_data %>%
      group_by(Vehicle.Make, Injury.Severity) %>%
      summarise(Count = n()) %>%
      ungroup() %>%
      filter(Injury.Severity == selected_severity)
    
    summary_data$Injury.Severity <- as.factor(summary_data$Injury.Severity)
    
    vehicle_injury_scatterplot <- ggplot(summary_data, aes(x = Vehicle.Make, y = Count, color = Injury.Severity)) +
      geom_point() +
      labs(title = "Relationship between Vehicle Make and Injury Severity",
           x = "Top 10 Vehicle Make",
           y = "Count") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
    ggplotly(vehicle_injury_scatterplot)
  })
  
  # Define a selectInput widget for choosing Injury Severity
  output$severity_input <- renderUI({
    severity_choices <- unique(data$Injury.Severity)
    selectInput("severity_choice", "Select Injury Severity", severity_choices)
  })
  
}

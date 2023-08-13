
# install.packages("plotly")
library(dplyr)
library(plotly)

data <- read.csv("maryland_crash_report.csv")

# Define server logic
server <- function(input, output) {
  
  # Sunwoo's code
  
  
  
  
  
  
  # Jessica's graph code
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
  
  # Meha's graph code
  
  output$interactive_plot <- renderPlotly({
    filtered_crashes <- filtered_data() %>%
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
  
  output$range <- renderPrint({
    input$yearRange
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
  
    summary_data <- filtered_data %>%
      group_by(Vehicle.Make, Injury.Severity) %>%
      summarise(Count = n()) %>%
      ungroup()
  
    summary_data$Injury.Severity <- as.factor(summary_data$Injury.Severity)
  
    vehicle_injury_scatterplot <- ggplot(filtered_data, aes(x = Vehicle.Make, y = Injury.Severity)) +
      geom_jitter(aes(color = Vehicle.Make), alpha = 0.4, width = 0.1) +
      labs(title = "Relationship between Vehicle Make and Injury Severity",
            x = "Top 10 Vehicle Make",
            y = "Injury Severity") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  
    print(vehicle_injury_scatterplot)
  })
}



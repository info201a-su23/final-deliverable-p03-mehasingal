library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(lubridate)
library(tidyr)
library(rsconnect)
library(shinythemes)


data <- read.csv("maryland_crash_report.csv")

data <- data %>%
  mutate(Year = year(as.POSIXct(Crash.Date.Time, format = "%m/%d/%Y %I:%M:%S %p")))

# Define server logic
server <- function(input, output) {
  
  # Jessica's graph code
  
  filtered_data <- reactive({
    data %>%
      filter(Year >= input$yearRange[1], Year <= input$yearRange[2])
  })
  
  output$collision_bargraph <- renderPlotly({
    # Use the filtered_data reactive expression to get the filtered data
    filtered_crashes <- filtered_data()
    
    # Calculate collision occurrence based on the filtered data
    collision_occurance <- table(filtered_crashes$Collision.Type)
    collision_occurance_df <- as.data.frame(collision_occurance)
    colnames(collision_occurance_df) <- c("Collision Type", "Count")
    
    # Get the selected number of top collision types
    selected_num_top <- input$numTop
  
    if (selected_num_top == "All") {
      sorted_collision_occurance_df <- collision_occurance_df
      plot_title <- "All Collision Types"
    } else {
      # Sort the collision types by count and select the top N
      sorted_collision_occurance_df <- collision_occurance_df %>%
        arrange(desc(Count)) %>%
        head(as.numeric(selected_num_top))
      plot_title <- paste("Top", selected_num_top, "Occurrences of Collision Types")
    }
    
    # Create the collision graph using ggplot2
    collision_graph <- ggplot(sorted_collision_occurance_df, aes(x = reorder(`Collision Type`, Count), y = Count)) +
      geom_bar(stat = "identity", fill = "purple") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      labs(title = plot_title, x = "Collision Type", y = "Count")
    
    # Convert ggplot to Plotly
    ggplotly(collision_graph)
  })
  
  
  # Meha's graph code
  
  output$interactive_plot <- renderPlotly({
    
    data$Crash.Date.Time <- as.Date(data$Crash.Date.Time, format = "%m/%d/%Y")
    
    filtered <- data %>%
      select(Crash.Date.Time, Driver.Substance.Abuse)
    
    # filter data for only alcohol contributed crashes
    alcohol_contributed_data <- filtered %>%
      filter(Driver.Substance.Abuse == "ALCOHOL CONTRIBUTED")
    
    # summarize the data by date to get counts
    count_data <- alcohol_contributed_data %>%
      group_by(Crash.Date.Time) %>%
      summarise(Count = n())
    
    # Check if input$selected_month exists and is not NULL
    if (!is.null(input$selected_month) && input$selected_month != "All Months") {
      selected_month <- input$selected_month
      
      count_data <- count_data %>%
        filter(format(Crash.Date.Time, "%B") == selected_month)  # Use the original column name
   }
    
    # Set the plot title
   plot_title <- ifelse(is.null(input$selected_month) || input$selected_month == "All Months",
                         "Number of Alcohol-Related Vehicle Crashes Over Time",
                         paste("Number of Alcohol-Related Vehicle Crashes in", input$selected_month))
    
    # Create the interactive bar plot
    alcohol_related_accidents_overtime <- ggplot(count_data, aes(x = Crash.Date.Time, y = Count)) +
      geom_bar(stat = "identity", fill = "blue", color = "blue") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      labs(title = plot_title, x = "Date", y = "Number of Crashes")
   
   #alcohol_related_accidents_overtime <- ggplot(count_data, aes(x = Crash.Date.Time, y = Count)) +
    # geom_line(color = "blue") +
     #theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    # labs(title = plot_title, x = "Date", y = "Number of Crashes")
    
    ggplotly(alcohol_related_accidents_overtime)
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
    
    
    # Convert ggplot to Plotly
    ggplotly(vehicle_injury_scatterplot)
  })
  
  
  # Define a selectInput widget for choosing Injury Severity
  output$severity_input <- renderUI({
    severity_choices <- unique(data$Injury.Severity)
    selectInput("severity_choice", "Select Injury Severity", severity_choices)
  })
  
}

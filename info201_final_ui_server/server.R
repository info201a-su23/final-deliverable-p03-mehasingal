<<<<<<< HEAD
# install.packages("plotly")
library(dplyr)
library(plotly)

data <- read.csv("maryland_crash_report.csv")

# Define server logic
server <- function(input, output) {
  
  # Sunwoo's code
  
  
  
  
  
  
  # Jessica's graph code
  filtered_data <- data %>%
    select(Collision.Type)
  
  collision_occurance <- table(data$Collision.Type)
  collision_occurance_df <- as.data.frame(collision_occurance)
  colnames(collision_occurance_df) <- c("Collision Type", "Count")
  
  output$collision_plot <- renderPlotly({
    p <- ggplot(collision_occurance_df, aes(x = `Collision Type`, y = Count)) +
      geom_bar(stat = "identity", fill = "purple") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      labs(title = "Total Occurrence of Collision Types in Maryland from 2015-2023", x = "Collision Type", y = "Count")
    
    ggplotly(p)
  })
  
  # Meha's graph code
  
  
  
  # Chufeng's graph code
  
  
  
  
}
=======
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
>>>>>>> f9eaa9d4584106fb72d90a73e7763fa770113fab

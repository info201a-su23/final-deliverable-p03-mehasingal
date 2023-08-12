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
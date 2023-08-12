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

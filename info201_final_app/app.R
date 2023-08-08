library(shiny)
library(dplyr)
library(tidyr)
library(plotly)

data <- read.csv("maryland_crash_report.csv")

ui <- fluidPage(
  titlePanel("Collision Types in Maryland from 2015-2023"),
  sidebarLayout(
    sidebarPanel(),
    mainPanel(
      plotlyOutput("collision_plot")
    )
  )
)

server <- function(input, output) {
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
}

shinyApp(ui, server)
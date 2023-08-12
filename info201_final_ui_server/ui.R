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
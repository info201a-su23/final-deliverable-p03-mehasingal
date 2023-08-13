library(ggplot2)
library(shiny)
library(shinydashboard)
library(plotly)
library(shinythemes)
library(dplyr)
library(lubridate)
library(tidyr)

ui <- fluidPage(
  
  theme = shinytheme("cosmo"),
  
  h1("Analysis of Vehicle Collisions in Maryland"),
  
  navbarPage(
    title = "INFO 201 Final Project",
    id = "navtabs",
    
    # Introduction tab
    tabPanel("Introduction",
             h1("Project Overview"),
             p("Welcome to our data exploration project."),
             p("We will be analyzing XYZ data to answer questions related to ABC."),
             p("The data was sourced from [Data Source](link_to_data_source).")
    ),
    
    # Collision Types tab
    tabPanel("Collision Types",
             h1("Vehicle Collision Types from 2015-2023"),
             
             # Sidebar with sliding range and top N selection widgets
             sidebarLayout(
               sidebarPanel(
                 sliderInput("yearRange",
                              "Select Years:",
                              min = min(data$Year),
                              max = max(data$Year),
                              value = c(2015, 2020),
                              step = 1),
                 selectInput("numTop", "Top N Collision Types:", choices = c("All", 5, 10, 15), selected = "All")
               ),
               mainPanel(
                 plotlyOutput("collision_bargraph")
               )
             )
    ),
    
    # Alcohol-Related Crashes tab
    tabPanel("Alcohol-Related Crashes",
             h1("Alcohol-Related Vehicle Crashes Over Time"),
             
             # Sidebar with a select input widget
             sidebarLayout(
               sidebarPanel(
                 selectInput("selected_month", "Select Month:", 
                             choices = c("All Months", month.name))
               ),
               # Main panel with the interactive plot
               mainPanel(
                 plotlyOutput("interactive_plot")
               )
             )
    ),
    
    # Vehicle Make and Model tab
    tabPanel("Vehicle Make and Model",
             h1("Relationship between Top 10 Vehicle Makes and Injury Severity"),
             mainPanel(
               plotlyOutput("injury_plot")
             ),
             uiOutput("severity_input")
    ),
    
    # Conclusions tab
    tabPanel("Conclusions",
             h1("Project Conclusions"),
             p("In summary, our analysis revealed the following major takeaways:"),
             # Add text and other elements to present your conclusions
             # ...
    )
  )
)

library(shiny)
library(shinydashboard)
library(plotly)
library(dplyr)

ui <- fluidPage(
  
  tags$head(
    tags$link(rel = "stylesheet", href = "styles.css")
    
  ),
  
  h1("Analysis of Vehicle Collisions in Maryland"),
  
  navbarPage(
    title = "INFO 201 Final Project",
    id = "navtabs",
    tabPanel("Overview",
             h1("Project Overview"),
             p("Welcome to our data exploration project."),
             p("We will be analyzing XYZ data to answer questions related to ABC."),
             p("The data was sourced from [Data Source](link_to_data_source)."),
    ),
    tabPanel("Question 1",
             h1("Collision Types in Maryland from 2015-2023"),
             mainPanel(
               plotlyOutput("collision_plot")
             )
    ),
    tabPanel("Question 2",
             h1("Question 2: ..."),
             # Add widgets and reactive charts specific to Question 2
             # ...
    ),
    tabPanel("Question 3",
             h1("Question 3: ..."),
             # Add widgets and reactive charts specific to Question 3
             # ...
    ),
    tabPanel("Conclusions",
             h1("Project Conclusions"),
             p("In summary, our analysis revealed the following major takeaways:"),
             # Add text and other elements to present your conclusions
             # ...
    )
  )
)

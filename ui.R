library(ggplot2)
library(shiny)
library(shinydashboard)
library(plotly)
library(dplyr)
library(lubridate)
library(tidyr)

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
             p("The data was sourced from [Data Source](link_to_data_source).")
    ),
    tabPanel("Question 1",
             h1("Vehicle Collision Types from 2015-2023"),
             #sidebarLayout(
             #sidebarPanel(
                 #sliderInput("yearRange",
                             #"Select Years:",
                             #min = min(data$Year),
                             #max = max(data$Year),
                             #value = c(2015, 2020),
                             #hr(),
                             #fluidRow(column(7, verbatimTextOutput("range")))
                 #),
                 mainPanel(
                   plotlyOutput("collision_bargraph")
                 )
               #)
             #),
    ),
    tabPanel("Question 2",
             h1("Alcohol-Related Vehicle Crashes Over Time"),
             #sidebarLayout(
               #sidebarPanel(
                 #sliderInput("yearRange",
                             #"Select Years:",
                             #min = min(data$Year),
                             #max = max(data$Year),
                             #value = c(2015, 2020),
                 #hr(),
                 #fluidRow(column(7, verbatimTextOutput("range")))
              #),
              mainPanel(
                plotlyOutput("interactive_plot")
              )
             #)
    #),
    ),
    tabPanel("Question 3",
             h1("Relationship between Top 10 Vehicle Makes and Injury Severity"),
             mainPanel(
               plotlyOutput("injury_plot")
             ),
             uiOutput("severity_input")
    ),
    tabPanel("Conclusions",
             h1("Project Conclusions"),
             p("In summary, our analysis revealed the following major takeaways:"),
             # Add text and other elements to present your conclusions
             # ...
    )
  )
)

library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(lubridate)
library(tidyr)


data <- read.csv("maryland_crash_report.csv")
data <- data %>%
  mutate(Year = year(as.POSIXct(Crash.Date.Time, format = "%m/%d/%Y %I:%M:%S %p")))

ui <- fluidPage(
  
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
             titlePanel("Vehicle Collision Types from 2015-2023"),
             sidebarLayout(
               sidebarPanel(
                 sliderInput("yearRange",
                             "Select Years:",
                             min = min(data$Year),
                             max = max(data$Year),
                             value = c(2015, 2020),
                 hr(),
                 fluidRow(column(7, verbatimTextOutput("range")))
               ),
               mainPanel(
                 plotlyOutput("collision_graph")
               )
             )
    ),
    tabPanel("Question 2",
             titlePanel("Alcohol-Related Vehicle Crashes Over Time"),
             sidebarLayout(
               sidebarPanel(
                 sliderInput("yearRange",
                             "Select Years:",
                             min = min(data$Year),
                             max = max(data$Year),
                             value = c(min(data$Year), max(data$Year))),
                 hr(),
                 fluidRow(column(7, verbatimTextOutput("range")))
               ),
               mainPanel(
                 plotlyOutput("interactive_plot")
               )
             )
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




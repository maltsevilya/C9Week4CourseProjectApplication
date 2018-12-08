library(shiny)
library(plotly)

shinyUI(fluidPage(

  titlePanel("Chess players with classical rating more than 2500"),

  sidebarLayout(
    sidebarPanel(
       textOutput("text"),
       selectInput("players",
                   label = "Players:",
                   multiple = TRUE,
                   choices = c("Choose several" = "")),
       dateRangeInput("daterange", "Date range:",
                      start = "2001-01-01",
                      end   = "2018-12-01",
                      min = "2001-01-01",
                      format = "mm/yy")
    ),

    mainPanel(
        plotlyOutput("ratingPlot")
    )
  )
))

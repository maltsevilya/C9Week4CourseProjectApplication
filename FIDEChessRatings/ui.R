library(shiny)
library(plotly)

shinyUI(
    navbarPage(
        "Chess",
        tabPanel("Ratings",
                 h2("Chess players with classical rating more than 2400"),

                 sidebarLayout(
                     sidebarPanel(
                         textOutput("text"),
                         selectInput("players",
                                     label = "Find and choose players:",
                                     multiple = TRUE,
                                     choices = c("Choose several" = ""),
                                     selected = "Carlsen, Magnus"),
                         dateRangeInput("daterange", "Select date range:",
                                        start = "2001-01-01",
                                        end   = "2018-12-01",
                                        min = "2001-01-01",
                                        format = "mm/yy")
                     ),

                     mainPanel(
                         plotlyOutput("ratingPlot")
                     )
                 )
        ),
        tabPanel(p(icon("info"), "Help"),
                 mainPanel(includeMarkdown("help.Rmd")))
    )
)

library(shiny)
library(plotly)
library(dplyr)
library(lubridate)

playersData <- read.csv("over2400.csv") %>%
    mutate(date = parse_date_time(date, c("%y-%m-%d"))) %>%
    mutate(name = as.character(name))

shinyServer(function(input, output, session) {

    observe({
        names <- playersData %>%
            select(name) %>%
            distinct() %>%
            arrange(name)
        names <- names$name
        updateSelectInput(session,
                          "players",
                          choices = names,
                          selected = "Carlsen, Magnus")
    })

    selectedPlayersData <- reactive({
        if (length(input$players) == 0) {
            return(NULL)
        }

        minDate <- as.Date(input$daterange[1])
        maxDate <- as.Date(input$daterange[2])

        playersData %>%
            filter(name %in% input$players) %>%
            filter(date >= minDate & date <= maxDate) %>%
            group_by(name) %>%
            arrange(date)
    })

    output$ratingPlot <- renderPlotly({
        data <- selectedPlayersData()
        if (is.null(data)) {
            return(NULL)
        }
        plot_ly(data,
                x = ~date,
                y = ~rating,
                color = ~name,
                type = "scatter",
                mode = "lines") %>%
            layout(
                xaxis = list(
                    title = "Date"
                ),
                yaxis = list(
                    title = "Rating"
                )
            )
    })
})

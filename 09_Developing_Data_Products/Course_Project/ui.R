library(shiny)
library(plotly)
library(ggplot2)
data("diamonds")

# Define UI
shinyUI(fluidPage(
    titlePanel("Predict Price of Diamond Based On Its Characteristics"),
    sidebarLayout(
        sidebarPanel(
            h3("Customize diamond"),
            selectInput("cut", "Cut", sort(levels(diamonds$cut), decreasing = TRUE)),
            selectInput("color", "Color", sort(levels(diamonds$color))),
            selectInput("clarity", "Clarity", sort(levels(diamonds$clarity), decreasing = T)),
            sliderInput("carat", "Carat",
                        min = min(diamonds$carat), max = max(diamonds$carat),
                        value = (min(diamonds$carat) + max(diamonds$carat))/2, step = 0.1)
        ),
    mainPanel(
        plotlyOutput("plot"),
        h3("Predicted price of diamond:"),
        textOutput("prediction")
         )
        )
    )
)


library(shiny)
library(ggplot2)
library(plotly)
library(caret)
library(dplyr)
data("diamonds")

shinyServer(
    function(input, output) {
        # Drop unused variables from dataset
        diamonds <<- select(diamonds, price, cut, color, clarity, carat)
        
        # Generate prediction output
        output$prediction <- renderText({
        # Create subset based on inputs
        diamonds.df <<- reactive({
           diamonds.subset <- subset(diamonds, cut == input$cut & 
                                      color == input$color & 
                                      clarity == input$clarity)
           return(diamonds.subset)
        })
       # Create condition for availability of inputs in data
        if (nrow(diamonds.df()) == 0) {
            stop("Sorry, unable to predict price of diamond based on selected inputs using a general linear model, with current data. Please try other inputs.")
        } else {
         # Fit model
        model.fit <- lm(price ~ carat, data = diamonds.df())
        # Predict
        model.predict <<- predict(model.fit, newdata = data.frame(carat = input$carat))
        paste0("$", format(model.predict, 
                           big.mark = ",", 
                           digits = 2))
        }
        })
        
        # Generate plot output
        output$plot <- renderPlotly({
            gg <- ggplot(data = diamonds.df(), aes(x = carat, y = price)) + 
                geom_point() +
                geom_point(aes(x = input$carat, y = model.predict), color = "red") +
                geom_smooth(method = "lm") + 
                xlab("Carat") + 
                ylab("Price")
            ggplotly(gg)
        })
        })

    
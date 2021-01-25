# Page 3: linear model based on which species

library(shiny)
library(ggplot2)
library(DT)
data(iris)


shinyServer(function(input, output) {
    selectX <- reactive ({
        ind <- as.numeric(input$species)
        subset(iris, Species == levels(iris$Species)[ind])[["Sepal.Length"]]
    })
    selectY <- reactive ({
        ind <- as.numeric(input$species)
        subset(iris, Species == levels(iris$Species)[ind])[["Sepal.Width"]]
    })
    model1 <- reactive({
        lm(y ~ x, data=data.frame(x = selectX(), y = selectY()))
    })
    model1pred <- reactive({
        predict(model1(), newdata = data.frame(x = input$sliderSepalLength))
    })
    
    output$plot2 <- renderPlot({
        plot(selectX(), selectY(),
             xlab = "Sepal Length",
             ylab = "Sepal Width",
             bty = "n", pch = 16,
             xlim = c(input$xlim[1], input$xlim[2]), 
             ylim = c(input$ylim[1], input$ylim[2]))
        
        #linear model
        if (input$showModel1) {
            sliderSepalLength <- input$sliderSepalLength

            model1lines <- predict(model1(), newdata = data.frame(x = input$xlim[1]:input$xlim[2]))

            lines(input$xlim[1]:input$xlim[2], model1lines, col = 'blue', lwd = 2)
            legend(25, 350, c("Model 1 Prediction"), pch = 16, col = c("blue"), bty = "n", cex = 2)
            points(sliderSepalLength, model1pred(), col = "blue", pch = 16, cex = 2)
        }
    })

    output$pred1 <- renderText({
        model1pred()
    })
        
    # output$table2 <- renderDataTable({
    #     DT::datatable(subset(iris, Species == levels(iris$Species)[as.numeric(input$species)])[c("Sepal.Length","Sepal.Width")], 
    #     options = list(pageLength = 15))
    # })

})

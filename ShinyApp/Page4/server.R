# Page 4: linear model with brushing

library(shiny)
library(ggplot2)
data(iris)

selectData <- function(indX, indY, data = iris) {
    temp <- data[, names(data)[c(indX, indY, 5)]]
    names(temp) <- c("x","y","c")
    return (temp)
}

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {

    selectVars <- reactive ({
        indX <- as.numeric(input$xVar)
        indY <- as.numeric(input$yVar)
        selectData(indX, indY)
    })
    
    # model2 <- reactive({
    #     lm(y ~ x, data=selectVars())
    # })
    
    # Usage of `brush`
    model2 <- reactive({
        brushed_data <- brushedPoints(selectVars(), input$brush1,
                                      xvar = "x", yvar = "y")
        if (nrow(brushed_data) < 2){
            return(NULL)
        }
        lm(y ~ x, data = brushed_data)
    })
    
    output$scatterPlot <- renderPlot({
        
        p <- selectVars() %>% ggplot(aes(x = x, 
                                    y = y,
                                    col = c)) + 
            geom_point() +
            theme(legend.title = element_blank())
        
        #linear model
        if (!is.null(model2())) {
            # if() {
            #     abline(model2(), col = "blue", lwd = 2)
            # }

            model2lines <- predict(model2(), newdata = data.frame(x = 0:10))
            output_df <- data.frame(x = 0:10,
                                    y = model2lines,
                                    c = 'linear model')
            p <- p + geom_line(data = output_df, aes(x = x, y = y, col = c))
            
            #legend(25, 350, c("Model 1 Prediction"), pch = 16, col = c("blue"), bty = "n", cex = 2)
            #points(sliderSepalLength, model1pred(), col = "blue", pch = 16, cex = 2)
        }
        p
    })
    
    output$slopeOut <- renderText({
        if(is.null(model2())) {
            "No Model Found"
        } else {
            model2()[[1]][2]
        }
    })
    output$intOut <- renderText({
        if(is.null(model2())) {
            "No Model Found"
        } else {
            model2()[[1]][1]
        }
    })

})

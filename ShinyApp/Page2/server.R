#Page 2: histogram selection

library(shiny)
library(ggplot2)
data(iris)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        ind <- as.numeric(input$category)
        x    <- iris[, ind]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        #hist(x, breaks = bins, col = 'darkgray', border = 'white',
        #     main = "Histogram of Iris")
        
        ggplot(iris[, c(ind,5)], 
               aes(x=get(names(iris)[ind]), fill=Species)) +
            geom_histogram(stat = "bin", bins = input$bins) +
            xlab('# of bins')

    })

})

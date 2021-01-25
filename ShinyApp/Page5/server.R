# Page 5: kmeans clustering

library(shiny)
library(cluster)
library(factoextra)
library(ggplot2)
data(iris)

#function to select input data for display
selectData <- function(indX, indY, data = iris) {
    temp <- data[, names(data)[c(indX, indY, 5)]]
    names(temp) <- c("x","y","c")
    rownames(temp) <- paste0(rownames(temp), ": ", temp[,3])
    return (temp)
}

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    #input dataset
    selectVars <- reactive ({
        indX <- as.numeric(input$xVar)
        indY <- as.numeric(input$yVar)
        selectData(indX, indY)
    })
    
    #create kmeans clustering model
    model3 <- reactive({
        #lm(y ~ x, data=selectVars())
        set.seed(123)
        #k.values <- input$num_cluster
        kmeans(selectVars()[1:2], as.numeric(input$num_cluster), nstart = 25)
        
    })
    
    output$scatterPlot <- renderPlot({

        #point clusters
        fviz_cluster(model3(), geom = "text", data = selectVars()[,1:2], alpha = 0)
    })

})

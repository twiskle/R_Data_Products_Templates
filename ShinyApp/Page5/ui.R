# Page 5: kmeans clustering

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    sidebarLayout(
        sidebarPanel(
            selectInput("xVar", "Choose a variable for x-axis:",
                        choices = setNames(1:4, names(iris)[1:4]), selected = 1,
            ),
            selectInput("yVar", "Choose a variable for y-axis:",
                        choices = setNames(1:4, names(iris)[1:4]), selected = 2,
            ),
            
            selectInput("num_cluster", "Select the number of clusters",
                        choices = setNames(1:5, 1:5), selected = 1,
            ),
            
            width = 3
        ),

        # Show a scatter plot with kmeans clustering
        mainPanel(
            plotOutput("scatterPlot")
        )
    )
))

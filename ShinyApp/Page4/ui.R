# Page 4: linear model with brushing

library(shiny)

shinyUI(fluidPage(

    sidebarLayout(
        sidebarPanel(
            selectInput("xVar", "Choose a variable for x-axis:",
                        choices = setNames(1:4, names(iris)[1:4]), selected = 1,
            ),
            selectInput("yVar", "Choose a variable for y-axis:",
                        choices = setNames(1:4, names(iris)[1:4]), selected = 2,
            ),
            
            #brush parameter in plot
            h3("Slope"),
            textOutput("slopeOut"),
            h3("Intercept"),
            textOutput("intOut"),
            

            width = 4
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("scatterPlot", brush = brushOpts(id = "brush1"))
        )
    )
))

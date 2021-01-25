# Page 3: linear model based on which species

library(shiny)
data(iris)

shinyUI(fluidPage(

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("species", "Choose a species:",
                        setNames(1:length(unique(iris$Species)), levels(iris$Species))
            ),

            sliderInput("sliderSepalLength", "What is the Sepal Length?", 0, 10, step=0.5, value=5),            
            
            sliderInput("xlim",
                        "Selext xlim values:",
                        min = 0,
                        max = 10,
                        value = c(3,7)),
            
            sliderInput("ylim",
                        "Selext ylim values:",
                        min = 0,
                        max = 10,
                        value = c(2,5)),

            checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
            

            width = 4
        ),

        # Show a plot of the generated distribution
        mainPanel(
            # dataTableOutput('table2'), width = 6
            plotOutput("plot2"),
            
            h3("Predicted Sepal Width from Model 1:"),
            textOutput("pred1"),
        )
    )
))

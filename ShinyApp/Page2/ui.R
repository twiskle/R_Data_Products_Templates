#Page 2: histogram selection

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    #titlePanel("Iris Dataset Histogram"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            #histogram
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30),
            
            
            selectInput("category", "Choose a variable:",
                        setNames(1:4, names(iris)[1:4])
            ),
            # selectInput("species", "Choose a species:",
            #             setNames(1:length(unique(iris$Species)), levels(iris$Species))
            # ),
            
            # sliderInput("sliderMPG", "What is the MPG of the car?", 10, 35, value  = 20),
            
            
            #checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
))

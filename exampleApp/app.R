#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

ui <- fluidPage(

    titlePanel("SuperShinyApp"),

    sidebarLayout(
        sidebarPanel(
            fileInput("fasta_file", "Please provide a valid .fasta file")
        ),

        # Show a plot of the generated distribution
        mainPanel(
           textOutput("fasta_file_content")
        )
    )
)

server <- function(input, output) {
    
    output[["fasta_file_content"]] <- renderText({
        browser()
    })


}

shinyApp(ui = ui, server = server)

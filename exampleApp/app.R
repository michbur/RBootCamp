library(shiny)
library(ggplot2)
library(dplyr)

ui <- fluidPage(
    
    titlePanel("SuperShinyApp"),
    
    sidebarLayout(
        sidebarPanel(
            fileInput("fasta_file", "Please provide a valid .fasta file")
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("aa_composition"),
            verbatimTextOutput("fasta_file_content")
        )
    )
)

server <- function(input, output) {
    
    fasta_content <- reactive({
        readLines(input[["fasta_file"]][["datapath"]])[-1]
    })
    
    output[["fasta_file_content"]] <- renderPrint({
        # if(!is.null(input[["fasta_file"]]))
        #     browser()
        
        cat(fasta_content(), sep = "\n")
    })
    
    output[["aa_composition"]] <- renderPlot({
        
        fasta_content() %>% 
            strsplit("") %>% 
            unlist %>% 
            table(aa = .) %>% 
            data.frame %>% 
            ggplot(aes(x = aa, y = Freq)) +
            geom_col()
    })
    
    
}

shinyApp(ui = ui, server = server)

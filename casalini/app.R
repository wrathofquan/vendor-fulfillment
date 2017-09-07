library(tidyverse)
library(shiny)

data <- read_csv("casalini.csv")
d  <- data %>% group_by(Order, FY, NumberDays) %>% count(Order, NumberDays)

ui <- basicPage(
  plotOutput("plot1",  brush = "plot_brush"),
  verbatimTextOutput("info")
)

server <- function(input, output) {
  output$plot1 <- renderPlot({
   ggplot(d, aes(NumberDays, n, fill = FY)) + geom_bar(stat="identity", width = 6) + scale_x_continuous(breaks = seq(0,300, by = 30)) +
      ggtitle("Casalini- Number of Days Until Fulfillment FY16 + FY17") + theme_minimal()
    
  })
  
  output$info <- renderPrint({
    brushedPoints(d, input$plot_brush)
  })
}

shinyApp(ui, server)
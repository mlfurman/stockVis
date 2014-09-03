# server.R

library(quantmod)
source("helpers.R")

shinyServer(function(input, output) {
  ## changes values if stock name or date range is altered
  dataInput <- reactive({
    getSymbols(input$symb, src = "yahoo",
       from = input$dates[1],
       to = input$dates[2],
       auto.assign = FALSE)
  })
  
  ## changes values if adjust for inflation  
  finalInput <- reactive({
        if (!input$adjust) return(dataInput()) 
        adjust(dataInput())
  })
    
  output$plot <- renderPlot({
    chartSeries(finalInput(), theme = chartTheme("white"), 
      type = "line", log.scale = input$log, TA = NULL)
  })
  
})
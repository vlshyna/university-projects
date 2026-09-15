library(shiny)
library(datasets)

# Definujte logiku servera potrebnú na zhrnutie a zobrazenie vybraného súboru údajov
shinyServer(function(input, output) {
  
  # Vráti požadovaný súbor údajov
  datasetInput <- reactive({
    switch(input$dataset,
           "rock" = rock,
           "pressure" = pressure,
           "cars" = cars)
  })
  
  # Vytvorte sumarizáciu údajov
  output$summary <- renderPrint({
    dataset <- datasetInput()
    summary(dataset)
  })
  
  # Zobrazte prvých "n" pozorovaní
  output$view <- renderTable({
    head(datasetInput(), n = input$obs)
  })
})
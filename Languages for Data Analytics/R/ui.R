library(shiny)

# Definujte UI pre aplikáciu, ktorá vykresľuje náhodné distribúcie 
shinyUI(fluidPage(
  
  # Titulok
  headerPanel("Hello Shiny!"),
  
  # Panel s posuvným vstupom pre počet pozorovaní = slider
  sidebarPanel(
    sliderInput("obs", 
                "Number of observations:", 
                min = 1,
                max = 1000, 
                value = 500)
  ),
  
  # Zobraziť graf generovanej distribúcie  mainPanel(
  plotOutput("distPlot")
)
)
library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Central Florida House Research"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      
       selectInput("variable", "City:",
                   c("Apopka",
                     "Belle Isle",
                     "Eatonville",
                     "Edgewood",
                     "Maitland",
                     "Oakland",
                     "Ocoee",
                     "Orlando",
                     "Windermere",
                     "Winter Garden",
                     "Winter Park"
                   ))
       
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("plotgraph")
    )
  )
))

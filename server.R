library(shiny)
library(ggplot2)
library(grid)
library(readxl)
library(dplyr)

shinyServer(function(input, output) 
{
  SalePrices <- reactive({ 
                  read_excel("Data/SalePrices.xlsx") 
        })
  YearBuilt <- reactive({ 
    read_excel("Data/YearBuilt.xls") 
  })  
  
  demo <- reactive({ 
    read_excel("Data/demo.xls") 
  })  
  
  CombinedPop <- reactive({ 
    read_excel("Data/pop.xls") 
  })  
  

  options(shiny.sanitize.errors = TRUE)
  pt1 <- reactive({ 
    filter(SalePrices(), City == input$variable) %>%
      ggplot() + geom_bar(aes(YearofSales,RealSalesPrice),stat = "identity")+ 
      scale_y_continuous(labels = scales::comma)
  })
  
  pt2 <- reactive({ 
    filter(SalePrices(), City == input$variable) %>%
      ggplot() + geom_bar(aes(YearofSales,NumberOfSales),stat = "identity")+ 
      scale_y_continuous(labels = scales::comma)
  })
  
  pt3 <- reactive({ 
    filter(YearBuilt(), City == input$variable) %>%
      ggplot(aes(YearBuilt,SingleFamilyHouses)) + 
      geom_bar(stat = "identity")+ 
      scale_y_continuous(labels = scales::comma) +
      coord_flip()
  })
  
  pt4 <- reactive({ 
    filter(demo(), City == input$variable) %>%
      ggplot()+ 
      geom_bar(aes(x="HouseholdIncome", y=HouseholdCount, fill=HouseholdIncome),width = 0.5, stat = "identity")
    })
  
  pt5 <- reactive({
     filter(demo(), City == input$variable) %>%
      ggplot()+ 
      geom_bar(aes(x="HousingCostBurden", y=HouseholdCount, fill=HousingCostBurden),width = 0.5, stat = "identity")
  })
  
  pt6 <- reactive({ 
    filter(CombinedPop(), City == input$variable) %>%
      ggplot() +
      geom_bar(aes(Age,Population,col=Year),position = "dodge",stat = "identity")
  })
  
  output$plotgraph = renderPlot({
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(3, 3)))
    vplayout <- function(x, y) viewport(layout.pos.row = x, layout.pos.col = y)
    print(pt1(), vp = vplayout(1, 1))  # key is to define vplayout
    print(pt2(), vp = vplayout(1, 2))    
    print(pt3(), vp = vplayout(2, 1))    
    print(pt4(), vp = vplayout(2, 2))  
    print(pt5(), vp = vplayout(2, 3))
    print(pt6(), vp = vplayout(3, 1:3))
  })
})
shiny::runApp()
#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(DT)

mobility <- read.csv("movement_data.csv", sep = ";")
mobility$date<-as.Date(mobility$Date)#as.Date()method returns the object of a class "Date" 
mobility$province<-as.factor(mobility$province) returns the origional object of a class with the requested column specified as a factor rather than a numeric
# Define UI for application that will show a simple project
ui <- fluidPage()
titlePanel("covid 19 data")
     sidebarLayout(
     sidebarPanel(
  selectInput(inputId = "dv", label = "category",
                       choices = c("Retail_Recreation", "Grocery_Pharmacy", "Parks", "Transit_stations", "workplaces", "residential"), 
              
                      selected = ("Grocery_Pharmacy")
                  
  selectInput(inputId = "Provinces","province(s)",
              choices =levels(mobility$province), 
              
              multiple= True,
              Selected= "grocery_Pharmacy", "parks", "Transit_stations")
  dateRangeInput(inputId = "Date label"="Date range",
                 start= min(mobility$Date),
                 end= max(mobility$date))
  
  
                
            
        
                        
     
   mainPanel(
   plotOutput (outputId = "plot"),
   em("positive and negative percentages indicate an increase and decrease from the aseline period(median value between january 3 and februrary 6, 2020) respectively")
   DT:: dataTableOutput(outputID= "table")

# Define server logic required to draw a histogram
server <- function(input, output) [ 
filtered_Data<<-reactive()
subset( mobility,
provine%in% input$provinces &
 Date>=input $date[1] & date <=input$date[2])

  output$plot<-renderPlot ({
  ggplot( filtered_data(),
  aes_string( x="date", =input$dv, color= " province "")) + geom_point(alpha=0.5) +
     ylab("%change from base )
  })
   output$download_data <- downloadHandler(
     filename = "download_data.csv"
     content = function(file)
       data<-filtered_data()
     write.csv(data.file.row.names= FALSE)
   )


# Run the application 
shinyApp(ui = ui, server = server)
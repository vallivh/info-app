
library(shiny)
library(shinydashboard)
library(mongolite)
library(nycflights13)

m <-
  mongo(collection = "flights",
        db = "test",
        url = "mongodb://mongodb:27017/")
m$drop()

ui <- dashboardPage(
  dashboardHeader(title = "Dynamic boxes"),
  dashboardSidebar(),
  dashboardBody(fluidRow(
    box(width = 2, actionButton("count", "Count")),
    infoBoxOutput("ibox"),
    valueBoxOutput("vbox")
  ))
)

server <- function(input, output) {

  cc <- reactiveVal(m$count())

  observeEvent(input$count, {
    m$insert(flights)
    cc(m$count())
  })

  output$ibox <- renderInfoBox({
    infoBox("Title",
            cc(),
            icon = icon("credit-card"))
  })
  output$vbox <- renderValueBox({
    valueBox("Title",
             input$count,
             icon = icon("credit-card"))
  })
}

shinyApp(ui, server)

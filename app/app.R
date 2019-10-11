
library(shiny)
library(shinydashboard)
library(mongolite)
library(nycflights13)
library(spacyr)

m <- mongo(collection = "flights",
           db = "test",
           url = "mongodb://mongodb:27017/")

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
    spacy_initialize(python_executable = "/opt/conda/envs/spacy_condaenv/bin/python")
    m$insert(flights)
    cc(m$count())
    spacy_finalize()
  })

  output$ibox <- renderInfoBox({
    infoBox("Title",
            cc(),
            icon = icon("credit-card"))
  })
  output$vbox <- renderValueBox({
    valueBox("Title",
             input$count,
             icon = icon("credit-card"),
             color = "orange")
  })
}

shinyApp(ui, server)

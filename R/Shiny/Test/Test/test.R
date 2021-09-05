

library(shiny)
ui <- fluidPage(
  selectInput("dataset", label = "Dataset", choices = ls("package:datasets")),
  verbatimTextOutput("summary"),
  tableOutput("table")
)
server <- function(input, output, session) {
  output$summary <- renderPrint({
    dataset <- get(input$dataset, "package:datasets")
    summary(dataset)
  })

  output$table <- renderTable({
    dataset <- get(input$dataset, "package:datasets")
    dataset
  })
}
shinyApp(ui, server)



# Define UI for dataset viewer app ----
ui <- fluidPage(

  # App title ----
  titlePanel("REDCap editor"),
  h4("Transfer participants between study arms"),

  # Sidebar layout with input and output definitions ----
  sidebarLayout(

    # Sidebar panel for inputs ----
    sidebarPanel(
      # Input: Enter API code
      textInput(inputId = "api",
                label = "Enter your API key",
                value = "",
                placeholder = "Your API key goes here"),

      # Optional text
      uiOutput("text"),

      # Input: Selector for choosing sudy arm ----
      uiOutput("study_arm"),

      # Input: Selector for choosing participant ID ----
      uiOutput("select_id"),

    ),

    # Main panel for displaying outputs ----
    mainPanel(

      # Output: Formatted text for caption ----
      h3(textOutput("caption", container = span)),

      # Output: Verbatim text for data summary ----
      verbatimTextOutput("summary"),

      # Output: HTML table with requested number of observations ----
      tableOutput("view")

    )
  )
)

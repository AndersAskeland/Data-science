library(shiny)
library(shinyFiles)
library(fs)
library(RCurl)
source("functions.R")


############################################################
###################  User interface (UI) ###################
############################################################
ui_new <- fluidPage(
    # Main project title
    titlePanel("REDCap - Transfer records between arms"),

    # Define layout
    fluidRow(
        # Row 1 - Select record
        h3("  1 - Select record"),

        column(3, wellPanel(
            # Subtitle
            h3("1 - Select record"),

            # Input: Enter API code
            textInput(inputId = "api",
                      label = "Enter your API key",
                      value = "",
                      placeholder = "Your API key goes here"),

            # Output: Error handling
            uiOutput("text"),

            # Input: Selector for choosing sudy arm ----
            uiOutput("study_arm"),

            # Input: Selector for choosing participant ID ----
            uiOutput("select_id"),

        )),
        # Row 2 - Storage locatio
        column(3, wellPanel(
            # Subtitle
            h3("2 - Transfer settings"),

            shinyDirButton("directory", "Folder select", "Please select a folder"),
            # Input: Select a file ----
            verbatimTextOutput("directorypath"),

        )),
        column(3, wellPanel(
            # Subtitle
            h3("2 - Transfer settings")
))))


############################################################
###################### Server logic ########################
############################################################
server <- function(input, output, session) {
    # Get API
    observe({
        if (!check_api(input$api)) {
            output$text <- renderUI(expr = "Waiting for valid API key")
            output$study_arm <- renderUI("test")
            output$select_id <- renderUI("")

        }
    })

    # Set folder
    volumes <- c(Home = fs::path_home(), "R Installation" = R.home(), getVolumes()())
    shinyDirChoose(input, "directory", roots = volumes, session = session, restrictions = system.file(package = "base"))

    # Show chosen dir
    output$directorypath <- renderPrint({
        if (is.integer(input$directory)) {
            cat("No directory has been selected (shinyDirChoose)")
        } else {
            parseDirPath(volumes, input$directory)
        }
    })




    # Show study arm selector
    observe({
        if(check_api(input$api)){
            # Remove text
            output$text <- renderUI("")

            # Dynamically render choose study arm # TODO - use API KEY FROM FIRST FIELD.
            output$study_arm <- renderUI(
                selectInput(inputId = "arm",
                            label = "Choose a study arm:",
                            choices = study_arms(api = input$api)))
        }
    })

    # Show participant ID selector
    observe({
        if(!is.null(input$arm)){
            # Remove old UI
            # Dynamically render choose study arm # TODO - use API KEY FROM FIRST FIELD.
            output$select_id <- renderUI (
                selectInput(inputId = "ud",
                            label = "Select participant ID:",
                            choices = study_ids(api = input$api, arm = input$arm)))
        }
    })
}


# Create Shiny app ----
shinyApp(ui_new, server)

# Define UI for application that draws a histogram
ui <- fluidPage(
  useShinyjs(),
  extendShinyjs(text = jsCode),
  
  
  tags$head(
    tags$style(HTML("
                    .good {
                    color: green;
                    }
                    .bad {
                    color: red;
                    }
                    
                    "))
    ),
  # Application title
  titlePanel("Boggly Thing"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(numericInput("j", label = h3("Rows:"), value = 5),
                 numericInput("i", label = h3("Columns:"), value = 5),
                 numericInput("letsize", label = h3("lettersize"), value = 24),
                 selectInput("select", label = h3("Letter Distribution"),
                             choices = c('English', 'French', 'German', 'Spanish', 'Portuguese', 'Esperanto', 'Italian',
                                         'Turkish', 'Swedish', 'Polish', 'Dutch', 'Danish', 'Icelandic', 'Finnish'),
                             selected = 'English')
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      #game board
      plotOutput("gg"),
      #word input
      textInput("wordInput", "Enter Words"),
      #submit button
      actionButton("buttonSubmitWord", "Click Here or Press Enter"),
      #list of submitted words
      tags$div(id="found_words"),
      #jquery to enable enter for action button
      # fires #buttonSubmitWord click when you press return in #wordInput
      # clears #wordINput on $buttonSubmitWord click
      tags$script(HTML("$('#wordInput').keypress(function(e) {
                       if (e.which === 13) {
                       $('#buttonSubmitWord').click();
                       }
                       });
                       $('#buttonSubmitWord').click(() => $('#wordInput').val(''));"))
      )
      )
      )
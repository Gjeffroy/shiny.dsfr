library(shiny)
library(shiny.dsfr)
library(shinipsum)
library(htmltools)

options(shiny.port = 7777)

ui <-
  dsfrPage(
    suppress_bootstrap = FALSE,
    dsfrHeader(
      marianne_title = "Préfecture$de la Seine-$Maritime",
      service_title = "DDTM 76",
      service_baseline = "Application de dataviz",
      enlarge_link = TRUE
    ),
    dsfrSidebarLayout(
      dsfrSidebarPanel(
        h4("Paramètres"),
        div("Param 1"),
        sliderInput("obs", "Number of observations:",
                    min = 0, max = 1000, value = 500
        ),
        dsfrToggleSwitch("toggle1", label = "test", hint = "precision"),
        dsfrSelectInput('selection', 'label', unique(iris$Species)),
        div("Param 2")
      ),
      dsfrMainPanel(
        plotOutput("distPlot")
      ),
      gutters = TRUE
    ),
    dsfrRow(
      gutters = FALSE,
      horizontal_align = "center",
      dsfrCol(shinipsum::random_DT(100,5, type = "random"), width = 12)
    )
    ,
    dsfrFooter(description = shinipsum::random_text(200))

  )


server <- function(input, output, session) {
  output$distPlot <- renderPlot({
    hist(rnorm(input$obs))
  })

  observeEvent(input$toggle1, print(input$toggle1))
  observeEvent(input$selection, print(input$selection))
}

shinyApp(ui, server)

### APP CODE ###
library(shiny)
library(shiny.dsfr)
library(shinipsum)
library(htmltools)
library(DT)
#library(OSUICode)

options(shiny.port = 7777)
#devtools::load_all()

footer <-  NULL

navsidebarpanel <-
  dsfrNavSidebarPanel(
    id = "mon_premier_panel",
    hide_panel = TRUE,
    position = "left",
    dsfrTabPanel(id="mon_graphe", role = "navsidebarpanel", title = "Mon graphique",
                 h2("Mon graphique"),
                 shinipsum::random_ggplotly()),
    dsfrTabPanel(id="mon_texte", role = "navsidebarpanel", title = "Mon texte",
                 h2("Mon texte", id="mon_texte"),
                 p(shinipsum::random_text(2500))),
    dsfrTabPanel(id="ma_table", role = "navsidebarpanel", title = "Ma table",
                 h2("Ma table", id="ma_table"),
                 DTOutput("my_dt_table"))
  )

widget <- shinipsum::random_ggplotly()
#widget <- shinipsum::random_DT(100,5, type = "random")

ui <-
  dsfrPage(
    dsfrHeader(
      marianne_title = "Préfet$de l\'Eure",
      service_title = "DDTM 27",
      service_baseline = "Application de dataviz",
      enlarge_link = TRUE
    ),
    navsidebarpanel,
    footer

  )


server <- function(input, output, session) {

  widget <- DT::datatable(iris, width = "100%", height = "auto")
  output$my_dt_table <- renderDataTable(widget)

}

shinyApp(ui, server)



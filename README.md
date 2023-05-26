
<!-- README.md is generated from README.Rmd. Please edit that file -->

# shiny.dsfr

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/shiny.dsfr)](https://CRAN.R-project.org/package=shiny.dsfr)
<!-- badges: end -->

`shiny.dsfr` est un package servant poc de démonstration pour faciliter
l’intégration de la charte graphique de l’Etat dans les applications
shiny.

## Installation

Pour installer le package de développement

``` r
remotes::install_gitlab("https://gitlab.com/dreal-datalab/shiny.dsfr")
```

## Exemple d’application

``` r
library(shiny)
library(shiny.dsfr)
library(shinipsum)
library(htmltools)

options(shiny.port = 7777)

ui <-
  dsfrPage(
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
        div("Param 2")
      ),
      dsfrMainPanel(
        shinipsum::random_ggplotly()
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

}

shinyApp(ui, server)
```

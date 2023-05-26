#' Create a page with dsfr layout
#'
#' @param ... Elements to include within the page
#' @param title The browser title
#' @param lang The lang (default "fr")
#' @param theme The theme ("system", "dark", "light")
#'
#' @importFrom htmltools tagList
#'
#' @export
#'
#' @examples
#'
dsfrPage <- function(...,
                     title = "",
                     lang = "fr",
                     theme = c("system", "light", "dark"),
                     suppress_bootstrap = TRUE) {

  if (suppress_bootstrap) {
    suppress_bootstrap <- htmltools::suppressDependencies("bootstrap")
  } else {
    suppress_bootstrap <- NULL
  }

  theme <- match.arg(theme)

  ui <- tagList(
        tags$html(
          lang = lang,
#          "data-fr-scheme" = theme
    ),
    tags$head(
      tags$meta(charset = "utf-8"),
      tags$meta(name = "viewport",
                content = "width=device-width, initial-scale=1"),
    tags$title(title),
    tags$link(rel ="apple-touch-icon",
              href = "favicon/apple-touch-icon.png"),
    tags$link(rel = "icon",
              href = "dsfr-1.3.1/favicon/favicon.svg",
              type = "image/svg+xml"),
    tags$link(rel="shortcut icon",
              href="dsfr-1.3.1/favicon/favicon.ico",
              type="image/x-icon"),
    tags$link(rel="manifest",
              href="dsfr-1.3.1/favicon/manifest.webmanifest",
              crossorigin="use-credentials")
    ),
    tags$body(..., suppress_bootstrap) %>%
      add_dsfr_deps() %>%
      add_shiny.dsfr_deps()
  )
  ui
}

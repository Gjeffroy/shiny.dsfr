#' shiny.dsfr dependencies utils
#'
#' @description This function attaches shiny.dsfr dependencies to the given tag
#'
#' @param tag Element to attach the dependencies.
#'
#' @importFrom utils packageVersion
#' @importFrom htmltools tagList htmlDependency
#' @export
add_shiny.dsfr_deps <- function(tag) {
 shiny.dsfr_deps <- htmlDependency(
  name = "shiny.dsfr",
  version = "0.0.0.9000",
  src = c(file = "shiny.dsfr-0.0.0.9000"),
  script = "js/shiny.dsfr.min.js",
  package = "shiny.dsfr",
 )
 tagList(tag, shiny.dsfr_deps)
}
    

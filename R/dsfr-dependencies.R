#' dsfr dependencies utils
#'
#' @description This function attaches dsfr.  dependencies to the given tag
#'
#' @param tag Element to attach the dependencies.
#'
#' @importFrom htmltools tagList htmlDependency
#' @export
add_dsfr_deps <- function(tag) {
 dsfr_deps <- htmlDependency(
  name = "dsfr",
  version = "1.5.1",
  src = c(file = "dsfr-1.5.1/dist"),
  stylesheet = "dsfr/dsfr.min.css",
  script = list(
    list(type="module", src="dsfr/dsfr.module.min.js"),
    list(type="text/javascript", nomodule=NULL, src="dsfr/dsfr.nomodule.min.js")
  ),
  package = "shiny.dsfr",
 )
 tagList(tag, dsfr_deps)
}


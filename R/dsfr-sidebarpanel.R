#' dsfrSidebarPanel
#'
#' @param ...
#' @param width
#'
#' @return sideparnel
#' @export
#'
#' @importFrom htmltools css
#'
#' @examples
dsfrSidebarPanel <- function (...,
                              width = 4,
                              style = htmltools::css(`background-color` = "#f6f6f6",
                                                     border = "solid",
                                                     `bord-width` = "1px",
                                                     `border-color` = "#e5e5e5"))
{
  div(
    class = paste0("fr-col-12 fr-col-sm-", width),
    style= style,
    ...)
}

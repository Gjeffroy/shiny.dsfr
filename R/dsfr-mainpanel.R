#' dsfrMainPanel
#'
#' @param ...
#' @param width
#'
#' @return
#' @export
#'
#' @examples
dsfrMainPanel <- function(..., width = 8)
{
  div(class = paste0("fr-col-12 fr-col-sm-", width), role = "main", ...)
}

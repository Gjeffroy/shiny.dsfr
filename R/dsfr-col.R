#' dsfrCol
#'
#' @param ...
#' @param width
#'
#' @return
#' @export
#'
#' @examples
dsfrCol <- function (..., width = 4)
{
  div(class = paste0("fr-col-12 fr-col-sm-", width), ...)
}

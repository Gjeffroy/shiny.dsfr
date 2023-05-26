#' Substitute dollar sign by br tag
#'
#' @param string string
#'
#' @return tagList
#'
#' @importFrom stringr str_split
#' @importFrom purrr reduce
#' @importFrom htmltools tagList
#'
dollar_to_br <- function(string) {
  string %>%
    stringr::str_split(pattern= "\\$", simplify = TRUE) %>%
    purrr::reduce(function(x,y) tagList(x, tags$br(), y))
}

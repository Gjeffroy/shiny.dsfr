#' Accordions Group
#'
#' @param ...
#' @param id
#' @param expand
#'
#'
#' @return Accordions group
#' @export
#'
#' @examples
#'
#' @importFrom attempt try_catch
#' @importFrom htmltools tagList tagGetAttribute tagAppendChildren
#' @importFrom rlang list2
dsfrAccordionsGroup <- function(..., id = NULL, expand = c("none", "first")) {
  ul_wrapper <- tags$ul(
    class = "fr-accordions-group")

  expand <- match.arg(expand)
  expanded <- "false"

  accordions <- rlang::list2(...)
  accordions_list <- htmltools::tagList()
  id_accordion <- 1

  for (i in seq_along(accordions)){
    accordion <- accordions[[i]]
    attempt::try_catch( {
      #it is really a accordion ?
      is_accordion <- grepl("fr-accordion", htmltools::tagGetAttribute(accordion, "class"))
      is_first <- i == 1
      if (is_accordion) {
        # we add the accordiongroup id and the number of accordion in the button
        id_button <- paste0("accordion-", id, "-", i)
        # set the id of the button
        accordion$children[[1]]$children[[1]]$attribs$`aria-controls` <- id_button
        accordion$children[[1]]$children[[1]]$attribs$`aria-expanded` <- expanded
        # set the id in the content
        accordion$children[[2]]$attribs$id <- id_button

        if (is_first && expand == "first") {
          accordion$children[[1]]$children[[1]]$attribs$`aria-expanded` <- "true"
        }
        id_accordion <- id_accordion + 1
        accordions_list <- htmltools::tagList(accordions_list, accordion)
      }
    },
    .e = ~ print(paste0("Error : this is not a accordion", .x))
    )
  }

  ul_wrapper %>%
    htmltools::tagAppendChildren(accordions_list)
}


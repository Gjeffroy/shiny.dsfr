
#' Accordion
#'
#' @param ...
#' @param title
#' @param id
#' @param expanded
#'
#' @return
#' @export
#'
#' @examples
dsfrAccordion <- function(..., title = NULL, id = NULL, expanded = FALSE) {
  tags$section(
    class = "fr-accordion",
    tags$h3(
      class = "fr-accordion__title",
      tags$button(
        class = "fr-accordion__btn",
        `aria-expanded` = if (expanded) "true" else "false",
        `aria-controls` = paste0("accordion-", id),
        title
      )
    ),
    tags$div(
      class = "fr-collapse",
      id = paste0("accordion-", id),
      ...
    )
  )
}



# tags$ul(
#   class = "fr-accordions-group",
#   tags$li(tags$section(
#     class = "fr-accordion",
#     tags$h3(
#       class = "fr-accordion__title",
#       tags$button(
#         class = "fr-accordion__btn",
#         `aria-expanded` = "false",
#         `aria-controls` = "accordion-89",
#         "IntitulÃ© accordÃ©on"
#       )
#     ),
#     tags$div(
#       class = "fr-collapse",
#       id = "accordion-89",
#       tags$comment()
#     )
#   )),
#   tags$li(tags$section(
#     class = "fr-accordion",
#     tags$h3(
#       class = "fr-accordion__title",
#       tags$button(
#         class = "fr-accordion__btn",
#         `aria-expanded` = "false",
#         `aria-controls` = "accordion-90",
#         "IntitulÃ© accordÃ©on"
#       )
#     ),
#     tags$div(
#       class = "fr-collapse",
#       id = "accordion-90",
#       tags$comment()
#     )
#   )),
#   tags$li(tags$section(
#     class = "fr-accordion",
#     tags$h3(
#       class = "fr-accordion__title",
#       tags$button(
#         class = "fr-accordion__btn",
#         `aria-expanded` = "false",
#         `aria-controls` = "accordion-91",
#         "IntitulÃ© accordÃ©on"
#       )
#     ),
#     tags$div(
#       class = "fr-collapse",
#       id = "accordion-91",
#       tags$comment()
#     )
#   ))
#

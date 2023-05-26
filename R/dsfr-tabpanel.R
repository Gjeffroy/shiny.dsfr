#' Tabpanel
#'
#' @param ... tagList
#' @param id id
#' @param role tabpanel, navbarpanel, navbarsidepanel
#' @param title the title is keep
#'
#' @return tabpanel
#' @export
#'
#' @importFrom attempt try_catch
#' @importFrom  htmltools tagQuery div
#'

dsfrTabPanel <- function(..., id = NULL, title = NULL, role = "tabpanel"){
  class <- "fr-tabs__panel"
  id <- paste0(role,"-panel-",id)
  if (role %in% c("navbarpanel", "navsidebarpanel")) {
    class <- paste0(class, "_", role)

    if (is.null(title)){
      title <- id
    }

  }

  #use in real tabs_panel
  tags$div(
    id = id,
    class = class,
    role = role,
    `aria-labelledby` = id,
    tabindex = "0",
    title = title,
    ...
  )
}


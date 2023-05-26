#' dsfrTabsetPanel
#'
#' @param ... dsfrTabPanel(role = tabpanel)
#' @param id the tabsetpanel id
#'
#' @return tabsetPanel
#' @export
#'
#' @importFrom rlang list2
#' @importFrom htmltools tagGetAttribute tagAppendChildren
#' @importFrom attempt try_catch
#'
#' @examples
#'
#' if (interactive()) {
#' dsfrTabsetPanel(id = "mon_panel1",
#'                 dsfrTabPanel(h4("Mon contenu 1"), id = "tab1", title = "Onglet 1", role = "tabpanel"),
#'                 dsfrTabPanel(h4("Mon contenu 2"), id = "tab2", title = "Onglet 2", role = "tabpanel")
#'                 )
#' }
#'
dsfrTabsetPanel <- function(..., id = NULL) {
  div_wrapper <- tags$div(class = "fr-tabs")
  ul_wrapper <- tags$ul(class = "fr-tabs__list",
                        role = "tablist",
                        `aria-label` = id)
  panels <- rlang::list2(...)
  li_panels_list <- htmltools::tagList()
  panels_list <- htmltools::tagList()
  id_panel <- 1
  #return(panels)
  for (i in seq_along(panels)){
    panel <- panels[[i]]
    attempt::try_catch( {
      #it is really a tabpanel ?
      is_tabsetpanel <- grepl("fr-tabs__panel", tagGetAttribute(panel, "class"))
      if (is_tabsetpanel) {
        # we add the tabsetpanel id and the number of tabpanel
        panel$attribs$id <- paste0( id,"-", panel$attribs$id,"-", id_panel)
        panel$attribs$`aria-labelledby` <- paste0(
          id, "-", panel$attribs$`aria-labelledby`, "-", id_panel)
        if (id_panel == 1) {
          panel$attribs$class <- paste(
            panel$attribs$class,
            "fr-tabs__panel--selected"
          )
        }
        id_panel <- id_panel + 1
        panels_list <- htmltools::tagList(panels_list, panel)
        li_panels_list <- htmltools::tagList(li_panels_list, li_button_from_panel(panel))
      }
    },
    .e = ~ paste0("Error : this is not a tabpanel", .x)
    )
  }
  #return(tagAppendChildren(ul_wrapper,li_panels_list))
  div_wrapper %>%
    htmltools::tagAppendChildren(
      ul_wrapper %>% htmltools::tagAppendChildren(li_panels_list),
      panels_list
    )
}

li_button_from_panel <- function (panel) {
  is_selected <-  grepl("fr-tabs__panel--selected", tagGetAttribute(panel, "class"))
  tags$li(
    role = "presentation",
    tags$button(
      id = panel$attribs$`aria-labelledby`,
      class = "fr-tabs__tab fr-fi-checkbox-line fr-tabs__tab--icon-left",
      tabindex = "0",
      role = "tab",
      `aria-selected` = if (is_selected) "true" else "false",
      `aria-controls` = panel$attribs$id,
      panel$attribs$title
    )
  )
}

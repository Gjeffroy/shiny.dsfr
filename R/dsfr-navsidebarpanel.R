#'  Ajoute un menu latéral de navigation
#'
#' @param ... dsfrTabPanel...
#' @param position La position du panneau de navigation : "left" ou "right"
#' @param fluid Pour utiliser les marges externes ou non : TRUE (sans marges) FALSE (avec marge par défaut)
#' @param gutters Pour utiliser les gouttières : TRUE (avec) FALSE (sans par défaut)
#' @param horizontal_align Pour aligner le contenu horizontalement ("center" par défaut, "left", "right")
#' @param vertical_align Pour aligner le contenu verticalement ("middle", "top", "bottom")
#' @param spacing_class Pour ajuster l'espacement :  "fr-my-4w" (par défaut)
#' @param width La largeur du panneau, entre 1 et 12 : 3 (par défaut)
#' @param id Identifiant du panneau (facultatif mais conseillé)
#' @param hide_panel Pour activer le javascript afin de masquer les dsfrTabPanel associé
#' @param title Le titre du panneau de navigation
#' @param title_burger Le titre du menu burger du panneau : "Dans cette rubrique" (par défaut)
#'
#' @return Renvoie le contenu avec un menu latéral de navigation
#' @export
#'
#' @importFrom htmltools tagList tagGetAttribute tagAppendChildren
#' @importFrom rlang list2
#'
#' @examples
#'
dsfrNavSidebarPanel <- function (...,
                                 position = c("left", "right"),
                                 fluid = FALSE,
                                 gutters = FALSE,
                                 horizontal_align = "center",
                                 vertical_align = "top",
                                 spacing_class = "fr-my-4w",
                                 width = 3,
                                 hide_panel = TRUE,
                                 id = NULL,
                                 title = NULL,
                                 title_burger = "Dans cette rubrique") {
  position <- match.arg(position)

  nav_wrapper <- tags$nav(
    class = "fr-sidemenu",
    class= "fr-sidemenu--sticky-full-height",
    `aria-label` = "Menu lat\u00e9ral",
    tags$div(
      class = "fr-sidemenu__inner",
      tags$button(
        class = "fr-sidemenu__btn",
        hidden = NA,
        `aria-controls` = "fr-sidemenu-wrapper",
        `aria-expanded` = "false",
        title_burger
      ),
      tags$div(
        class = "fr-collapse",
        id = "fr-sidemenu-wrapper",
        tags$div(
          class = "fr-sidemenu__title",
          title
        ),
        tags$ul(
          class = "fr-sidemenu__list"
        )
      )
    )
  )


  dots_tags <- tagList(...)
  li_panels_list <- tagList()
  panels_list <- tagList()
  id_panel <- 1
  for (i in seq_along(dots_tags)){
    #panel <- dots_tags[[i]]
    attempt::try_catch( {
      #it is really a tabpanel ?
      is_tabsetpanel <- grepl("fr-tabs__panel_navsidebarpanel", tagGetAttribute(dots_tags[[i]], "class"))
      is_first <- i == 1
      if (is_tabsetpanel) {
        dots_tags[[i]]$attribs$id <- paste0(id,'-', dots_tags[[i]]$attribs$id)
        id_panel <- id_panel + 1
        li_panels_list <- tagList(li_panels_list, li_from_panel(dots_tags[[i]], id, is_first, hide_panel))
      }
    },
    .e = ~ paste0("Error : this is not a tabpanel", .x)
    )
  }
  navbar <- nav_wrapper %>%
    htmltools::tagAppendChildren(li_panels_list, .cssSelector = "ul")

  dsfrSidebarLayout(
    sidebarPanel = dsfrCol(navbar, width = width),
    mainPanel = dsfrCol(width = 12 - width, dots_tags),
    position = position,
    fluid = fluid,
    gutters = gutters,
    horizontal_align = horizontal_align,
    vertical_align= vertical_align,
    spacing_class = spacing_class
  )
}


li_from_panel <- function (panel, id, is_first, hide_panel) {
  tags$li(
    class = "fr-sidemenu__item",
    tags$a(
      id = paste0('link-', panel$attribs$id),
      class = "fr-sidemenu__link",
      href = paste0("#", panel$attribs$id),
      `aria-current` = if (is_first) "page" else NULL,
      tabpanel = if (hide_panel) "hide" else NULL,
      target = "_self",
      panel$attribs$title
    )
  )
}


#' Ajoute la section du footer
#'
#' @param marianne_title Le titre utilisé dans le bloc marianne du footer
#' @param marianne_href  Le lien de redirection (accueil par defaut)
#' @param marianne_href_title Le titre utilisé dans l'info bulle
#' @param description
#' @param content_links Une liste de lien vers d'autres contenus
#' list(
#' list(href= "https://legifrance.gouv.fr", title = "legifrance.gouv.fr"),
#' list(href= "https://gouvernement.fr", title = "gouvernement.fr"),
#' list(href= "https://service-public.fr", title = "service-public.fr"),
#' list(href= "https://data.gouv.fr", title = "data.gouv.fr"))
#' @param bottom_links Une liste de liens divers
#'
#' @return le footer
#' @export
#'
#' @examples
#'  if (interactive()) {
#'  dsfrFooter(
#'  marianne_title = "République$française",
#' marianne_href = "/",
#'  marianne_href_title = "Retour à l'accueil",
#'  description = NULL,
#'  content_links = list(
#'    list(href = "https://legifrance.gouv.fr", title ="legifrance.gouv.fr"),
#'    list(href = "https://gouvernement.fr", title ="gouvernement.fr"),
#'    list(href = "https://service-public.fr", title ="service-public.fr"),
#'    list(href = "https://data.gouv.fr", title = "data.gouv.fr")),
#'  bottom_links = list(
#'  list(href = "#", title = "Plan du site"),
#'  list(href = "#", title = "Accessibilité conforme"),
#'  list(href = "#", title = "Mentions légales"),
#'  list(href = "#", title = "Données personnelles"))
#')
#'}
#'
dsfrFooter <- function(
  marianne_title = "R\u00e9publique$fran\u00e7aise",
  marianne_href = "/",
  marianne_href_title = "Retour \u00e0 l'accueil",
  description = NULL,
  content_links = list(
    list(href= "https://legifrance.gouv.fr", title = "legifrance.gouv.fr"),
    list(href= "https://gouvernement.fr", title = "gouvernement.fr"),
    list(href= "https://service-public.fr", title = "service-public.fr"),
    list(href= "https://data.gouv.fr", title = "data.gouv.fr")
    ),
  bottom_links = NULL
) {

  footer_content_links <- generate_footer_links(content_links, "content")
  footer_bottom_links <- generate_footer_links(bottom_links, "bottom")

  tags$footer(
    class = "fr-footer",
    role = "contentinfo",
    id = "footer",
    tags$div(
      class = "fr-container",
      tags$div(
        class = "fr-footer__body",
        tags$div(
          class = "fr-footer__brand fr-enlarge-link",
          tags$a(
            href = "/",
            title = marianne_href_title,
            tags$p(
              class = "fr-logo",
              title = marianne_title,
              dollar_to_br(marianne_title)
            )
          )
        ),
        tags$div(
          class = "fr-footer__content",
          tags$p(
            class = "fr-footer__content-desc",
            description,
          ),
          #add footer content links
          footer_content_links
        )
      ),
      tags$div(
        class = "fr-footer__bottom",
        #add footer bottom links
        footer_bottom_links,
        tags$div(
          class = "fr-footer__bottom-copy",
          tags$p(
            "Sauf mention contraire, tous les contenus de ce site sont sous",
            tags$a(
              href = "https://github.com/etalab/licence-ouverte/blob/master/LO.md",
              target = "_blank",
              "licence etalab-2.0"
            )
          )
        )
      )
    )
  )


}


#' Generate all block footer links
#'
#' @param links
#' @param footer_class
#'
#' @return
#' @export
#'
#' @examples
#'
generate_footer_links <- function(
  links = NULL,
  footer_class = NULL) {
  generate_link <- function(.link) {
    generate_footer_link(.link, footer_class)
  }
  . <- NULL
  if (is.null(links)) {
    return(NULL)
  }
  purrr::map(links, generate_link) %>%
    purrr::reduce(tagList) %>%
    tagAppendChildren(footer_list_wrapper(footer_class), .)
}


#' Function to generate the footer wrapper list
#'
#' @param footer_class c("content", "bottom")
#'
#' @return ul wrapper
#'
#' @examples
footer_list_wrapper <- function(footer_class = "content") {
  tags$ul(
    class = paste0("fr-footer__",footer_class,"-list")
  )
}

#' Function to generate the footer link
#'
#' @param link a list with href and title
#' @inheritParams footer_list_wrapper
#' @return tag
#'
#'

generate_footer_link <- function(link = NULL, footer_class = "content") {
  footer_class <- paste0("fr-footer__", footer_class)
  footer_title <- if (!is.null(link$title)) link$title else link$href
  if (!is.null(link)) {
    tags$li(
      class = paste0(footer_class, "-item"),
      tags$a(
        class = paste0(footer_class, "-link"),
        href = link$href,
        footer_title
      )
    )
  }
}


#' Ajoute une entête
#'
#' @param marianne_title Le nom du ministère ou de la prefecture
#' @param service_title  Le nom du service
#' @param service_baseline Précision sur le service ou l'application
#' @param service_href Le lien de redirection (Accueil par défaut)
#' @param service_href_title Le titre du lien affiché en infobulle
#' @param enlarge_link  Elargit le lien au bloc (TRUE par defaut)
#' @param beta Badge beta (FALSE par defaut)
#' @param logo_src Chemin vers le logo
#' @param logo_alt Texte alternatif si le logo ne s'affiche pas
#' @param logo_style_width Taille du logo
#' @param ... Menu de navigation
#'
#' @return l'entête
#' @export
#'
#' @importFrom assertthat not_empty
#' @examples
#' if (interactive()) {
#'   dsfrHeader(
#'     marianne_title = "République$française",
#'     service_title = "Mon service",
#'     service_baseline = "Une information sur le service"
#'   )
#' }
#'
dsfrHeader <- function(
  ...,
  marianne_title = "R\u00e9publique$fran\u00e7aise",
  service_title = NULL,
  service_baseline = NULL,
  service_href = "/",
  service_href_title = service_title,
  logo_src = NULL ,
  logo_alt = "logo",
  logo_style_width ="width:3.5rem;",
  beta = FALSE,
  enlarge_link = TRUE
) {

  logo <- NULL

  if (assertthat::not_empty(logo_src)){
    logo <- tags$div(
      class = "fr-header__operator",
      tags$img(
        src = logo_src,
        class = "fr-responsive-img",
        style = logo_style_width,
        alt = logo_alt
      )
    )
  }

  header_service <-
    tags$div(
      class = "fr-header__service",
      tags$a(
        href = service_href,
        title = service_href_title,
        tags$p(
          class = "fr-header__service-title",
          service_title,
          if (beta) tags$span(class = "fr-badge fr-badge--sm fr-badge--green-emeraude","BETA")
        )
      ),
      tags$p(
        class = "fr-header__service-tagline",
        service_baseline
      )
    )


  tags$header(
    role = "banner",
    class = "fr-header",
    tags$div(
      class = "fr-header__body",
      tags$div(
        class = "fr-container",
        tags$div(
          class = "fr-header__body-row",
          tags$div(
            class = "fr-header__brand",
            class = if (enlarge_link) "fr-enlarge-link",
            tags$div(
              class = "fr-header__brand-top",
              tags$div(
                class = "fr-header__logo",
                tags$p(
                  class = "fr-logo",
                  dollar_to_br(marianne_title)
                )
              ),
              logo
            ),
            header_service
          )
        )
      )
    ),
    ...
  )
}


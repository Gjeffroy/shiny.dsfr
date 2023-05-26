
#' Row
#'
#' @param ...
#' @param fluid
#' @param gutters
#' @noRd
#' @return
#' @export
#'
dsfrRow <- function(
  ...,
  fluid = FALSE,
  gutters = FALSE,
  horizontal_align = c("center", "left", "right"),
  vertical_align = c("top", "bottom", "middle"),
  spacing_class = "fr-my-4w") {
  container_class <- "fr-container"
  grid_class <- "fr-grid-row"

  if (fluid) {
    container_class <- paste0(container_class, " fr-container--fluid")
  }

  if (gutters) {
    grid_class <- paste0(grid_class, " fr-grid-row--gutters")
  }

  horizontal_align <- match.arg(horizontal_align)
  horizontal_align <- paste0("fr-grid-row--", horizontal_align)

  vertical_align <- match.arg(vertical_align)
  vertical_align <- paste0("fr-grid-row--", vertical_align)

  div(
    class = container_class,
    div(
      class = grid_class,
      class = if (!is.null(spacing_class)) spacing_class,
      class = if (!is.null(horizontal_align)) horizontal_align,
      class = if (!is.null(vertical_align)) vertical_align,
      ...
    )
  )
}

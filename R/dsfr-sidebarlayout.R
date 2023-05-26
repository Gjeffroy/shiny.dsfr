#' SidebarLayout
#'
#' @param sidebarPanel
#' @param mainPanel
#' @param position
#' @param fluid
#' @param gutters
#' @param horizontal_align
#' @param vertical_align
#' @param spacing_class
#'
#' @return
#' @export
#'
#' @examples
dsfrSidebarLayout <- function (sidebarPanel, mainPanel, position = c("left", "right"),
                               fluid = FALSE,
                               gutters = FALSE,
                               horizontal_align = "center",
                               vertical_align = "top",
                               spacing_class = "fr-my-4w")
{
  position <- match.arg(position)
  if (position == "left") {
    firstPanel <- sidebarPanel
    secondPanel <- mainPanel
  }
  else if (position == "right") {
    firstPanel <- mainPanel
    secondPanel <- sidebarPanel
  }

  dsfrRow(
    firstPanel,
    secondPanel,
    fluid = fluid,
    gutters = gutters,
    horizontal_align = horizontal_align,
    vertical_align = vertical_align,
    spacing_class = spacing_class)
}

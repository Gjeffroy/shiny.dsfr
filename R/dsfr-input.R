


## SelectInput --------------

#' dsfrSelectInput
#'
#' @param inputId
#' @param label
#' @param choices
#' @param selected
#'
#'
#' @return
#' @export
#'
#' @examples
#'

dsfrSelectInput <- function(inputId, label, choices, selected = NULL, hint = NULL,
                            placeHolder = 'S') {

  selected <- restoreInput(id = inputId, default = selected)

  # resolve names
  choices <- choicesWithNames(choices)

  # default value if it's not specified
  if (is.null(selected)) {
    selected <- firstChoice(choices)
  } else selected <- as.character(selected)

  # create select tag and add options
  selectTag <- tags$select(
    id = inputId,
    class = "fr-select",
    name = inputId,
    selectOptions(choices, selected, inputId)
  )

  tags$div(
    class = "fr-select-group",
    tags$label(
      class = "fr-label",
      `for` = "select",
      "Label pour liste dÃ©roulante"
    ),
    selectTag
  )

  if (! is.null(hint)) {
    hintTag <- tags$span(
      class = "fr-hint-text",
      hint
    )
  } else {
    hintTag <- NULL
  }

  labelTag <- tags$label(
    class = "fr-label",
    `for` = paste0(inputId),
    label,
    hintTag
  )

  # return label and select tag
  res <- tags$div(
    class = "fr-select-group",
    labelTag,
    selectTag
  )

  res
}

# from shiny
firstChoice <- function(choices) {
  if (length(choices) == 0L) return()
  choice <- choices[[1]]
  if (is.list(choice)) firstChoice(choice) else choice
}

# Create tags for each of the options; use <optgroup> if necessary.
# This returns a HTML string instead of tags for performance reasons.
selectOptions <- function(choices, selected = NULL, inputId, perfWarning = FALSE) {
  if (length(choices) >= 1000) {
    warning("The select input \"", inputId, "\" contains a large number of ",
            "options; consider using server-side selectize for massively improved ",
            "performance. See the Details section of the ?selectizeInput help topic.",
            call. = FALSE)
  }

  html <- mapply(choices, names(choices), FUN = function(choice, label) {
    if (is.list(choice)) {
      # If sub-list, create an optgroup and recurse into the sublist
      sprintf(
        '<optgroup label="%s">\n%s\n</optgroup>',
        htmlEscape(label, TRUE),
        selectOptions(choice, selected, inputId, perfWarning)
      )

    } else {
      # If single item, just return option string
      sprintf(
        '<option value="%s"%s>%s</option>',
        htmlEscape(choice, TRUE),
        if (choice %in% selected) ' selected' else '',
        htmlEscape(label)
      )
    }
  })

  HTML(paste(html, collapse = '\n'))
}

# need <optgroup> when choices contains sub-lists
needOptgroup <- function(choices) {
  any(vapply(choices, is.list, logical(1)))
}

## Toggle switch --------------


#' Toggle switch
#'
#' @param inputId The id of the input object.
#' @param value checked \code{TRUE} or unchecked \code{FALSE}.
#' @param label The label to set for the input object.
#' @param hint The hint to set for the input object.
#' @param position_label_left \code{FALSE} (default) or \code{TRUE} to position the label to the left
#'
#' @return
#' @export
#'
#' @examples
#'
#'
dsfrToggleSwitch <- function(
  inputId,
  value = FALSE,
  label = NULL,
  hint = NULL,
  position_label_left = FALSE) {


  value <- shiny::restoreInput(id = inputId, default = value)

  inputTag <- tags$input(id = inputId, type = "checkbox")

  if (!is.null(value) && value)
    inputTag$attribs$checked <- "checked"

  if (!is.null(label) && ! label == "") {
    label <- tags$label(
      class = "fr-toggle__label",
      `for` = inputId,
      `data-fr-checked-label` = "Activé",
      `data-fr-unchecked-label` = "Désactivé",
      label
    )
  } else {
    label <- NULL
  }

  if (!is.null(hint) &&  ! hint == "") {
    hint <- tags$p(
      class = "fr-hint-text",
      id = paste0(inputId,"-hint-text"),
      hint
    )
  } else {
    hint <- NULL
  }


  tags$div(
    class = "fr-toggle",
    class = if(position_label_left) "fr-toggle--label-left",
    tags$input(
      type = "checkbox",
      class = "fr-toggle__input",
      `aria-describedby` = paste0(inputId, "-text"),
      id = inputId
    ),
    label
    ,
    hint
  )
}

#' Change the value of toggle switch on the client
#'
#' @param session The session object passed to function given to shinyServer.
#' @param inputId The id of the input object.
#' @param label The label to set for the input object.
#' @param hint The hint to set for the input object.
#' @param value The value to set for the input object.
#'
#' @return
#' @export
#'
updatedDsfrToggleSwitch <- function(session = getDefaultReactiveDomain(),
                               inputId,
                               label = NULL,
                               hint = NULL,
                               value = NULL) {
  message <- dropNulls(list(label = label, hint = hint, value = value))
  session$sendInputMessage(inputId, message)
}


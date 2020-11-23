# -----------------------------------------------------------------------------#
#' Upper 1st Character
#'
#' Capitalize the first character only
#'
#' @param x a string vector
#' @return a string vector
#'
#' @author Mun-Gwan Hong, \email{mungwan@gmail.com}
#' @export
# -----------------------------------------------------------------------------#
# created  : 2016-10-18 by Mun-Gwan
# -----------------------------------------------------------------------------#

toupper1 <- function(x) {
  stopifnot(is.character(x))
  paste0(
    toupper(substr(x, 1, 1)),
    substring(x, 2)
  )
}

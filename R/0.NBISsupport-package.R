#' NBISsupport : A collection of functions useful for support projects in NBIS
#'
#' This package includes functions that simplify works here and there
#'
#' @author Mun-Gwan Hong <\email{mungwan@gmail.com}>
#' @keywords package
#'
#' @docType package
#'
#' @name NBISsupport-package
#' @import dplyr
#'
NULL


.onAttach <- function(libname, pkgname){
  #  ref: https://stackoverflow.com/questions/41372146/test-interaction-with-users-in-r-package
  options(mypkg.connection = stdin())
}

# GLOBAL CONSTANTS

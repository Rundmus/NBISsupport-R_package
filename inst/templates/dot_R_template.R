# -----------------------------------------------------------------------------#
# {{{ title }}}
# -----------------------------------------------------------------------------#
rm(list = ls())

library(dplyr)
# library(tidyverse)
library(NBISsupport)    # english, english_cap1, enum_vars
  # renv::install("Rundmus/NBISsupport-R_package")

#----- File names --------------------------------------------------------------

fn <- list(
  i = list(                               #  input
  ),
  o = list(                               #  output
  )
)

#  Check all exists
stopifnot(all(file.exists(c('.', unlist(fn$i)))),
          all(file.exists(dirname(c('.', unlist(fn$o))))))

#----- MAIN --------------------------------------------------------------------

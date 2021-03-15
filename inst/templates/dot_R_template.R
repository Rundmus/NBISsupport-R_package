# -----------------------------------------------------------------------------#
# {{{ title }}}
# -----------------------------------------------------------------------------#
# initiated on {{{ date }}}
# authors :  {{{ author }}}
# -----------------------------------------------------------------------------#
rm(list = ls())

library(dplyr)
# library(readxl)
# library(tidyverse)
# library(NBISsupport)  # renv::install("Rundmus/NBISsupport-R_package")

#----- File names --------------------------------------------------------------

fn <- list(
  i = list(                               #  input
    # excel = list(    # Excel file
    #   path = "an_excel.xlsx",
    #   sheet = "sheet 1"
    # ),
    # tsv = "a_tsv.tsv"
  ),
  o = list(                               #  output
    # out1 = "../data/data1.RData",
    # out2 = "../data/data2.RData"
  )
)

#  Short check all exists
tmp <- unlist(c(fn$i, lapply(fn$o, dirname), "."))
stopifnot(all( file.exists(tmp[!grepl("\\.sheet", names(tmp))]) )); rm(tmp)

# Confirm if all files exist and are the same as before using MD5 hash
stopifnot(
  all(file.exists(c('.', unlist(fn$i), dirname(unlist(fn$o))))),
  digest::digest(fn$i$file1, file = T) == "[[MD5_hash]]"
)

#----- MAIN --------------------------------------------------------------------

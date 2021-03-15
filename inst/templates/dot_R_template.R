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
    # clinic = "an_clinical.xlsx",
    # tsv = "a_tsv.tsv"
  ),
  o = list(                               #  output
    # c01 = "../data/s1-clinical.v01.RData"
    # olk01 = "../data/s2-olink_proteomic.v01.RData"
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

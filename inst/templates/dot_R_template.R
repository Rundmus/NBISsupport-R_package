# -----------------------------------------------------------------------------#
# {{{ title }}}
# -----------------------------------------------------------------------------#
# initiated on {{{ date }}}
# authors :  {{{ author }}}
# -----------------------------------------------------------------------------#
rm(list = ls())

# Please note some functions are called directly using '::' or ':::'
library(tidyverse)
# library(NBISsupport)  # renv::install("Rundmus/NBISsupport-R_package")

#----- File names --------------------------------------------------------------

fn <- list(
  lib = "utils.R",
  i = list(                               #  input
    # clinic = "../data/raw_internal/20210101/an_clinical.xlsx",   # use readxl::read_xlsx
    # tsv = "../data/raw_internal/20210101/a_tsv.tsv"
  ),
  o = list(                               #  output
    # c01 = "../data/s1-clinical.v01.RData"
    # olk01 = "../data/s2-olink_proteomic.v01.RData"
  )
)

# Brief check if all files exist
stopifnot(all(file.exists(fn$lib, unlist(fn$i), dirname(unlist(fn$o)))))
# Warn any difference in input file(s) using MD5 hash
if(!all(
  tools::md5sum(fn$i$file1) == "MD5_hash"
)) warning(
  "One input file or more is not exactly identical to the one used during ",
  "development of this script."
)

#----- MAIN --------------------------------------------------------------------

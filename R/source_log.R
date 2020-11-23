# -----------------------------------------------------------------------------#
#' Source & log
#'
#' Execute a script while writing a log to keep the history. The log file is
#' created at the path given as \var{path}. If it is not available, the file
#' can be found where the R script \var{file} is. Automatically, the execution
#' date is added into the log file name. Loaded packages in the script are
#' listed in the log.
#'
#' @param file the name of R file to be run
#' @param echo same as 'echo' in \code{\link{source}}
#' @param path log output directory, relative path from the current
#'
#' @seealso \code{\link{source}}
#'
#' @export
#' @importFrom utils capture.output packageVersion
# -----------------------------------------------------------------------------#

.source <- function(file, echo= F, path = "../logs") {
  Rscript <- readLines(file)

  fDir <- dirname(file)
  # make it absolute file path
  if(!grepl("^/", fDir)) fDir <- file.path(getwd(), fDir)

  logDir <- file.path(fDir, path)    # log output directory
  if(! file.exists(logDir)) logDir <- fDir

  # Find the name of log file
  fn <- basename(file) %>%
    # Remove leading digit followed by character. Such prefix is often used to
    # indicate the order of multiple scripts. But, the order is frequently
    # changed.
    sub("^[[:digit:]][[:alpha:]]?_", "", .) %>%
    sub("(.*)\\.R$", "\\1", .) %>% 	             # remove the extension ".R"
    paste0(., "--", format(Sys.Date(), "%Y%m%d"), ".log") %>%  # add date and ".log"
    file.path(logDir, .)


  tmp <- Rscript %>%
    sub("#.*", "", .)   # remove text after the comment mark '#'

  loadedPackages <- c(
    #  Find the version of loaded packages by 'library' or 'require'
    tmp[grep("\\<(library|require)\\(\\w*\\)", tmp)] %>%
      regmatches(., regexpr("(library|require)\\(\\w*", .)) %>%
      sub("(library|require)\\(", "", .),
    #  Find the version of loaded packages by function direct access
    tmp[grep("[\\:]{2,3}[[:alpha:]\\._]", tmp)] %>%  #  lines with ::
      strsplit("[\\:]{2,3}") %>%       #  multiple occasions of ::
      lapply(function(x) x[ -length(x) ]) %>%       #   remove the last text
      unlist() %>%
      regmatches(., regexpr("[[:alnum:]]+$", .))
  ) %>%
    unique()

  #  package versions
  loadedPackages <- loadedPackages %>%
    sapply(., function(ea) paste0(ea, "-", utils::packageVersion(ea)))


  ##  processing time
  ptm <- proc.time()
  utils::capture.output(
    cat("Date :", as.character(Sys.time()), "\n*", R.version.string, "\n"),
    if (length(loadedPackages) == 0)
      cat("\n")
    else
      cat("*", paste(loadedPackages, sep = ", "), "\n\n"),
    source(file, echo = echo),
    cat("\n"),
    print(proc.time() - ptm),
    file = fn
  )

  if(!echo) {
    cat("\n\n", rep("=", 45), " R script ", rep("=", 45), "\n\n", sep="",
        file= fn, append= TRUE)
    cat(Rscript, sep="\n", file= fn, append= TRUE)
  }

  return(invisible(NULL))
}

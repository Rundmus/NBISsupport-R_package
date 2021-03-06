# -----------------------------------------------------------------------------#
#' Use a template
#'
#' @param file The name of generating file
#' @param extension the extension of the `file`
#' @param template_file the template for the `file`
#'
#' @author Mun-Gwan Hong, \email{mungwan@gmail.com}
#' @return a file created
# -----------------------------------------------------------------------------#

use.template <- function(file, extension, template_file) {
  stopifnot( !missing(file) )

  #  template_path = path to the template file
  template_path <- system.file(
    "templates", template_file,
    package= "NBISsupport",
    mustWork= TRUE
  )

  ext_pattern <- paste0("\\", extension, "$")
  title <- sub(ext_pattern, "", basename(file))
  date <- Sys.Date()

  ##  Substitute the entities in the templates with the given values in this
  ##  function
  out_text <- readLines(template_path) %>%
    gsub('\\{\\{\\{ title \\}\\}\\}', title, .) %>%
    gsub('\\{\\{\\{ date \\}\\}\\}', as.character(date), .) %>%
    gsub('\\{\\{\\{ author \\}\\}\\}',
         tools::toTitleCase(gsub("\\.", " ", ps::ps_username())), .)  # user name

  ##  allow both with or without extension in 'file'
  base_fn <- sub(ext_pattern, "", basename(file))
  base_fn.ext <- paste0(base_fn, extension)
  path <- file.path(dirname(file), base_fn.ext)

  #  when the file already exists
  if(file.exists(path)) {
    cat('# The file \"', base_fn.ext, '\" already exists. Overwrite (y/n)? ', sep= "")
    #  ref: https://stackoverflow.com/questions/41372146/test-interaction-with-users-in-r-package
    ans <- readLines(con = getOption("mypkg.connection"), n= 1)
    cat("\n")

    if(tolower(ans) != "y") {
      message('# No change.')
      return(invisible(TRUE))
    }
  }

  #  **  Write the text from the template after modification  **  #
  writeLines(out_text, path)

  message('# The file \"', base_fn.ext, '\" has been created.')

  invisible(path)
}



# -----------------------------------------------------------------------------#
#' Use .R[md] template
#'
#' Create .R or .Rmd file using a template that includes header lines
#'
#' @param file The name of generating file. The ".R" or ".Rmd" extension will be
#'   added if it is missing.
#'
#' @examples
#' \dontrun{
#' use.R_template("process_data")
#' }
#'
#' @author Mun-Gwan Hong, \email{mungwan@gmail.com}
#' @importFrom tools toTitleCase
#' @importFrom ps ps_username
#' @export
#'
#' @rdname use_template
# -----------------------------------------------------------------------------#

use.R_template <- function(file) {
  use.template(
    file = file,
    extension = ".R",
    template_file= "dot_R_template.R"
  )
}



# -----------------------------------------------------------------------------#
#' @examples
#' \dontrun{
#' use.Rmd_template("process_data")
#' }
#'
#' @export
#'
#' @rdname use_template
# -----------------------------------------------------------------------------#
# created  : 2020-05-08 by Mun-Gwan
# modified :
# -----------------------------------------------------------------------------#

use.Rmd_template <- function(file) {
  use.template(
    file = file,
    extension = ".Rmd",
    template_file= "dot_Rmd_template.Rmd"
  )
}





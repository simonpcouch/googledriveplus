#' Load a drive file into a dataframe
#'
#' @description This function grabs a dataset from Google Drive and returns
#' it as an R dataframe object. You might need to run `drive_auth()` before
#' running this to get your Google account credentials set up.
#' @param url The link to the desired file obtained by "get shareable link" (the
#' user must have at least viewing access to the file). Can be either a `.csv`,
#' Google Sheets, or `.Rda` file.
#' @param filetype A character vector specifying the filetype. Either "csv",
#' "Sheet", or "Rda".
#' @param ... Additional arguments to supply to `read_csv()`.
#' @export
#' @examples
#' \dontrun{
#' # Grab a very useful dataset
#' grab_data(url = "https://drive.google.com/open?id=1JnkQddF8FmY0YsXZSWBanQNPjZ_LBIQUGi_s43vNDIQ",
#'           filetype = "Sheet")
#'
#' # Send extra arguments to read_csv
#' grab_data("https://drive.google.com/file/d/10j5nM5Wu27S5-kIsf1x6HlkLpOKvcqhE/view?usp=sharing",
#'           "csv",
#'           col_types = cols(compelling_narrative = col_character(),
#'                            index = col_integer()))
#' }
grab_data <- function(url, filetype, ...) {

  # check the arguments real quick!
  if (!filetype %in% c("csv", "Sheet", "Rda")) {
    stop(sprintf("Please supply one of \"csv\", \"Sheet\", or \"Rda\" for the
                 filetype argument."))
  }

  if (!RCurl::url.exists(url)) {
    stop(sprintf("It looks like the supplied URL doesn't exist. Please
                 check that the URL is correct and that you have permission
                 to access the supplied file."))
  }

  if (filetype != "Rda") {
    # make a temporary filepath
    path <- tempfile(fileext = ".csv")

    # download the google drive data to that filepath
    suppressMessages(googledrive::drive_download(file = googledrive::as_id(url),
                                                 path = path,
                                                 type = "csv"))

    # load in the data to R
    data <- suppressMessages(readr::read_csv(path, ...))
  } else {
    path <- tempfile(fileext = ".Rda")

    suppressMessages(googledrive::drive_download(file = googledrive::as_id(url),
                                                 path = path))

    # thanks to https://stackoverflow.com/questions/5577221/how-can-i-load-an-object-into-a-variable-name-that-i-specify-from-an-r-data-file
    # for this function!
    load_obj <- function(file_path)
    {
      environment <- new.env()
      data <- load(file_path, environment)[1]
      environment[[data]]
    }

    data <- load_obj(path)
  }

  # get rid of the temporary stuff!
  unlink(path)
  rm(path)

  # ...and return the data!
  data
}




#!/usr/bin/env Rscript

args <- commandArgs(TRUE)

if (length(args) < 1) {
  stop("Please provide at least one file", call. = FALSE)
}

verbose <- any(args == "-v")
args <- args[args != "-v"]

# Keep in function so unlink() can work lazily
render <- function(path) {
  # Localize to project wd if not absolute path
  if (!grepl("^/", path)) {
    path <- here::here(path)
  }

  directory <- dirname(path)
  original <- basename(path)
  filename <- gsub("\\..*$", "", original)
  rmd_file <- file.path(directory, paste0(filename, ".Rmd"))
  pdf_file <- file.path(directory, paste0(filename, ".pdf"))

  file.copy(
    from = path,
    to = rmd_file,
    overwrite = TRUE
  )

  on.exit(unlink(rmd_file))
  rmarkdown::render(rmd_file, output_file = pdf_file, quiet = !verbose)
}

lapply(args, render)

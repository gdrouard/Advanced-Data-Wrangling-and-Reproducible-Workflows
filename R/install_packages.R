# Run once: source("R/install_packages.R")
# Installs the packages used in the course (only the ones that are missing).
pkgs <- c(
  "tidyverse", "broom", "here", "httr2", "jsonlite",
  "readxl", "tidyxl", "unpivotr", "pdftools",
  "knitr", "rmarkdown", "quarto", "usethis"
  # "tabulapdf"   # needs Java; add it only once Java is set up (locally and in CI)
)

missing <- setdiff(pkgs, rownames(installed.packages()))
if (length(missing)) install.packages(missing) else message("All packages already installed.")

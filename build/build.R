rm(list = ls())

current_path = rstudioapi::getActiveDocumentContext()$path ## this is RStudio specific
setwd(dirname(current_path ))
setwd('..')

## everything below is based on the main file path set here
main.fp <- getwd()

data.path <- file.path(main.fp, "data")
results.path<-file.path(main.fp, "results/tables")
build.path<-file.path(main.fp,"build")

source("README.R")
source("metadata/metadata.R")
source("data/site-year data.R")
source("data/collector data.R")
source("data/biological data.R")
source(paste0(build.path,"/annual_summary_results.R"))###annual summary data- currently 2020

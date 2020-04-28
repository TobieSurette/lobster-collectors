library(EML)
library(emldown)

abstract <- set_methods("metadata/abstract.md") # Define data abstract.
methods <- set_methods("metadata/methods.md")   # Define data methods.

# Define people:
Denis   <- as_emld(list(given = "Denis",   family = "Gagnon",  email = "Denis.Gagnon@dfo-mpo.gc.ca"))
Natalie <- as_emld(list(given = "Natalie", family = "Asselin", email = "Natalie.Asselin@dfo-mpo.gc.ca"))
Tobie   <- as_emld(list(given = "Tobie",   family = "Surette", email = "Tobie.Surette@dfo-mpo.gc.ca"))
Amelie  <- as_emld(list(given = "Amelie",  family = "Rondeau", email = "Amelie.Rondeau@dfo-mpo.gc.ca"))

# Keywords related to study:
keywords <- list(
    list(keywordThesaurus = "Species",
         keyword = list("lobster", "amercian lobster", "homarus", "americanus",
                        "atlantic", "rock", "crab", "cancer", "irroratus")),
    list(keywordThesaurus = "Subject",
         keyword =  list("yoy", "young-of-the-year", "recruitment", "larvae", "collector")),
    list(keywordThesaurus = "Location",
         keyword = list("southern", "gulf", "saint", "lawrence", "sgsl", "PEI",
                        "coastal", "atlantic", "canada")),
   list(keywordThesaurus = "Project",
         keyword =  list("alsi", "atlantic", "lobster", "settlement", "index"))
)

# Site table:
site.attr <- read.csv("metadata/DataDict_Site.csv", header = TRUE, stringsAsFactors = FALSE)

DFO_address <- eml$address(deliveryPoint     = "343 University Avenue",
                          city               = "Moncton",
                          administrativeArea = "NB",
                          postalCode         = "E1C 9B6",
                          country            = "Canada")

contact <- list(individualName        = Natalie$individualName,
                electronicMailAddress = Natalie$electronicMailAddress,
                address               = DFO_address,
                organizationName      = "Department of Fisheries and Oceans")

# Read site data:
sites <- read.csv("data/site.csv", header = TRUE, stringsAsFactors = FALSE)
sites$date.deployed <- as.Date(sites$date.deployed)
sites$date.retrieved <- as.Date(sites$date.retrieved)

# Define spatio-temporal coverage:
coverage <- set_coverage(beginDate = as.character(min(sites$date.deployed)), 
                         endDate = as.character(max(sites$date.retrieved)),
                         sci_names = c("Homarus americanus", "Cancer irroratus"),
                         geographicDescription = "southern Gulf of Saint Lawrence", 
                         westBoundingCoordinate = min(sites$longitude, na.rm = TRUE), 
                         eastBoundingCoordinate = max(sites$longitude, na.rm = TRUE),
                         northBoundingCoordinate = min(sites$latitude, na.rm = TRUE), 
                         southBoundingCoordinate = max(sites$latitude, na.rm = TRUE))

# Physical file pointer:
site.file <- "data/site.csv"
site.physical <- set_physical(site.file, 
                              size = as.character(file.size(site.file)),
                              authentication = digest::digest(site.file, algo = "md5", file = TRUE),
                              authMethod = "MD5")

# Create data table:
site.dataTable <- list(entityName = "site.csv",
                       entityDescription = "Larvae Collector Sampling Sites",
                       physical = physical,
                       attributeList = attributeList)

# Site table attributes:
site.attr.file <- "metadata/DataDict_Site.csv"
site.attr <- read.csv(site.attr.file, header = TRUE, stringsAsFactors = FALSE)
site.attr <- set_attributes(site.attr, col_classes = c("Date", "character", "numeric", "numeric", "Date", "Date", "character"))

# Define dataset:
site.dataset <- list(title = "Atlantic Lobster Settlement Index - southern Gulf of Saint Lawrence",
                     creator    = Natalie,
                     pubDate    = 2020,
                     abstract   = abstract,
                     methods    = methods,
                     keywordSet = keywords,
                     coverage   = coverage,
                     contact    = contact,
                     dataTable  = site.dataTable)

site.eml <- list(packageId     = uuid::UUIDgenerate(),
                 system        = "uuid",
                 dataset       = site.dataset)

eml_validate(site.eml)

write_eml(site.eml, "metadata/site.xml")

render_eml("metadata/site.xml", outfile = "site.html", output_dir = "/metadata/")

# Sections copié du metadata system à Fishman

# Section (Region / Branch / Division / Section)
# Gulf - Science - Fisheries and Ecosystem Sciences - Crustaceans
#
# Status = "ongoing"
#
# Maintenance frequency = "Annually"
#
# Purpose (English) = "Monitor lobster and rock crab young-of-the-year annual recruitment"
# Description (English) = "Lobster and rock crab counts and measurements and temeprature observations."
#
# Start year = 2008
#
# Resource constraint (English) = "Species counts are unstandardized."
#
# QC process description (English) = "Data are checked annually for irregularities and errors."
#
# Security use limitation (English) = "No limitations"
#
# Security classification = "Unclassified"�ed
#
# Storage notes = "Distribution format = "CSV (comma-separated-values) and text files."
#
# Data character set = "usAscii"
#
# Spatial representation = "point"
#
# Spatial reference system = EPSG:4269 LL (Nad83)
#
# Geographic description (English)
# NAFO Fising Division = "4T"�shing division 4T
#
# Parameters collected (English)
# species counts (ecological); temperature (environmental);
# CTD pro


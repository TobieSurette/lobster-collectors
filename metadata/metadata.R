library(EML)

# Define data abstract:
abstract_file <- readLines("metadata/abstract.md")
abstract <- set_methods(abstracts_file)

# Define data methods:
methods_file <- readLines("metadata/methods.md")
methods <- set_methods(methods_file)

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

# Document data dition
c("year", "site", "collector", "species", "sex", "size", "weight", "comment")

~attributeName = c("year", "site", "collector", "species", "sex", "size", "weight", "comment")
~attributeDefinition =
~formatString = c("YYYY", NA
~definition,
~unit,
~numberType = "integer", "string",

DFO_address <- eml$address(deliveryPoint     = "343 University Avenue",
                          city               = "Moncton",
                          administrativeArea = "NB",
                          postalCode         = "E1C 9B6",
                          country            = "Canada")

contact <- list(individualName        = Natalie$individualName,
                electronicMailAddress = Natalie$electronicMailAddress,
                address               = DFO_address,
                organizationName      = "Department of Fisheries and Oceans")


my_eml <- eml$eml(packageId = uuid::UUIDgenerate(),
                  system    = "uuid",
                  dataset   = eml$dataset(),
                  title     = "Larval Settlement Index for the southern Gulf of Saint Lawrence",
                  creator   = data.manager,
                  pubDate   = "2020",
                  intellectualRights = "http://www.lternet.edu/data/netpolicy.html.",
                  abstract   = abstract,
                  keywordSet = keywordSet,
                  coverage   = coverage,
                  contact    = contact,
                  methods    = methods,
                  dataTable  = eml$dataTable(
                  entityName = "biological.csv",
                  entityDescription = "Coastal Larvae Collector",
                  physical   = physical,
                  attributeList = attributeList)
               ))

eml_validate(my_eml)

write_eml(my_eml, "eml.xml")

    
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
# West bounding coordinate  =
# South bounding coordinate =
# East bounding coordinate  =
# North bounding coordinate =
#
# Parameters collected (English)
# species counts (ecological); temperature (environmental);
# CTD pro


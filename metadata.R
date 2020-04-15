library(EML)

# Define data abstract:
abstract <- "First-year recruits (i.e. young-of-the-year) of Atlantic lobster (Homarus americanus) and
             rock crab (Cancer irroratus) were counted and measured using larval settlement collectors
             at various coastal sampling sites in the southern Gulf of Saint Lawrence, Canada. This project
             is part of a larger Atlantic Lobster Settlement Index (ALSI) program which spans a large part
             of the species' western Atlantic range."

abstract <- set_TextType(abstract)
- Cape cod, Gulf of Maine, Bay of Fundy, southern Gulf of Saint Lawrence, Nova Scotia and Eastern
  and Northern Newfoundland.
- Along with larval collectors, includes a suction sampling component, which represents an active sampling
  method for all lobster sizes.

- Do figure on deployment and retrieval dates for each site through the years.
 - Early-mid july deployment and late sept to early october retrieval

- Plans to do an instar focused mixture analysis:
     - Good knowledge of instar appearance to identify which instars originate in the sampling year.
  Issues:
     - One year recruits in collectors underrepresented with respect to suction samples at the same
       sampling site.
     - May be talking about the gap between yoy and small walk-ins. i.e. reduced mobility of these sizes.
   - People seem to be seeing smaller and smaller instars, try and determine the mean instar sizes and
       abundances through time
   - There are worries about delays in deployement or retrieval times. Can we use these to to predict
       recrtuitment observations? Can we use depth or temperature observations?
   - Where are the associated Minilog temperature observations for the collectors?

- Include collector temperature data somewhere




-
# Define data methods:
methods <- "Collectors are specially contruncted cages (dimensions?) containing gravel and rock substrate
            deemed suitable for settlement of American lobster larvae. Sets of 30 collectors are placed at
            each site. Collectors are deployed in early summer and rertrieved in early fall, before and after the
            larval settlement period, respectively."

methods <- set_methods(methods)

# Define set of keywords related to study:
keywords <- list(
    list(keywordThesaurus = "Species",
         keyword = list("lobster", "amercian lobster", "homarus", "americanus",
                        "atlantic", "rock", "crab", "cancer", "irroratus")),
    list(keywordThesaurus = "Subject",
         keyword =  list("yoy", "young-of-the-year", "recruitment", "larvae", "collector")),
    list(keywordThesaurus = "Location",
         keyword = list("southern", "gulf", "saint", "lawrence", "sgsl", "PEI",
                        "coastal", "atlantic", "canada"))
)

# Define important people:
Denis <- as_emld(list(given = "Denis", family = "Gagnon",
                      email = "Denis.Gagnon@dfo-mpo.gc.ca",
                      role  = "data manager"))

Natalie <- as_emld(list(given = "Natalie", family = "Asselin",
                        email = "Natalie.Asselin@dfo-mpo.gc.ca",
                        role  = "project lead"))

Tobie <- as_emld(list(given = "Tobie", family = "Surette",
                      email = "Tobie.Surette@dfo-mpo.gc.ca",
                      role  = "package author"))

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
                  dataset   = eml$dataset(
                  title     = "Thresholds and Tipping Points in a Sarracenia",
                  creator   = data.manager,
                  pubDate   = "201",
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
# Status
# ongoing
# 
# Maintenance frequency
# Annually
# 
# Purpose (English)
# 
# Description (English)
# 
# Start day Start month Start year
# 
# End day End month End year
# 
# Resource constraint (English)
# 
# QC process description (English)
# Data are checked for irregularities and errors.
# 
# Security use limitation (English)
# No limitations
# 
# Security classi􀂦cation
# Unclassi􀂦ed
# 
# Storage notes
# 
# Distribution format
# CSV
# 
# Data character set
# usAscii
# 
# Spatial representation type
# vector
# 
# Spatial reference system
# EPSG:4269 LL (Nad83)
# 
# Geographic description (English)
# NAFO 􀂦shing division 4T
# 
# West bounding coordinate
# -65.6298
# South bounding coordinate
# 45.94607
# East bounding coordinate
# -60.3697
# North bounding coordinate
# 48.93528
# 
# Parameters collected (English)
# species counts (ecological); temperature (environmental);
# CTD pro


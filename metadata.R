library(EML)

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

# Define people:
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

contact <- list(individualName        = data.manager$individualName,
                electronicMailAddress = data.manager$electronicMailAddress,
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


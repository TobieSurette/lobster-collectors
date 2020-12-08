# Define variables to keep in the output:
vars <- c("year", "site", "collector", "species", "sex", "size", "weight", "comment")

# Load data:
y <- read.csv("data/raw/129_Crab_Fish_table.csv", stringsAsFactors = FALSE)
names(y) <- tolower(names(y))

y$year <- y$r_year
y$species <- paste(y$genus, y$species)
y$site <- y$site_name
y$collector <- y$coll_no
y$size <- y$length_mm
y$weight <- y$weight_g
y$sex <- toupper(y$sex)
y$sex[y$sex == "2"] <- "F"
y$comment <- y$comments

y$species <- deblank(y$species)
y$species[is.na(y$species)] <- ""

# Size measurements but no species ID:
# excel(y[which((y$species == "") & !is.na(y$size)), ])

# Remove irrelevant fields:
y <- y[vars]

# Output to file:
write.table(y, file = "data/biological.csv", col.names = TRUE, row.names = FALSE, sep = ",")

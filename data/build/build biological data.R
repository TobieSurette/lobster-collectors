# Define variables to keep in the output:
vars <- c("year", "site", "collector", "species", "sex", "size", "weight", "comment")

# Load 2008-2018 data:
y <- read.csv("https://raw.github.com/TobieSurette/lobster-collectors/master/data/raw/129_Crab_Fish_table_08_18.csv", stringsAsFactors = FALSE)
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

# Load 2019 data:
x <- read.csv("https://raw.github.com/TobieSurette/lobster-collectors/master/data/raw/Collector%20Data%202019.csv", stringsAsFactors = FALSE)
names(x) <- tolower(names(x))

# Create year field:
x$year <- 2019

# Variable name corrections:
str <- names(x)
x$size <- x$size.cl..cw.or.tl
x$weight <- NA
x$collector <- x$collector.number
x$comment  <- x$notes

# Clean up study area field:
x$study.area <- gsub("\n", "", x$study.area)

# Clean up sex field:
x$sex <- toupper(x$sex)

# Remove empty observations:
x <- x[!is.na(x$size) | x$sex != "", ]

# Clean up comments:
#x$comment <- gsub(",", ";", x$comment)

# Combine data sets:
x <- rbind(x[vars], y[vars])

# Output to file:
write.table(x, file = "/Users/crustacean/Desktop/lobster-collectors/data/biological.csv", col.names = TRUE, row.names = FALSE, sep = ",")

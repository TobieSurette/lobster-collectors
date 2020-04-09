# Load 2019 data:
x <- read.csv("/Users/crustacean/Desktop/lobster-collectors/data/raw/Collector Data 2019.csv", stringsAsFactors = FALSE)
names(x) <- tolower(names(x))

# Clean up date fields:
index <- which(nchar(x$date.deployed) == 8)
x$date.deployed[index] <- paste0("20", x$date.deployed[index])
index <- which(nchar(x$date.retrieved) == 8)
x$date.retrieved[index] <- paste0("20", x$date.retrieved[index])

# Load 2008-2018 data:
y <- read.csv("/Users/crustacean/Desktop/lobster-collectors/data/raw/Collector Data 2008-2018.csv", stringsAsFactors = FALSE)
names(y) <- tolower(names(y))

# Date deployed:
year <- as.numeric(unlist(lapply(strsplit(y$date.deployed, "[/]"), function(x) x[3])))
month <- as.numeric(unlist(lapply(strsplit(y$date.deployed, "[/]"), function(x) x[1])))
day <- as.numeric(unlist(lapply(strsplit(y$date.deployed, "[/]"), function(x) x[2])))
y$date.deployed <- as.character(as.Date(paste0(year, "-", month, "-", day)))

# Date retrieved:
year <- as.numeric(unlist(lapply(strsplit(y$date.retrieved, "[/]"), function(x) x[3])))
month <- as.numeric(unlist(lapply(strsplit(y$date.retrieved, "[/]"), function(x) x[1])))
day <- as.numeric(unlist(lapply(strsplit(y$date.retrieved, "[/]"), function(x) x[2])))
y$date.retrieved <- as.character(as.Date(paste0(year, "-", month, "-", day)))

# Combine data sets:
x <- rbind(x, y[names(x)])

# Create year field:
x$year <- as.numeric(substr(x$date.deployed, 1, 4))

# Variable name corrections:
str <- names(x)
str <- gsub("size.cl..cw.or.tl", "size", str)
str <- gsub("collector.number", "collector", str)
str <- gsub("collector.size..m2.", "collector.size", str, fixed = TRUE)
str <- gsub("notes", "comment", str)
names(x) <- tolower(str)

# Clean up study area field:
x$study.area <- gsub("\n", "", x$study.area)

# Clean up sex field:
x$sex <- toupper(x$sex)
x$sex[x$sex == "2"] <- "F"

# Remove null observations:
x <- x[is.na(x$size) & x$sex, ]

# Clean up comments:
x$comment <- gsub(",", ";", x$comment)

# Generate collector table
vars <- c("study.area", "date.deployed", "date.retrieved", "condition.on.retrieval", "collector.size", "comment")
r <- aggregate(x[vars], by = x[c("year", "site", "collector")], unique)

# Clean-up condition.on.retrieval:
r[which(unlist(lapply(r$condition.on.retrieval, length)) > 1), ] # Errors.
fun <- function(x) if (length(x) > 1) return(x[x!="OK"]) else return(x)
r$condition.on.retrieval <- unlist(lapply(r$condition.on.retrieval, fun))

x <- cbind(x[c("year", "site", "collector")],
           x[, setdiff(names(x), names(r))])

write.table(x, file = "/Users/crustacean/Desktop/lobster-collectors/data/Biological.csv", col.names = TRUE, row.names = FALSE, sep = ",")
write.table(r, file = "/Users/crustacean/Desktop/lobster-collectors/data/Collectors.csv", col.names = TRUE, row.names = FALSE, sep = ",")



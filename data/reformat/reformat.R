# Load test image:
x <- read.csv("/Users/crustacean/Desktop/lobster-collectors/data/raw/Collector Data 2019.csv", stringsAsFactors = FALSE)
str <- names(x)

# Variable name corrections:
str <- gsub("Size.CL..CW.or.TL", "size", str)
str <- gsub("Collector.Number", "collector", str)
str <- gsub("Collector.Size..m2.", "collector.size", str, fixed = TRUE)
str <- gsub("Notes", "comment", str)
names(x) <- tolower(str)

# Clean up species
x$species <- "Homarus americanus"

# Clean up study area field:
x$study.area <- gsub("\n", "", x$study.area)

# Clean up date fields:
index <- which(nchar(x$date.deployed) == 8)
x$date.deployed[index] <- paste0("20", x$date.deployed[index])
index <- which(nchar(x$date.retrieved) == 8)
x$date.retrieved[index] <- paste0("20", x$date.retrieved[index])
x$year <- as.numeric(substr(x$date.deployed, 1, 4))

x$comment <- gsub(",", ";", x$comment)

# Generate collector table
vars <- c("year", "study.area", "site", "date.deployed", "date.retrieved", "condition.on.retrieval", "collector.size", "comment")
r <- aggregate(x[vars], by = x[c("collector")], unique)

# Clean-up condition.on.retrieval:
r[which(unlist(lapply(r$condition.on.retrieval, length)) > 1), ] # Errors.
fun <- function(x) if (length(x) > 1) return(x[x!="OK"]) else return(x)
r$condition.on.retrieval <- unlist(lapply(r$condition.on.retrieval, fun))

x <- cbind(x["year"], x[, setdiff(names(x), setdiff(names(r), c("site", "collector")))])

write.table(x, file = "/Users/crustacean/Desktop/lobster-collectors/data/Biological.csv", col.names = TRUE, row.names = FALSE, sep = ",")
write.table(r, file = "/Users/crustacean/Desktop/lobster-collectors/data/Collectors.csv", col.names = TRUE, row.names = FALSE, sep = ",")



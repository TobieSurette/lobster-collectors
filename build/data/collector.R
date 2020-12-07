library(gulf.utils)
library(gulf.spatial)

# Define variables to keep in the output:
vars <- c("year", "site", "collector", "condition", "comment")

# Load lobster larvae collector table:
file <- locate(file = "129_Collector_Table.csv")
x <- read.csv(file, header = TRUE, stringsAsFactors = FALSE)
names(x) <- tolower(names(x))

# Change field names:
str <- names(x)
str[str == "site_name"] <- "site"
str[str == "r_year"] <- "year"
str[str == "coll_no"] <- "collector"
str[str == "ret_comments"] <- "comment"
str[str == "cond_ret"] <- "condition"
names(x) <- str

# Collector condition table:
conditions <- c("OK", "<1/2", ">1/2", "Damaged", "Lost")
x$condition <- conditions[x$condition]

# Remove irrelevant fields:
x <- x[vars]

write.table(x, file = "data/collector.csv", col.names = TRUE, row.names = FALSE, sep = ",")

# x$longitude <- NA
# x$latitude <- NA
# #x$site2 <- ""
# # Load coordinate data:
# files <- locate(file = "Collector_coordinates")
# for (i in 1:4){
#    y <- readLines(files[i])
#    y <- strsplit(y, "\t")
#    n <- unlist(lapply(y, length))
#    t <- table(n)
#    t <- t[as.numeric(names(t)) > 1]
#    t <- as.numeric(names(t[which.max(t)]))
#    y <- y[n == t]
# 
#    tmp <- NULL
#    for (j in 1:length(y)) tmp <- rbind(tmp, y[[j]])
#    y <- as.data.frame(tmp, stringsAsFactors = FALSE)
# 
#    y <- y[, unlist(lapply(y, function(y) return(length(unique(y)) > 1)))]
# 
#    # Identify collector column:
#    j <- which(unlist(lapply(y, function(y) return(all(gsub("[0-9]", "", y) == "")))))
#    names(y) <- gsub(names(y)[j], "collector", names(y))
#    y[, j] <- as.numeric(y[, j])
# 
#    # Identify coordinates column:
#    j <- which(unlist(lapply(y, function(y) return(length(grep("^N[0-9][0-9]", y)) > 0))))
#    y[,j] <- gsub("^N", "", y[,j])
#    y[,j] <- gsub(" W", ",", y[,j])
#    y[,j] <- gsub(" ", "", y[,j])
#    y$latitude <- dmm2deg(as.numeric(unlist(lapply(strsplit(y[,j], ","), function(y) y[1]))))
#    y$longitude <- -dmm2deg(as.numeric(unlist(lapply(strsplit(y[,j], ","), function(y) y[2]))))
# 
#    # Identify site column:
#    j <- which(unlist(lapply(y, function(y) return(length(grep("albert", tolower(y))) > 0))))
#    names(y) <- gsub(names(y)[j], "site", names(y))
# 
#    # Identify date column:
#    j <- which(unlist(lapply(y, function(y) return(length(grep("[0-9]:[0-9][0-9]", y)) >= 0.5  * length(y)))))
#    names(y) <- gsub(names(y)[j], "date", names(y))
#    y$date <- unlist(lapply(strsplit(y$date, " "), function(y) y[1]))
# 
#    # Remove irrelvant fields:
#    y <- y[, -grep("^V[0-9]", names(y))]
# 
#    # Merge with collector table:
#    ix <- match(y$collector, x$collector)
#    x$longitude[ix[!is.na(ix)]] <- y$longitude[!is.na(ix)]
#    x$latitude[ix[!is.na(ix)]] <- y$latitude[!is.na(ix)]
#    #x$site2[ix[!is.na(ix)]] <- y$site[!is.na(ix)]
# }
# 
# # Write to file:
# file <- paste0(strsplit(file, "/raw")[[1]][1], "/collector.csv")
# 
# write.table(x, file = file, col.names = TRUE, row.names = FALSE, sep = ",")

# Define variables to keep in the output:
vars <- c("year", "site", "collector", "condition", "comment")

# Load lobster larvae collector table:
x <- read.csv("/Users/crustacean/Desktop/lobster-collectors/data/raw/129_Collector_Table_08_18.csv", stringsAsFactors = FALSE)
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

write.table(x, file = "/Users/crustacean/Desktop/lobster-collectors/data/collector.csv", col.names = TRUE, row.names = FALSE, sep = ",")




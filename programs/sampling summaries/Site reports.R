# Should be an Rmd document which generates a pdf document:

# Verbal results:
# - Rank of site with respect to yoy production from other sites, possibly in map form.
# - How do they compare with sites in the US, Maritimes and Newfoundland?
# - How does yoy production compare with yoy production in other years?
# - How variable was the temperature?
# - Was the temperature warmer or more variable?
# - Point out significant storms or temperature events on the Minilog graph.
# - Summary of how many collectors were usable (or silted over).

language <- "english"

sites <- "Alberton"
years <- 2018
m <- read.minilog(year = years[i], site = sites[j], project = "collectors")

m$julian <- julian(time(m))

# Minilog temperature plot:
plot(c(90, 180), c(10, 25), type ="n", xlab = "", ylab = "")
grid()
lines(m$julian, m$temperature, lwd = 2, col = "blue")

# Plot length-frequency histograms:
dbarplot(table(round(b$size)), width = 1, xlab = "", ylab = "")
mtext("Carapace length (mm)", 1, 2.5, cex = 1.5)
mtext("# / collector", 1, 2.5, cex = 1.5)

# Plot yoy time series:
dbarplot(year, yoy, width = 1, xlab = "", ylab = "")
# Plot lines for other regions:
# lines(year, ot)



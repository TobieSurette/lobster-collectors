library(gulf.data)
library(gulf.graphics)
library(gulf.spatial)

language <- language("en")
format = "pdf"

# Read collector table:
s <- read.csv(locate(file = "^collector.csv"))

# Number of collectors per site 
# by1=s$year
# by2=s$site
# s2<-aggregate(s$collector, by=list(by1,by2), length)
# 
# ##check if any have more than 30- none should
# c<-which(s2$x>30)
# s3<-s2[c,]

# Read biological data:
b <- read.csv(locate(file = "^biological.csv"))

b <- b[b$species == "Homarus americanus", ]

# Read yoy cutoff table:
y <- read.csv(locate(file = "yoy_cutoff.csv"))
y$site[y$site == "Egmont Bay"] <- "Cape Egmont"

# Determine yoy membership:
ix <- match(b[c("year", "site")], y[c("year", "site")])
b$yoy <- as.numeric(b$size <= y$mean[ix])

# Compile yoy table:
r <- aggregate(b["yoy"], by = b[c("year", "site", "collector")], sum)
ix <- match(r[c("year", "site", "collector")], s[c("year", "site", "collector")])
s$n <- 0
s$n[ix] <- r$yoy
   
# Spot correction:
s$condition[is.na(s$condition)] <- "OK"

data <- s[s$condition == "OK", ]

# Keep track of sites in years with no observations:
zeroes <- aggregate(list(mean = data[,"n"]), by = data[c("site", "year")], mean)
zeroes$mean[is.na(zeroes$mean)] <- 0
zeroes <- zeroes[zeroes$mean == 0, ]

# Remove null sites from analysis:
data <- data[is.na(match(data[c("site", "year")], zeroes[c("site", "year")])), ]
data$site <- as.factor(data$site)
data$year <- factor(data$year, levels = sort(unique(data$year)))

# Fit model:
m <- glm(n ~ site * year, family = poisson, data = data)

# Calculate indices:
newdata <- aggregate(data["n"], by = data[c("site", "year")], mean)
newdata <- newdata[newdata$n > 0, 1:2]
res <- predict(m, newdata = newdata, se.fit = TRUE)

# Compile results:
results <- data.frame(mean = exp(res$fit),
                      lower.ci = exp(res$fit - 1.96 * res$se.fit),
                      upper.ci = exp(res$fit + 1.96 * res$se.fit))
results <- cbind(newdata, results / 0.557) # Standardize to one square meter.

# Add zeroes to results:
zeroes$lower.ci <- 0
zeroes$upper.ci <- 0
results <- rbind(results, zeroes)

sites <- unique(results$site)
cols <- rainbow(length(sites))
results$year <- as.numeric(as.character(results$year))
results <- sort(results, by = c("site", "year"))

# Quick plot:
windows()
plot(range(results$year), c(0, 1.2*max(results$mean)), type = "n")
for (i in 1:length(sites)){
   r <- results[results$site == sites[i], ]
   print(r)
   lines(r$year, r$mean, col = cols[i], lwd = 2)
}
legend("topleft", legend = sites, col = cols, lwd = 2)

if (language == "french")  file <- "ALSI Homards juvenile de l'annee"
if (language == "english") file <- "ALSI yoy Lobster"
if (format == "jpg") jpeg(file = paste0("results/figures/", file, ".jpeg"), width = 600 * 8, height = 600 * 8, res = 75 * 8)
if (format == "pdf") pdf(file = paste0("results/figures/", file, ".pdf"), width = 8, height = 8)

m <- kronecker(matrix(1:2, ncol = 1), matrix(1, ncol = 5, nrow = 5))
m <- rbind(0, cbind(0, m, 0), 0, 0)
layout(m)
par(mar = c(0,0,0,0))  #   c(bottom, left, top, right)

sites <- c("Alberton", "Covehead", "Skinner's Pond", "Egmont Bay", "Fortune", "Murray Harbour",  "Arisaig", "Neguac", "Nine Mile Creek")
results$site <- as.character(results$site)

lty <- c("solid", "dashed", "dotted")
cols <- c("black", "grey40", "grey70")
pch <- 21:23

# Define axis labels:
if (language == "english") xlab <- "Year" else xlab <- "Année"
if (language == "english") ylab <- expression(paste("Number per m"^"2")) else ylab <- expression(paste("Nombre par m"^"2"))

xlim <- range(results$year)
for (i in 1:2){
   jj <- (i-1)*3 + (1:3)
   if (i == 3) jj <- jj[c(1, 3)]
   ylim <- c(0, 1.1 * max(results$upper.ci[results$site %in% sites[jj]]))
   plot(xlim, ylim, type = "n", xaxt = "n", yaxt = "n", xlab = "", ylab = "", yaxs = "i")
   grid()
   for (j in 1:length(jj)){
      r <- results[results$site %in% sites[jj][j], ]
      if (nrow(r) > 0){
         missing <- setdiff(min(r$year):max(r$year), r$year)
         if (length(missing) > 0){
            r <- rbind(r, data.frame(site = r$site[1], year = missing, mean = NA, lower.ci = NA, upper.ci = NA))
            r <- r[order(r$year), ]
         }

         lines(r$year, r$mean, col = cols[j], lwd = 2, lty = lty[j])
         for (k in 1:nrow(r)){
            lines(rep(r$year[k], 2), c(r$lower.ci[k], r$upper.ci[k]), col = cols[j], lty = lty[j], lwd = 2)
            lines(c(r$year[k] - 0.10, r$year[k] + 0.10), rep(r$lower.ci[k], 2), col = cols[j], lty = lty[j], lwd = 2)
            lines(c(r$year[k] - 0.10, r$year[k] + 0.10), rep(r$upper.ci[k], 2), col = cols[j], lty = lty[j], lwd = 2)
         }
      }
   }

   other <- c("24", "24", "25N", "25S", "26APEI", "26APEI")

   str <- sites[jj]
   if (language == "french") str <- gsub("Egmont Bay", "Baie Egmont", str)

   if (i == 1) pos <-"topleft" else pos <-"topright"
   legend(pos, legend = paste0(str, " (", other[jj], ")"), col = cols[1:length(jj)], lwd = 2, bg = "white", cex = 1.6, lty = lty[1:length(jj)],
          pch = pch[1:length(jj)], pt.bg = cols[1:length(jj)])
   if (i == 1) at <- seq(0, 35, by = 5)
   if (i == 2) at <- seq(0, 5, by = 1)
   if (i == 3) at <- seq(0, 2, by = 0.5)
   axis(2, at = at, cex.axis = 1.2)
   if (i == 1) mtext(ylab, 2, 3, at = 0, cex = 1.5)
   box()
   for (j in 1:length(jj)){
      r <- results[results$site %in% sites[jj][j], ]
      points(r$year, r$mean, pch = pch[j], bg = cols[j], cex = 1.75)
   }
}

axis(1, at = seq(min(results$year), max(results$year), by = 2), cex.axis = 1.2)
axis(1, at = seq(min(results$year)+1, max(results$year), by = 2), cex.axis = 1.2)
mtext(xlab, 1, 3.5, cex = 1.5)

if (format != "") dev.off()

results <- sort(results, by = c("site", "year"))
results[c("mean", "lower.ci", "upper.ci")] <- round(results[c("mean", "lower.ci", "upper.ci")], 3)

# Write results table:
if (language == "french") names(results) <- c("site", "année", "moyenne", "int.conf.2.5%", "int.conf.97.5%")
write.csv(results, file = paste0("results/tables/", file, ".csv"), row.names = FALSE)


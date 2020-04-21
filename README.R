readme.file <- file("README.md","w")

writeLines("# Lobster Larvae Collectors", con = readme.file, sep="\n")
	
# Abstract:
writeLines("\n## Abstract\n", con = readme.file, sep = "\n")
writeLines(readLines("metadata/abstract.md"), con = readme.file, sep = "\n")

# Methods:
writeLines("\n## Methods\n", con = readme.file, sep = "\n")
writeLines(readLines("metadata/methods.md"), con = readme.file, sep = "\n")

close(readme.file)

## Authors:
cat("\n## Authors\n", file = file, append = TRUE)
cat("* **Tobie Surette**\n", file = file, append = TRUE)
cat("* **Denis Gagnon**\n", file = file, append = TRUE)
cat("* **Natalie Asselin**\n", file = file, append = TRUE)

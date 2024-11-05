library(readxl)
library(vegan)

# Reading the Excel file (presented horizontally, site names on rows 2 to 5, syllable names on row 1 and site names on column 1)
data <- read_excel("/Users/marierobert/Desktop/L0horizontal.xlsx")

# Removing non-numeric headers
data <- data[ , -1]

# Defining site names
site_names <- c("FC", "HI", "LEI", "SC")

# Calculating Chao2 diversity estimates for each site
chao2_estimate <- function(x) {
  observed <- sum(x > 0)  # Number of observed syllables
  singletons <- sum(x == 1)  # Number of singletons
  doubletons <- sum(x == 2)  # Number of doubletons
  
  chao2 <- observed + (singletons^2 / (2 * (doubletons + 1)))
  return(chao2)
}

# Creating a data frame to store site names and Chao2 estimates
chao2_results <- data.frame(Site = character(), Chao2 = numeric(), stringsAsFactors = FALSE)

# Calculating Chao2 estimates for each site
for (i in 1:length(site_names)) {
  site_data <- data[i, ]
  site_chao2 <- chao2_estimate(site_data)
  chao2_results <- rbind(chao2_results, data.frame(Site = site_names[i], Chao2 = site_chao2))
}
# Printing Chao2 estimates for each site
print(chao2_results)


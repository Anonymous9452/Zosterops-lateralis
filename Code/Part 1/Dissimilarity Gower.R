library(readxl)
library(cluster)

# Reading the Excel file (here the data must be organised horizontally, with sites on row 2 to 5, headers on row 1 and column 1)
birdsong_data <- read_excel("/Users/marierobert/Desktop/L0horizontal.xlsx", range = cell_rows(1:5))

# Retrieving site names and removing site names from the data frame
site_names <- birdsong_data[[1]]  # Site names are in the first column
birdsong_data <- birdsong_data[-1]  # Removing the first column

# Converting to numeric data for Gower distance calculation
birdsong_numeric <- data.matrix(birdsong_data)

# Computing the observed Gower dissimilarity matrix
gower_dist <- daisy(birdsong_numeric, metric = "gower")
gower_matrix <- as.matrix(gower_dist)

# Setting the row and column names to site names
rownames(gower_matrix) <- site_names
colnames(gower_matrix) <- site_names

# Printing the observed Gower dissimilarity matrix
cat("Observed Gower Dissimilarity Matrix:\n")
print(gower_matrix)

library(vegan)
library(readxl)

# Setting the file paths for the geographical distance matrix and the dissimilarity matrix
geo_file <- "/Users/marierobert/Desktop/geo.xlsx"  # Geographical distance matrix file path
sonic_file <- "/Users/marierobert/Desktop/sonicL0Perc.xlsx"  # Acoustic distance matrix file path

# Reading the geographical distance matrix and acoustic distance matrix from Excel files
geo_df <- readxl::read_excel(geo_file)
sonic_df <- readxl::read_excel(sonic_file)
# Converting tibbles to data frames
geo_df <- as.data.frame(geo_df)
sonic_df <- as.data.frame(sonic_df)

# Setting row names to the first column (Site titles)
rownames(geo_df) <- geo_df[, 1]
rownames(sonic_df) <- sonic_df[, 1]

# Removing the first column (Site titles) from the data frames
geo_df <- geo_df[, -1]
sonic_df <- sonic_df[, -1]
# Performing Mantel test with the geographical distance matrix and the acoustic distance matrix
mantel_result <- mantel(geo_df, sonic_df, method = "pearson", permutations = 999)

# Printing the Mantel test result
print(mantel_result)

# Performing Mantel test with the geographical distance matrix and the dissimilarity matrix
mantel_result <- mantel(geo_df, sonic_df, method = "pearson", permutations = 999)

# Extract the p-value from the Mantel test result
p_value <- mantel_result$signif

# Print the Mantel test result including p-value
print(mantel_result)
print(p_value)
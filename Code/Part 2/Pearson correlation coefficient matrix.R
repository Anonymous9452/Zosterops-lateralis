library(readxl)

# Reading the Excel file (data must be presented vertically, with syllable names in column A and site names in row 1)
birdsong_data <- read_excel("/Users/marierobert/Desktop/L0vertical.xlsx")

# Selecting the data of interest (occurrences of syllables for each site)
data <- birdsong_data[2:5, -1]  # Excluding the first column (syllable names)

# Calculating the Pearson correlation coefficient matrix
correlation_matrix <- cor(data, method = "pearson")

# Printing the correlation matrix
print(correlation_matrix)
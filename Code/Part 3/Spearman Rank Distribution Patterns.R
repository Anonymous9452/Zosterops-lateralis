library(readxl)

# Reading the Excel file (presented vertically, with syllable names in column A and site names in row 1 as headers; Site occurrences are listed from column B to column E; Total occurrences is listed in column F with the header "Total_Occurrences"; data is organised from most combined use to least)
birdsong_data <- read_excel("/Users/marierobert/Desktop/L0Distribution.xlsx")

# Calculating the mean occurrence rank for each syllable
birdsong_data$Mean_Rank <- rowMeans(birdsong_data[, 2:5])

# Calculating the correlation between mean occurrence ranks and frequencies
correlation <- cor.test(birdsong_data$Mean_Rank, birdsong_data$Total_Occurrences, method = "spearman")

# Printing the correlation coefficient
print(correlation)
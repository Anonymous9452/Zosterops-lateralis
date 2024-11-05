library(readxl)
library(dplyr)

# Reading the Excel file (Eco-Acoustic dataset)
data <- read_excel("/Users/marierobert/Desktop/All Data.xlsx")

# Filtering data for syllables called "All edges"
edges_data <- data %>%
  filter(L2 == "All edges")

# Summary statistics for Delta
summary_stats_delta <- edges_data %>%
  summarise(
    Median_Delta = median(Delta),
    Q1_Delta = quantile(Delta, 0.25),
    Q3_Delta = quantile(Delta, 0.75),
    Max_Delta = max(Delta),
    Min_Delta = min(Delta),
    SD_Delta = sd(Delta),
    Mean_Delta = mean(Delta)
  )

# Printing summary statistics for Delta
print(summary_stats_delta)
library(readxl)
library(ggplot2)

# Reading the Excel file (site pairs listed from rows 2 to 8, geo in column B, sonic in column C)
data <- read_excel("/Users/marierobert/Desktop/L1geo-sonic.xlsx")

# Plotting scatter plot
ggplot(data, aes(x = Dsonic, y = Dgeo, label = data[[1]])) +
  geom_point() +
  geom_text(vjust = -1) +  # Adjust text alignment
  labs(x = "Dsonic", y = "Dgeo") +
  theme_minimal()
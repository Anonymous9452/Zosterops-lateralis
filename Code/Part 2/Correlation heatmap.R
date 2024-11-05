library(readxl)
library(ggplot2)
library(reshape2)

# Reading the Excel file (Eco-Acoustic dataset)
file_path <- "/Users/marierobert/Desktop/All Data.xlsx"
bird_data <- read_excel(file_path)

# Calculating mean frequency
bird_data$MeanFrequency <- (bird_data$LowFreq + bird_data$HighFreq) / 2

# Calculating bandwidth by subtracting LowFreq from HighFreq
bird_data$Bandwidth <- bird_data$HighFreq - bird_data$LowFreq

# Selecting variables including Mean Frequency
selected_variables <- bird_data[, c("Delta", "LowFreq", "HighFreq", "CtrFreq", "PeakFreq", "Freq1", "Freq2", "Slope", "Bandwidth", "MeanFrequency")]

# Computing correlation matrix
correlation_matrix <- cor(selected_variables)

# Creating correlation plot
ggplot(data = melt(correlation_matrix), aes(Var1, Var2, fill = value)) +
  geom_tile(color = "white") +
  scale_fill_gradient2(low = "navyblue", mid = "white", high = "red4", midpoint = 0) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), 
        axis.title = element_blank()) +
  labs(title = NULL,
       x = NULL, y = NULL, fill = "Correlation") +
  theme(axis.text = element_text(size = 20),
        legend.text = element_text(size = 8))
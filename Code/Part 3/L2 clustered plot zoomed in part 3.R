# Load necessary libraries
library(readxl)
library(dplyr)
library(ggplot2)
library(tidyr)

# Reading the Excel file using the Eco-Acoustic dataset
data <- read_excel("/Users/marierobert/Desktop/All Data.xlsx")

# Selecting relevant columns
selected_columns <- c("Slope", "Delta", "LowFreq", "HighFreq", "L2")
data <- data %>%
  select(all_of(selected_columns))

# Calculating bandwidth
data <- data %>%
  mutate(Bandwidth = HighFreq - LowFreq)

# Dropping any rows with NA values
data <- na.omit(data)

# Performing scaling if needed (optional but recommended for k-means)

data_scaled <- scale(data[, c("Slope", "Delta", "Bandwidth")])

# Unnesting the clustered data
clustered_data <- data %>%
  unnest(cols = c(L2))

# Generating a palette with 14 colors
palette <- rainbow(14)

# Creating a ggplot for visualization with further reduced point size and alpha blending
p <- ggplot(clustered_data, aes(x = Slope, y = Delta, color = factor(L2))) +
  geom_point(size = 1, alpha = 1) +  # Further reduce point size and add alpha blending
  scale_color_manual(values = palette) + 
  labs(x = "Slope", y = "Delta") +
  theme_minimal() +
  xlim(-55, 35) +  # Set x-axis limits
  ylim(0, 0.4)    # Set y-axis limits

# Adding legend on the right side of the plot
p <- p + theme(legend.position = "right")

# Printing the plot
print(p)
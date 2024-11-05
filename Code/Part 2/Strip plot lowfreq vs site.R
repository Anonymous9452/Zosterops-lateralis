library(readxl)   
library(ggplot2)  

# Reading the Excel file (Eco-Acoustic dataset including all spectral data)
data <- read_excel("/Users/marierobert/Desktop/All Data.xlsx")

# Creating a strip plot
strip_plot <- ggplot(data, aes(x = Loc, y = LowFreq, color = Loc)) +
  geom_jitter(position = position_jitter(width = 0.2), alpha = 0.7) +  # Adding jitter to avoid overlapping points
  labs(title = "Strip Plot of Low Frequency by Location",
       x = "Location",
       y = "Low Frequency") +
  scale_color_manual(values = c("#00B0F0", "black")) +  # Setting colors for island and mainland
  theme_minimal()

# Displaying the plot
print(strip_plot)
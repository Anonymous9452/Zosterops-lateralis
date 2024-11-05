library(readxl)        # For reading Excel files
library(FactoMineR)    # For PCA analysis
library(factoextra)    # For visualizing PCA results
library(ggrepel)       # For label repulsion

# Reading the Excel file (Eco-Acoustic dataset containing all spectral features data)
data <- read_excel("/Users/marierobert/Desktop/All Data.xlsx")

# Calculating mean frequency
data$MeanFrequency <- (data$LowFreq + data$HighFreq) / 2

# Calculating bandwidth and adding it as a new column
data$Bandwidth <- data$HighFreq - data$LowFreq

# Performing PCA using HighFreq, LowFreq, Delta, Slope, Bandwidth, and MeanFrequency
pca_result <- PCA(select(data, LowFreq, Delta, Slope, Bandwidth, MeanFrequency, HighFreq, CtrFreq, Freq1, Freq2, PeakFreq), scale.unit = TRUE, graph = FALSE)

# Displaying PCA summary
summary(pca_result)

# Visualising PCA results without labels and arrows
pca_plot <- fviz_pca_var(pca_result,
                         col.var = "black",
                         repel = TRUE, 
                         ggtheme = theme_minimal(),
                         labelsize = 4,  # Adjust label size
                         label = "var",  # Specify to label variables
                         hjust = c(0, 1, 0, 1, 0, 0),  # Adjust horizontal position of labels
                         vjust = c(-0.5, 0.5, -0.5, 0.5, -0.5, -0.5))  # Adjust vertical position of labels

# Displaying PCA plot with custom label positions
print(pca_plot)

# Displaying PCA plot without labels and arrows
print(pca_plot)
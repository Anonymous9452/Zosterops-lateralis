library(readxl)    # For reading Excel files
library(dunn.test) # For Dunn's test
library(tidyverse) # For data manipulation

# Reading the Excel file (Eco-Acoustic dataset)
data <- read_excel("/Users/marierobert/Desktop/All Data.xlsx")

# Selecting the columns of interest
frequency_data <- data %>%
  select(Site, LowFreq, HighFreq, CtrFreq, PeakFreq, Freq1, Freq2)

# Kruskal-Wallis test
kruskal_result <- kruskal.test(LowFreq + HighFreq + CtrFreq + PeakFreq + Freq1 + Freq2 ~ Site, data = frequency_data)

# Dunn's test with Bonferroni correction
dunn_result <- dunn.test::dunn.test(frequency_data$LowFreq, g = frequency_data$Site, method = "bonferroni")
print(dunn_result)

dunn_result <- dunn.test::dunn.test(frequency_data$HighFreq, g = frequency_data$Site, method = "bonferroni")
print(dunn_result)

dunn_result <- dunn.test::dunn.test(frequency_data$CtrFreq, g = frequency_data$Site, method = "bonferroni")
print(dunn_result)

dunn_result <- dunn.test::dunn.test(frequency_data$PeakFreq, g = frequency_data$Site, method = "bonferroni")
print(dunn_result)

dunn_result <- dunn.test::dunn.test(frequency_data$Freq1, g = frequency_data$Site, method = "bonferroni")
print(dunn_result)

dunn_result <- dunn.test::dunn.test(frequency_data$Freq2, g = frequency_data$Site, method = "bonferroni")
print(dunn_result)
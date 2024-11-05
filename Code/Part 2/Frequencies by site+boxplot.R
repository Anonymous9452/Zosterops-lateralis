library(readxl)

# Read the Excel files for mainland and island data (All Data 1 only contains mainland data; All Data 2 only contains island data)
data_mainland <- read_excel("/Users/marierobert/Desktop/All Data1.xlsx")
data_island <- read_excel("/Users/marierobert/Desktop/All Data2.xlsx")

# Combining all frequency data for mainland and island into single vectors
all_freq_data_mainland <- c(data_mainland$LowFreq, data_mainland$HighFreq, data_mainland$PeakFreq, data_mainland$CtrFreq, data_mainland$Freq1, data_mainland$Freq2)
all_freq_data_island <- c(data_island$LowFreq, data_island$HighFreq, data_island$PeakFreq, data_island$CtrFreq, data_island$Freq1, data_island$Freq2)

# Calculating median, quartiles, interquartile range, standard deviation, and standard error for mainland data
median_freq_mainland <- median(all_freq_data_mainland, na.rm = TRUE)
quartiles_mainland <- quantile(all_freq_data_mainland, probs = c(0, 0.25, 0.5, 0.75, 1), na.rm = TRUE)
iqr_freq_mainland <- IQR(all_freq_data_mainland, na.rm = TRUE)
sd_freq_mainland <- sd(all_freq_data_mainland, na.rm = TRUE)
se_freq_mainland <- sd_freq_mainland / sqrt(length(all_freq_data_mainland))

# Calculating median, quartiles, interquartile range, standard deviation, and standard error for island data
median_freq_island <- median(all_freq_data_island, na.rm = TRUE)
quartiles_island <- quantile(all_freq_data_island, probs = c(0, 0.25, 0.5, 0.75, 1), na.rm = TRUE)
iqr_freq_island <- IQR(all_freq_data_island, na.rm = TRUE)
sd_freq_island <- sd(all_freq_data_island, na.rm = TRUE)
se_freq_island <- sd_freq_island / sqrt(length(all_freq_data_island))

# Printing the results for mainland data
cat("Mainland Results:\n")
cat("Median Frequency:", median_freq_mainland, "\n")
cat("1st Quartile:", quartiles_mainland[2], "\n")
cat("2nd Quartile (Median):", quartiles_mainland[3], "\n")
cat("3rd Quartile:", quartiles_mainland[4], "\n")
cat("4th Quartile:", quartiles_mainland[5], "\n")
cat("Interquartile Range (IQR):", iqr_freq_mainland, "\n")
cat("Standard Deviation:", sd_freq_mainland, "\n")
cat("Standard Error:", se_freq_mainland, "\n\n")

# Printing the results for island data
cat("Island Results:\n")
cat("Median Frequency:", median_freq_island, "\n")
cat("1st Quartile:", quartiles_island[2], "\n")
cat("2nd Quartile (Median):", quartiles_island[3], "\n")
cat("3rd Quartile:", quartiles_island[4], "\n")
cat("4th Quartile:", quartiles_island[5], "\n")
cat("Interquartile Range (IQR):", iqr_freq_island, "\n")
cat("Standard Deviation:", sd_freq_island, "\n")
cat("Standard Error:", se_freq_island, "\n")

# Creating a boxplot comparing mainland and island data
boxplot(list(Mainland = all_freq_data_mainland, Island = all_freq_data_island),
        main = "Boxplot of Frequency Data by Site",
        xlab = "Site",
        ylab = "Frequency",
        outline = TRUE)
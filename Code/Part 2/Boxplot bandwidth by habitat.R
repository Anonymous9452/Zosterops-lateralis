# Reading the Excel files for mainland and island data (All Data 1 contains mainland data; All Data 2 contains island data; all extracted from eco-acoustic dataset)
data_mainland <- read_excel("/Users/marierobert/Desktop/All Data1.xlsx")
data_island <- read_excel("/Users/marierobert/Desktop/All Data2.xlsx")

# Calculating bandwidth for mainland and island data
bandwidth_mainland <- data_mainland$HighFreq - data_mainland$LowFreq
bandwidth_island <- data_island$HighFreq - data_island$LowFreq

# Combining bandwidth data for mainland and island into single data frame
data_bandwidth <- data.frame(Site = c(rep("Mainland", length(bandwidth_mainland)), rep("Island", length(bandwidth_island))),
                             Bandwidth = c(bandwidth_mainland, bandwidth_island))

# Creating a boxplot comparing mainland and island bandwidth
boxplot(Bandwidth ~ Site, data = data_bandwidth,
        main = "Boxplot of Bandwidth Data by Site",
        xlab = "Site",
        ylab = "Bandwidth (Hz)",
        outline = TRUE)
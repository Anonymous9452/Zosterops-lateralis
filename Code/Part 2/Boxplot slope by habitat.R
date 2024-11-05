# Reading the Excel files for mainland and island data (All Data 1 contains mainland data; All Data 2 contains island data; all extracted from eco-acoustic dataset)
data_mainland <- read_excel("/Users/marierobert/Desktop/All Data1.xlsx")
data_island <- read_excel("/Users/marierobert/Desktop/All Data2.xlsx")

# Creating a data frame with Site and Slope columns for mainland and island data
data_slope <- data.frame(
  Site = c(rep("Mainland", nrow(data_mainland)), rep("Island", nrow(data_island))),
  Slope = c(data_mainland$Slope, data_island$Slope)
)

# Creating a boxplot comparing mainland and island slopes
boxplot(Slope ~ Site, data = data_slope,
        main = "Boxplot of Slope Data by Site",
        xlab = "Site",
        ylab = "Slope",
        outline = TRUE)
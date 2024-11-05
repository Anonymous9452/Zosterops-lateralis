library(readxl)

# Reading the Excel file (Eco-Acoustic dataset)
file_path <- "/Users/marierobert/Desktop/All Data.xlsx"
bird_data <- read_excel(file_path)

# Converting Site column to factor
bird_data$Loc <- factor(bird_data$Loc)

# Printing levels of Site
print(levels(bird_data$Loc))

# Calculating bandwidth
bird_data$Bandwidth <- bird_data$HighFreq - bird_data$LowFreq

# Performing ANOVA for bandwidth
anova_result_bandwidth <- aov(Bandwidth ~ Loc, data = bird_data)

# Printing ANOVA results for bandwidth
summary(anova_result_bandwidth)
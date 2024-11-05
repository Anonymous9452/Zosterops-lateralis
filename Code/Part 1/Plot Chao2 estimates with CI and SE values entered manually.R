# Defining site names and corresponding Chao2 estimates and standard errors (SE)
sites <- c("FC", "HI", "LEI", "SC")
chao2_estimates <- c(154.8, 239.7, 204.9, 246)
SE <- c(25.5, 11.9, 16, 17.8)
CI_lower <- c(119.4, 223.1, 181.8, 221.1)
CI_upper <- c(218, 270.5, 242.9, 291.6)

# Creating a data frame with the information
chao2_data <- data.frame(sites, chao2_estimates, SE, CI_lower, CI_upper)

# Plotting the Chao2 estimates as a boxplot
library(ggplot2)

ggplot(chao2_data, aes(x = sites)) +
  geom_crossbar(aes(ymin = CI_lower, ymax = CI_upper, y = chao2_estimates),
                width = 0.5, fill = "white", color = "black", fatten = 2) +
  geom_point(aes(y = chao2_estimates), size = 3, color = "black") +
  geom_errorbar(aes(ymin = chao2_estimates - SE, ymax = chao2_estimates + SE),
                width = 0.2, position = position_dodge(0.9), color = "black") +
  labs(title = "Chao2 Estimates and 95% CI by Site",
       x = "Site", y = "Chao2 Estimate") +
  theme_minimal()
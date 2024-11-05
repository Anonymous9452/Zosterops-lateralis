# Manually enter your delta values for each set
set1_median <- 1.2  # Example median value for Set 1
set1_max <- 1.8     # Example maximum value for Set 1
set1_min <- 1.1     # Example minimum value for Set 1

set2_median <- 1.5  # Example median value for Set 2
set2_max <- 1.9     # Example maximum value for Set 2
set2_min <- 1.3     # Example minimum value for Set 2

set3_median <- 1.1  # Example median value for Set 3
set3_max <- 1.6     # Example maximum value for Set 3
set3_min <- 1.0     # Example minimum value for Set 3

set4_median <- 1.8  # Example median value for Set 4
set4_max <- 2.0     # Example maximum value for Set 4
set4_min <- 1.6     # Example minimum value for Set 4

set5_median <- 1.3  # Example median value for Set 5
set5_max <- 1.7     # Example maximum value for Set 5
set5_min <- 1.2     # Example minimum value for Set 5

set6_median <- 1.6  # Example median value for Set 6
set6_max <- 1.9     # Example maximum value for Set 6
set6_min <- 1.5     # Example minimum value for Set 6

set7_median <- 1.4  # Example median value for Set 7
set7_max <- 1.6     # Example maximum value for Set 7
set7_min <- 1.2     # Example minimum value for Set 7

# Combining the data into matrices
delta_values <- matrix(c(set1_median, set1_max, set1_min,
                         set2_median, set2_max, set2_min,
                         set3_median, set3_max, set3_min,
                         set4_median, set4_max, set4_min,
                         set5_median, set5_max, set5_min,
                         set6_median, set6_max, set6_min,
                         set7_median, set7_max, set7_min),
                       ncol = 3, byrow = TRUE)

# Calculating the Pearson correlation
correlation <- cor(delta_values)

# Printing the correlation matrix
print(correlation)
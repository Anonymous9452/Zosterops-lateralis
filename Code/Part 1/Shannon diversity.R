# Entering silvereye syllables occurrences data
occurrences <- c(5, 10, 3, 15, 20)

# Adding small pseudocount to avoid zero counts
pseudo_count <- 0.1
occurrences <- occurrences + pseudo_count

total_individuals <- sum(occurrences)

# Calculating relative abundances
relative_abundance <- occurrences / total_individuals

# Calculating Shannon diversity index
shannon_index <- -sum(relative_abundance * log(relative_abundance))

# Calculating standard error of diversity index with pseudo-count
standard_error <- sqrt((1 - sum(relative_abundance^2)) / total_individuals)

# Printing Shannon diversity index and standard error
print(paste("Shannon Diversity Index:", shannon_index))
print(paste("Standard Error of Diversity Index:", standard_error))
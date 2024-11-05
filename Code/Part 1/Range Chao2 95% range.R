# Loading required packages
library(vegan)
library(boot)

# Manually entering occurrences of syllables for a site
site_data <- c(103,104,110,110,115,116,119,139,160,171,234,242)

# Calculating Chao2 diversity estimate
chao2_estimate <- function(x) {
  observed <- sum(x > 0)
  singletons <- sum(x == 1)
  doubletons <- sum(x == 2)
  chao2 <- observed + (singletons^2 / (2 * (doubletons + 1)))
  return(chao2)
}

# Performing bootstrapping and calculating Chao2 diversity estimate with CI
chao2_boot <- function(data, indices) {
  chao2_estimate(data[indices])
}

# Setting the number of bootstrap replicates
B <- 1000

# Performing bootstrapping
boot_results <- boot(site_data, chao2_boot, R = B)

# Computing the 95% CI
ci <- boot.ci(boot_results, type = "bca")$bca[, 4]

# Printing the Chao2 diversity estimate with 95% CI
chao2 <- chao2_estimate(site_data)
lower_ci <- quantile(boot_results$t, 0.025)
upper_ci <- quantile(boot_results$t, 0.975)

print(paste("Chao2 estimate:", chao2))
print(paste("95% CI:", lower_ci, "-", upper_ci))
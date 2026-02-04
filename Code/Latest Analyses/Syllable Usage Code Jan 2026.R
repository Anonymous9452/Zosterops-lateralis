## Analysis of Syllable Usage ##
##Robert et al 2026 (Feb) - Marie Robert and Dominique Potvin##

library(readxl)
library(dplyr)
library(tidyr)
library(writexl)

## ---- Load and prepare data ----
file <- "L0, L1, L2Occ.xlsx"
sheet_to_use <- 2

dat <- read_excel(file, sheet = sheet_to_use)

# Calculate proportions for each site
prop_data <- dat %>%
  rename(group = 1) %>%
  mutate(group = as.character(group)) %>%
  filter(!is.na(group), group != "") %>%
  mutate(
    FC = .[[3]], HI = .[[4]], LEI = .[[5]], SC = .[[6]]
  ) %>%
  select(group, FC, HI, LEI, SC) %>%
  mutate(across(c(FC, HI, LEI, SC), ~replace(., is.na(.), 0))) %>%
  # Calculate proportions within each site
  mutate(
    FC_prop = FC / sum(FC),
    HI_prop = HI / sum(HI),
    LEI_prop = LEI / sum(LEI),
    SC_prop = SC / sum(SC)
  ) %>%
  select(group, ends_with("_prop"))

## ANALYSIS 1: Rank consistency (Kendall's W)

# Create rank matrix
rank_matrix <- prop_data %>%
  mutate(
    FC_rank = rank(-FC_prop, ties.method = "average"),
    HI_rank = rank(-HI_prop, ties.method = "average"),
    LEI_rank = rank(-LEI_prop, ties.method = "average"),
    SC_rank = rank(-SC_prop, ties.method = "average")
  ) %>%
  select(group, ends_with("_rank"))

# Calculate Kendall's W
k_mat <- as.matrix(rank_matrix[, -1])
n <- nrow(k_mat)  # 46 syllables
k <- ncol(k_mat)  # 4 sites
R <- rowSums(k_mat)
S <- sum((R - mean(R))^2)
W <- (12 * S) / (k^2 * (n^3 - n))
chi2 <- k * (n - 1) * W
df <- n - 1
p_W <- 1 - pchisq(chi2, df)


## ANALYSIS 2: Pairwise rank correlations

# Calculate Spearman correlations
cor_matrix <- cor(prop_data[, -1], method = "spearman", use = "complete.obs")
avg_correlation <- mean(cor_matrix[upper.tri(cor_matrix)])


## ANALYSIS 3: Pairwise consistency percentage


calc_pairwise_consistency <- function(prop_data) {
  n_syllables <- nrow(prop_data)
  consistent_pairs <- 0
  total_pairs <- 0
  
  for(i in 1:(n_syllables-1)) {
    for(j in (i+1):n_syllables) {
      # Get proportions for syllable i and j at all sites
      prop_i <- as.numeric(prop_data[i, -1])
      prop_j <- as.numeric(prop_data[j, -1])
      
      # Compare which is larger at each site
      comparisons <- sign(prop_i - prop_j)
      
      # If all comparisons agree (all positive or all negative)
      if(all(comparisons > 0) | all(comparisons < 0)) {
        consistent_pairs <- consistent_pairs + 1
      }
      total_pairs <- total_pairs + 1
    }
  }
  
  return(consistent_pairs / total_pairs)
}

consistency_pct <- calc_pairwise_consistency(prop_data) * 100


## ANALYSIS 4: Region comparison (island vs mainland)


# Calculate mean proportions for regions
prop_data_regions <- prop_data %>%
  mutate(
    island_prop = (HI_prop + LEI_prop) / 2,
    mainland_prop = (SC_prop + FC_prop) / 2
  )

# Rank correlation between regions
region_cor <- cor(prop_data_regions$island_prop, 
                  prop_data_regions$mainland_prop, 
                  method = "spearman")


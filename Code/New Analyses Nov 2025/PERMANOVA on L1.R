library(readxl)
library(dplyr)
library(tidyr)
library(cluster)
library(vegan)

occ_all <- readxl::read_excel(
  "Supplementary Material 1c - L0, L1, L2Occ.xlsx",
  sheet = "Occurrence count"
)

occ_all <- occ_all %>%
  dplyr::select(SYLLABLE, `Level 1`, `Level 2`, FC, HI, LEI, SC)

L1_occ <- occ_all %>%
  dplyr::group_by(`Level 1`) %>%
  dplyr::summarise(
    FC  = sum(FC,  na.rm = TRUE),
    HI  = sum(HI,  na.rm = TRUE),
    LEI = sum(LEI, na.rm = TRUE),
    SC  = sum(SC,  na.rm = TRUE)
  ) %>%
  dplyr::ungroup()

L1_mat <- L1_occ %>%
  tidyr::pivot_longer(
    cols      = c(FC, HI, LEI, SC),
    names_to  = "Site",
    values_to = "Count"
  ) %>%
  tidyr::pivot_wider(
    id_cols      = Site,
    names_from   = `Level 1`,
    values_from  = Count,
    values_fill  = 0
  ) %>%
  as.data.frame()

rownames(L1_mat) <- L1_mat$Site
L1_mat$Site <- NULL

str(L1_mat)
head(L1_mat[, 1:5])  

gower_L1 <- cluster::daisy(L1_mat, metric = "gower")

gower_L1

region_df <- data.frame(
  Site = rownames(L1_mat),
  region = ifelse(rownames(L1_mat) %in% c("HI", "LEI"), "Island", "Mainland")
)

region_df$region <- factor(region_df$region)

region_df

permanova_L1 <- vegan::adonis2(
  gower_L1 ~ region,
  data = region_df,
  permutations = 9999
)

permanova_L1
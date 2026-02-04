library(readxl)
library(iNEXT)
library(dplyr)

occ_all <- read_excel("Supplementary Material 1c - L0, L1, L2Occ.xlsx")

L1_agg <- occ_all %>%
  filter(!is.na(`Level 1`)) %>%       
  group_by(`Level 1`) %>%
  summarise(
    FC  = sum(FC,  na.rm = TRUE),
    HI  = sum(HI,  na.rm = TRUE),
    LEI = sum(LEI, na.rm = TRUE),
    SC  = sum(SC,  na.rm = TRUE),
    .groups = "drop"
  )

L1_counts <- L1_agg[, c("FC", "HI", "LEI", "SC")]

L1_counts[is.na(L1_counts)] <- 0

colSums(L1_counts)

L1_list <- list(
  FC  = as.numeric(L1_counts$FC),
  HI  = as.numeric(L1_counts$HI),
  LEI = as.numeric(L1_counts$LEI),
  SC  = as.numeric(L1_counts$SC)
)

totals_L1 <- sapply(L1_list, sum)
totals_L1
L1_list <- L1_list[totals_L1 > 0]

L1_iNEXT <- iNEXT(L1_list, q = 1, datatype = "abundance")

ggiNEXT(L1_iNEXT)

L1_iNEXT

library(readxl)
library(iNEXT)
library(dplyr)

occ_all <- read_excel("Supplementary Material 1c - L0, L1, L2Occ.xlsx")

L0_only <- occ_all %>%
  filter(!is.na(`SYLLABLE`))    

L0_counts <- L0_only[, c("FC", "HI", "LEI", "SC")]

L0_counts[is.na(L0_counts)] <- 0

colSums(L0_counts)

L0_list <- list(
  FC  = as.numeric(L0_counts$FC),
  HI  = as.numeric(L0_counts$HI),
  LEI = as.numeric(L0_counts$LEI),
  SC  = as.numeric(L0_counts$SC)
)

totals <- sapply(L0_list, sum)
totals                        
L0_list <- L0_list[totals > 0]

L0_iNEXT <- iNEXT(L0_list, q = 1, datatype = "abundance")

ggiNEXT(L0_iNEXT)

L0_iNEXT

library(readxl)
library(dplyr)
library(FactoMineR)
library(factoextra)
library(tidyr)

eco <- read_excel("Supplementary Material 1a - Eco-Acoustic.xlsx")   # adjust sheet name if needed


eco <- eco %>%
  mutate(
    MF = (LowFreq + HighFreq) / 2,
    Bw = HighFreq - LowFreq
  )

spec_vars <- c("LowFreq", "HighFreq", "CtrFreq", "PeakFreq", 
               "Delta", "Slope", "Freq1", "Freq2", "MF", "Bw")

spec_data <- eco %>%
  select(all_of(spec_vars)) %>%
  mutate(across(everything(), as.numeric)) %>%
  drop_na()

spec_pca <- prcomp(spec_data, scale. = TRUE)

summary(spec_pca)
fviz_screeplot(spec_pca)
fviz_pca_var(spec_pca)
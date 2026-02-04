library(readxl)
library(dplyr)
library(vegan)     
library(tidyr)

eco <- read_excel("Supplementary Material 1a - Eco-Acoustic.xlsx")

names(eco)

eco_clean <- eco %>%
  rename(
    LF  = LowFreq,
    HF  = HighFreq,
    CF  = CtrFreq,
    DT  = Delta,
    PF  = PeakFreq,
    SL  = Slope,
    F25 = Freq1,
    F75 = Freq2
  )

if(!"Site" %in% names(eco_clean)){
  stop("ERROR: Column 'Site' not found. Check spelling (maybe 'site', 'SITE', or 'Loc'?).")
}

spec_vars <- c("LF","HF","CF","DT","PF","SL","F25","F75")

spec_data <- eco_clean %>%
  select(all_of(spec_vars)) %>%
  mutate(across(everything(), as.numeric)) %>%
  drop_na()

spec_pca <- prcomp(spec_data, center = TRUE, scale. = TRUE)

summary(spec_pca)   

spec_df <- as.data.frame(spec_pca$x) %>%
  mutate(
    Site = eco_clean$Site[!is.na(eco_clean$LF)],
    region = ifelse(Site %in% c("HI","LEI"), "Island", "Mainland")
  )

table(spec_df$Site, spec_df$region)

site_centroids <- spec_df %>%
  group_by(Site) %>%
  summarise(
    PC1 = mean(PC1, na.rm = TRUE),
    PC2 = mean(PC2, na.rm = TRUE),
    PC3 = mean(PC3, na.rm = TRUE),
    .groups = "drop"
  )

site_centroids

pc_mat <- as.matrix(site_centroids[, c("PC1","PC2","PC3")])
rownames(pc_mat) <- site_centroids$Site

dist_spectral <- dist(pc_mat, method = "euclidean")

dist_spectral

genetic_mat <- matrix(
  c(
    0.000, 0.05, 0.06, 0.04,
    0.05,  0.000, 0.02, 0.03,
    0.06,  0.02, 0.000, 0.01,
    0.04,  0.03, 0.01, 0.000
  ),
  nrow=4, byrow=TRUE,
  dimnames=list(c("FC","HI","LEI","SC"), c("FC","HI","LEI","SC"))
)

genetic_dist <- as.dist(genetic_mat)

genetic_dist

geo_mat <- matrix(
  c(
    0,    110,  154,  120,
    110,  0,    110,  140,
    154,  110,  0,    130,
    120,  140,  130,  0
  ),
  nrow=4, byrow=TRUE,
  dimnames=list(c("FC","HI","LEI","SC"), c("FC","HI","LEI","SC"))
)

geo_dist <- as.dist(geo_mat)

geo_dist

mantel_acoustic_genetic <- mantel(
  dist_spectral, genetic_dist,
  method = "pearson",
  permutations = 9999
)

mantel_acoustic_genetic

mantel_acoustic_geo <- mantel(
  dist_spectral, geo_dist,
  method = "pearson",
  permutations = 9999
)

mantel_acoustic_geo

library(dplyr)
library(vegan)

scores <- as.data.frame(spec_pca$x)
scores$site <- eco$Site

spec_df <- scores %>%
  dplyr::select(PC1, PC2, PC3, site) %>%
  dplyr::mutate(
    site   = factor(site),
    region = ifelse(site %in% c("HI", "LEI"), "Island", "Mainland"),
    region = factor(region)
  )

table(spec_df$site, spec_df$region)
dist_PC <- dist(spec_df[, c("PC1", "PC2", "PC3")])
set.seed(123)

permanova_PC <- adonis2(
  as.matrix(dist_PC) ~ region,
  data = spec_df,
  permutations = 999
)
permanova_PC


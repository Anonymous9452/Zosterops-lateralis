## 1. Load packages
library(readxl)
library(dplyr)
library(tidyr)
library(ggplot2)

## 2. Read eco-acoustic data
eco <- read_excel("Supplementary Material 1a - Eco-Acoustic.xlsx")

## 3. Create MF and Bw
eco <- eco %>%
  mutate(
    MF = (LowFreq + HighFreq) / 2,
    Bw = HighFreq - LowFreq
  )

## 4. Select spectral variables and drop NAs
spec_vars <- c("LowFreq", "HighFreq", "CtrFreq", "PeakFreq",
               "Delta", "Slope", "Freq1", "Freq2", "MF", "Bw")

eco_clean <- eco %>%
  drop_na(all_of(spec_vars))

spec_data <- eco_clean %>%
  select(all_of(spec_vars)) %>%
  mutate(across(everything(), as.numeric))

## 5. Run PCA
spec_pca <- prcomp(spec_data, scale. = TRUE)

## 6. Build data frame with PCA scores + site labels
pca_scores <- as.data.frame(spec_pca$x[, 1:2])   # PC1 & PC2
pca_scores$Site <- eco_clean$Site                # make sure column is called 'Site'

## 7. Variance explained (for axis labels)
var_expl <- (spec_pca$sdev^2) / sum(spec_pca$sdev^2) * 100
pc1_var <- round(var_expl[1], 1)
pc2_var <- round(var_expl[2], 1)

## 8. Colours for sites
site_cols <- c(
  "FC"  = "#1b9e77",
  "SC"  = "#e69f00",
  "HI"  = "#7570b3",
  "LEI" = "#e7298a"
)

## 9. Compute centroids
centroids <- pca_scores %>%
  group_by(Site) %>%
  summarise(PC1 = mean(PC1), PC2 = mean(PC2), .groups = "drop")

## 10. Final PCA plot with centroids
p <- ggplot(pca_scores, aes(PC1, PC2, colour = Site)) +
  geom_point(alpha = 0.08, size = 0.6) +
  stat_ellipse(level = 0.95, linewidth = 0.9) +
  geom_point(data = centroids, aes(PC1, PC2, fill = Site),
             shape = 21, size = 4, stroke = 1, colour = "black") +
  scale_color_manual(values = site_cols) +
  scale_fill_manual(values = site_cols) +
  labs(
    x = paste0("PC1 (", pc1_var, "% variance)"),
    y = paste0("PC2 (", pc2_var, "% variance)"),
    colour = "Site", fill = "Site"
  ) +
  theme_classic(base_size = 14) +
  theme(
    legend.position = "right",
    panel.grid = element_blank()
  )

centroids <- pca_scores %>%
  group_by(Site) %>%
  summarise(PC1 = mean(PC1), PC2 = mean(PC2))

ggplot(pca_scores, aes(PC1, PC2, colour = Site)) +
  geom_point(alpha = 0.08, size = 0.6) +
  stat_ellipse(level = 0.95, linewidth = 0.9) +
  geom_point(data = centroids, aes(PC1, PC2, fill = Site),
             shape = 21, size = 4, stroke = 1, colour = "black") +
  scale_color_manual(values = site_cols) +
  scale_fill_manual(values = site_cols) +
  labs(
    x = paste0("PC1 (", pc1_var, "% variance)"),
    y = paste0("PC2 (", pc2_var, "% variance)"),
    colour = "Site", fill = "Site"
  ) +
  theme_classic(base_size = 14)


p   # show it

## 11. Save figure
ggsave("Figure_PCA_multivariate_spectral.png", p,
       width = 7, height = 5, dpi = 600)


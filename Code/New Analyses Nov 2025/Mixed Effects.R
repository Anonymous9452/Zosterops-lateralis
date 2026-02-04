library(readxl)
library(dplyr)
library(tidyr)
library(lme4)
occ_all <- read_excel("Supplementary Material 1c - L0, L1, L2Occ.xlsx")
names(occ_all)
occ_clean <- occ_all %>%
  select(SYLLABLE, `Level 1`, FC, HI, LEI, SC)
occ_L1 <- occ_clean %>%
  filter(`Level 1` != "" & !is.na(`Level 1`))
l1_counts_long <- occ_L1 %>%
  pivot_longer(
    cols = c(FC, HI, LEI, SC),
    names_to = "site",
    values_to = "count"
  ) %>%
  mutate(
    group = `Level 1`,
    site = factor(site, levels = c("FC", "SC", "HI", "LEI"))
  )
head(l1_counts_long)


l1_counts_region <- l1_counts_long %>%
  mutate(
    region = case_when(
      site %in% c("HI", "LEI") ~ "Island",
      site %in% c("FC", "SC")  ~ "Mainland"
    ),
    region = factor(region, levels = c("Mainland", "Island"))
  )

m_region <- lmer(
  log(count + 1) ~ region + (1 | group),
  data = l1_counts_region
)

summary(m_region)
anova(m_region)
vc_region <- as.data.frame(VarCorr(m_region))

var_group_region <- vc_region[vc_region$grp == "group", "vcov"]
var_resid_region <- attr(VarCorr(m_region), "sc")^2

repeatability_region <- var_group_region / (var_group_region + var_resid_region)
repeatability_region

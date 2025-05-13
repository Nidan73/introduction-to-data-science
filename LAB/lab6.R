library(dplyr)

ipl <- read.csv("D:/IPL_Ball_by_Ball_2022.csv", header = TRUE, sep = ",")
summary(ipl)
sapply(ipl, function(x) sum(is.na(x)))

ipl <- ipl[complete.cases(ipl$batsman_run, ipl$isWicketDelivery), ]
ipl$isWicketDelivery <- factor(ipl$isWicketDelivery)

all_feats <- setdiff(names(ipl), c("batsman_run", "isWicketDelivery"))
char_cols <- all_feats[sapply(ipl[all_feats], is.character)]
ipl[char_cols] <- lapply(ipl[char_cols], factor)

numeric_feats <- all_feats[sapply(ipl[all_feats], is.numeric)]
dnumeric_sd <- sapply(ipl[, numeric_feats], sd, na.rm = TRUE)
numeric_feats <- numeric_feats[dnumeric_sd > 0]

# 1. PEARSON (numeric vs numeric)
pearson_vals <- cor(ipl[, numeric_feats], ipl$batsman_run, use = "complete.obs")
pearson_ranked <- sort(abs(pearson_vals), decreasing = TRUE)
head(pearson_ranked, 10)

# 2. SPEARMAN (numeric vs numeric, rank-based)
spearman_vals <- cor(ipl[, numeric_feats], ipl$batsman_run, method = "spearman", use = "complete.obs")
spearman_ranked <- sort(abs(spearman_vals), decreasing = TRUE)
head(spearman_ranked, 10)

# 3. KENDALL (numeric vs numeric, rank-based)
kendall_vals <- cor(ipl[, numeric_feats], ipl$batsman_run, method = "kendall", use = "complete.obs")
kendall_ranked <- sort(abs(kendall_vals), decreasing = TRUE)
head(kendall_ranked, 10)

# 4. MUTUAL INFORMATION (factor vs is_wicket)
cat_feats <- all_feats[sapply(ipl[all_feats], is.factor)]
mi_vals <- sapply(cat_feats, function(f) {
  tbl <- table(ipl[[f]], ipl$isWicketDelivery)
  joint <- tbl / sum(tbl)
  px <- rowSums(joint)
  py <- colSums(joint)
  sum(joint * log(joint / (px %o% py)), na.rm = TRUE)
})
mi_ranked <- sort(mi_vals, decreasing = TRUE)
head(mi_ranked, 10)

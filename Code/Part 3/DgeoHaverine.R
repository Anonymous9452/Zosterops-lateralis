# Geosphere package is to use the distHaversine function
library(geosphere)

# Creating a data frame with site names, latitude, and longitude values
sites <- data.frame(
  site = c("FC", "HI", "LEI", "SC"),
  lat = c(-25.2753, -23.4423, -24.1137, -26.65),
  lon = c(152.8751, 151.9148, 152.7154, 153.0667)
)

# Creating a matrix with latitude and longitude coordinates
coords <- sites[, c("lon", "lat")]
# Calculating geographical distance matrix using distHaversine
dist_matrix <- distm(coords, fun = distHaversine)

# Adding row and column names to the distance matrix
rownames(dist_matrix) <- sites$site
colnames(dist_matrix) <- sites$site

# Printing the geographical distance matrix
print(dist_matrix)
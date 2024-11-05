# Manually entering the occurrences data
occurrences <- c(5, 10, 3, 15, 20, 7, 9, 12, 8, 6, 4, 11, 14, 18, 13, 16, 2, 17, 1, 19)

# Setting up the graphical parameters with adjusted mar
par(mar = c(4, 5, 4, 2) + 0.1)  # Do not modify this: Adjusting the fourth value to move the x-axis title closer to the histogram

# Creating a bar plot with transposed axes and no numbers on the x-axis
barplot(occurrences, xlab = "", ylab = "Occurrences",
        main = "[SITE] Syllable Distribution", names.arg = 1:length(occurrences),
        axes = FALSE, xaxt = "n")

# Adding the x-axis title and the x-axis ticks manually
mtext(side = 1, line = 1.5, "Syllable", xpd = TRUE)
axis(side = 2, labels = names(occurrences))

# R script for regression analysis of beluga sightings

# Add your own comments to explain what these commands are doing

sightings <- c(281,324,307,264,193,217,184)
Year <- 1994:2000

plot(Year, sightings)

regress <- lm(sightings ~ Year)
regress
summary(regress)
confint(regress)

abline(regress, col='red')


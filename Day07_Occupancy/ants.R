
# Ant occupancy survey
# ====================

# Details are at
# http://www.wcsmalaysia.org/analysis/ants_occupancy.htm

# Load the 'wiqid' package
library(wiqid)

# Read in data file - CHANGE 'antsExample.csv' TO THE NAME OF YOUR FILE!
DH <- read.csv("antsExample.csv", na.strings='-',row.names=1)
# DH <- read.csv(file.choose(), na.strings='-')

dim(DH)
head(DH)

# Do basic analysis
y <- rowSums(DH, na.rm=TRUE)  # how many people saw ants
n <- rowSums(!is.na(DH))      # how many people looked
cbind(y, n)
mean(y > 0)  # Naive estimate

?occSS0
( ants0 <- occSS0(y, n) )

( antsB <- BoccSS0(y, n) )
plot(antsB)
plot(antsB, "p")


# What's the probability that the occupancy is above 0.85?
names(antsB)
dim(antsB)
mean(antsB$psi > 0.85)


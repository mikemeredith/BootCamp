
library(wiqid)
# check that you have version 0.0.387 or  later

# Put in YOUR DATA here
x <- c(858, 1244, 1047, 1261, 1385,  998, 1016,  999,  631,  943)
length(x)  # Should be 10
mean(x)
x.bar <- mean(x)
( x.bar <- mean(x) )
( sd.x <- sd(x) )   # Should be the same values that you got in the spreadsheet

# Bayesian credible interval
# Uninformative priors
( sq1 <- Bnormal(x) )
plot(sq1)
densityPlot(sq1)
plot(sq1, "sigma")

# What has Bnormal produced?
head(sq1)
nrow(sq1)
colMeans(sq1)

plot(sq1$mu[1:200], type='l')
abline(h=1001.48,col='green')
abline(h=x.bar,col='blue')

# Put in YOUR prior for 'mu':
?Bnormal
( sq2 <- Bnormal(x, priors=list(muMean=2250, muSD=300)) )
plot(sq2)
plot(sq2, "sigma")

# Compare uninformative vs informative priors:
par(mfrow=c(2,1))
plot(sq1, xlim=c(800, 1500), main="Flat priors")
plot(sq2, xlim=c(800, 1500), main="Prior for mu ~ Normal(2250, 300)")
par(mfrow=c(1,1))

?Bnormal2

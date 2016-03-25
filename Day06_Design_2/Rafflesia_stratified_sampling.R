
# Rafflesia - stratified sampling

# This script looks at the advantages of a stratified design when Rafflesia
#   are not distributed evenly over the study area.
# See Rafflesia_stratified_sampling.pdf for background information.

# Updated 23 Nov 2015

# Study area:
# -----------
# This is code to produce a nice plot; it isn't part of the analysis
East <- rep(1:20, 20)
North <- rep(1:20, each=20)
cbind(East,North)
plot(x=East, y=North, xlim=c(0.5,20.5), ylim=c(0.5,20.5), xaxs='i', yaxs='i', type='n')
rect(0.5,0.5,20.5,8.5,border=NA, col='lightgreen')
box()
abline(v=(1:19)+0.5, h=(1:19)+0.5, col='grey')

# The population
# ==============
set.seed(123)
truePop <- c(rpois(160,10), rpois(240,1))
text(East,North, truePop, cex=0.6)
(tau <- sum(truePop)) # no. of Rafflesia in the population
sum(truePop[1:160])   # in the high density area...
sum(truePop[161:400]) # ...and in the low density area

# Unstratified simple random sampling:
# ====================================
x <- sample(truePop, 20)
mean(x) * 400 # estimated no. of Raff. in the pop.

# Do thousands of samples
# -----------------------
tau.hatU <- numeric(1000)

for(i in 1:1000) {
  x <- sample(truePop, 20)
  tau.hatU[i] <- mean(x) * 400
}
head(tau.hatU)
mean(tau.hatU)
tau
hist(tau.hatU)
abline(v = tau, col='blue')
abline(v = mean(tau.hatU), col='red')


# Stratified sampling
# ===================
n1 <- 8 # from densely populated area
n2 <- 12 # from less pop.

x1 <- sample(truePop[1:160], n1)
x2 <- sample(truePop[161:400], n2)
mean(x1) * 160 + mean(x2) * 240


tau.hat8.12 <- numeric(1000)

for(i in 1:1000)  {
  x1 <- sample(truePop[1:160], n1)    # sample from high density ares...
  x2 <- sample(truePop[161:400], n2)  # ...and from low density area.
  tau.hat8.12[i] <- mean(x1) * 160 + mean(x2) * 240 # add estimates together
}

mean(tau.hat8.12)
tau
hist(tau.hat8.12)
abline(v = tau, col='blue')
abline(v = mean(tau.hat8.12), col='red')

# Stratified sample, more plots in high density area
n1 <- 12
n2 <- 8
tau.hat12.8 <- numeric(1000)
for(i in 1:1000)  {
  x1 <- sample(truePop[1:160], n1)
  x2 <- sample(truePop[161:400], n2)
  tau.hat12.8[i] <- mean(x1) * 160 + mean(x2) * 240
}

mean(tau.hat12.8)
tau
hist(tau.hat12.8)
abline(v = tau, col='blue')
abline(v = mean(tau.hat12.8), col='red')

# Compare histograms
par(mfrow=c(3,1))
hist(tau.hatU, xlim=c(500, 3500), main="Unstratified")
hist(tau.hat8.12, xlim=c(500, 3500), main="Stratified, 8 vs 12")
hist(tau.hat12.8, xlim=c(500, 3500), main="Stratified, 12 vs 8")
par(mfrow=c(1,1))

# Compare RMSE
sqrt(mean((tau.hatU - tau)^2))
sqrt(mean((tau.hat8.12 - tau)^2))
sqrt(mean((tau.hat12.8 - tau)^2))

# Do beeswarm plot
library(beeswarm)
df <- data.frame(un=tau.hatU, s8.12=tau.hat8.12, s12.8=tau.hat12.8)
beeswarm(df, cex=0.5, col='blue', method='hex')
abline(h=tau, col='red', lwd=3)

# 12.8 has lowest RMSE; try even more from high density area:
n1 <- 17
n2 <- 3
tau.hat17.3 <- numeric(1000)
for(i in 1:1000)  {
  x1 <- sample(truePop[1:160], n1)
  x2 <- sample(truePop[161:400], n2)
  tau.hat17.3[i] <- mean(x1) * 160 + mean(x2) * 240
}
sqrt(mean((tau.hat17.3 - tau)^2))  # Not so good as 12.8


# Estimate density from stratified sampling
# =========================================
n1 <- 12 # from densely populated area (stratum #1)
n2 <- 8  # from less densely populated area (stratum #2)

x1 <- sample(truePop[1:160], n1)
x2 <- sample(truePop[161:400], n2)
( d1 <- mean(x1) )  # estimated density for stratum #1
( d2 <- mean(x2) )  # ...and for stratum #2.

# Combine densities as a weighted mean of d1 and d2, with the proportions
#   of the area as the weights
w1 <- 160/400  # proportion of area in stratum #1...
w2 <- 240/400  # ...and in stratum #2
# Estimated mean density over the whole study area:
d1*w1 + d2*w2

# or do it in one line:
#      v proportion of area in stratum #1
d1*(160/400) + d2*(240/400)
#                     ^ proportion of area in #2


# What happens if we do stratified sampling data collection
#  but simple random analysis?
# =========================================================
n1 <- 12
n2 <- 8

tau.hat.bad <- numeric(1000)

for(i in 1:1000)  {
  x1 <- sample(truePop[1:160], n1)
  x2 <- sample(truePop[161:400], n2)
  x <- c(x1, x2)  # Combine the two samples into a simgle sample
  tau.hat.bad[i] <- mean(x) * 400
}

mean(tau.hat.bad)
tau
hist(tau.hat.bad)
abline(v = tau, col='blue')
abline(v = mean(tau.hat.bad), col='red')

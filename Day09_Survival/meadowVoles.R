
library(wiqid)

# Meadow voles data from Williams-Nichols-Conroy 2002  p525ff

# Meadow voles (Microtus pennsylvanicus) were trapped at Patuxent Research 
#  Center, Maryland, USA, for 5 consecutive days each month for 6 months.

mvoles <- read.csv("MeadowVoles.csv", row.names=1)
head(mvoles)
DH <- mvoles[, 1:30]
freq <- mvoles[, 31]
colSums(DH)

# The population can be assumed to be closed for each 5-day 'season', and births,
#  deaths, immigration, emigration occur predominantly during the 25 days
#  between seasons.
# We can use closed-capture models to estimate capture probability for each
#  season, and plug this into our open population model to estimate apparent
#  survival. We can then estimate separate parameters for detection and survival.
# With abundance estimates from the closed-capture analyses, we can also
#  estimate recruitment rates.

# AD HOC METHOD
# =============
# For the 'ad hoc' method, you can use any closed capture model for
#   within-season p and N estimation. For the voles, individual 
#   heterogeneity in capture probability is indicated, so we'll use the 
#   jackknife estimator, closedCapMhJK, for each season's data.
library(wiqid)

MhResult <- matrix(NA, 6, 2)
colnames(MhResult) <- c("Nhat", "pHat")
( seasonID <- rep(1:6, each=5) )  
for(i in 1:6) {   
  dh <- DH[, seasonID == i]
  MhResult[i, ] <- closedCapMhJK(dh)$real[, 1]
}
MhResult 

# Now do the apparent survival estimates, using N and pStar from
#   the closed capture analysis.
# pStar = probability of being captured at least once
#   during the season:
( pStar <- 1 - (1 - MhResult[, 2])^5 )

( mv1 <- survRDah(DH, 1, 5, N=MhResult[, 1], pStar=pStar) )

# Plot the results:
plot(mv1$bHat, pch=19, type='b', col='blue', ylab='', xlab="Interval")
points(mv1$phiHat, pch=19, type='b', col='red')
legend('topleft', c("recruitment ratio", "apparent survival"), pch=19, lty=1,
  col=c("blue", "red"), bty='n')


# We can combine the within-season and between-season analyses to get maximum
#   likelihood estimates of all the parameters. survRD uses model M0 for the
#  within-season analysis:
( mv2 <- survRD(DH, 1, 5) )

# Compare the estimates for N and p:
cbind(MhResult, Nhat2=mv2$Nhat, pHat2=mv2$pHat)

# Compare the estimates of phi and b:
plot(mv1$bHat, pch=19, type='b', col='blue', ylab='', xlab="Interval")
points(mv1$phiHat, pch=19, type='b', col='red')
points(mv2$bHat, lty=3, type='b', col='blue')
points(mv2$phiHat, lty=3, type='b', col='red')
legend('topleft', c("model 1, recruitment", "model 1, survival",
  "model 2, recruitment", "model 2, survival"), pch=c(19,19,1,1),
  lty=c(1,1,3,3), col=c("blue", "red", "blue", "red"), bty='n')

# How many recruits
B1 <- c(0, mv1$Nhat[-6] * mv1$bHat)
B2 <- c(0, mv2$Nhat[-6] * mv2$bHat)
barplot(rbind(mv1$Nhat, mv2$Nhat), beside=TRUE,
  names.arg=paste("Yr", 1:6), 
  ylab="Survivors (grey), recruits (blue)", ylim=c(0, 100))
barplot(rbind(B1, B2), beside=TRUE, add=TRUE, col=c('blue', 'lightblue'))




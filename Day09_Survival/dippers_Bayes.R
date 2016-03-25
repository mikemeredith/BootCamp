library(wiqid)

# The classic Lebreton et al dipper data set:
dippers <- read.csv("dippers.csv")
head(dippers)

DH <- dippers[, 1:7]

Bdip <- BsurvCJS(DH, phi ~ .time)
Bdip

survCJS(DH, phi ~ .time)  # MLE result for comparison
plot(Bdip)
plot(Bdip, "phi2")
plot(Bdip, "p1")
# What's the probability that phi2 > 0.5
mean(Bdip$phi2 > 0.5)

# The flood in 1983 may have affected survival in years 2 and 3.
# Put the data into a data frame:
( fd <- data.frame(flood = c(FALSE, TRUE, TRUE, FALSE, FALSE, FALSE)) )

BdipFlood <- BsurvCJS(DH, list(phi ~ flood, p ~ .time), data=fd)
BdipFlood
survCJS(DH, list(phi ~ flood, p ~ .time), data=fd)  # for comparison
par(mfrow=2:1)
plot(BdipFlood, "phi1")
plot(BdipFlood, "phi2")
# Do plots on same x-axis
plot(BdipFlood, "phi1", xlim=c(0.3, 0.75))
plot(BdipFlood, "phi2", xlim=c(0.3, 0.75))
par(mfrow=c(1,1))

dif <- BdipFlood$phi1 - BdipFlood$phi2
mean(dif)
# Probability the dif > 0
mean(dif > 0)
# Probability the dif > 0.2
mean(dif > 0.2)

ratio <- BdipFlood$phi2 / BdipFlood$phi1
hist(ratio)
# Probability the ratio < 0.75
mean(ratio < 0.75)


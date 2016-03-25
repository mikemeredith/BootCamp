
# Johor muntjac analysis

library(wiqid)

# Read in data file
DH <- read.csv("JohorMuntjac.csv", header=TRUE, row.names=1)
dim(DH)
head(DH)

# Do basic analysis
jm0 <- occSS(DH)
jm0

# Autocorrelation between transect segments
# probability of detection is different if muntjac
#  were detected on the preceeding segment
jmAc <- occSS(DH, p~.b)
jmAc
AICtable(AIC(jm0, jmAc))


jmRN <- occSSrn(DH)
jmRN
AICtable(AIC(jm0, jmAc, jmRN))










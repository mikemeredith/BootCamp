
# Bayesian Analysis of occupancy data for American toads
# ======================================================

# Details are at
# http://www.wcsmalaysia.org/analysis/Occupancy_AmToads.htm


library(wiqid)

# Read in data file with detection histories
at <- read.csv("AmToad.csv", na.string='-')

# separate the detection histories 
DH <- at[, 1:82] # all rows, first 82 columns

# Data summaries
y <- rowSums(DH, na.rm=TRUE)  # Number of times toads were heard
n <- rowSums(!is.na(DH))      # No. of times someone listened
cbind(y, n)

# Model without covariates
# ========================
# Simplest model, psi(.) p(.):
?BoccSS0
( at0B <- BoccSS0(y, n) )
plot(at0B)

# Compare estimates with MLE:
occSS0(y, n)

plot(at0B, "p")

# Bayesian analysis of model with habitat effect and time
( BatHab_T2 <- BoccSS(DH, list(psi~Habitat, p~.Time + I(.Time^2)), data=at) )
tracePlot(BatHab_T2)  # Problem with habitat covariate
# Try a model with uniform priors on psi
( BatHab_T2 <- BoccSS(DH, list(psi~Habitat-1, p~.Time + I(.Time^2)), data=at,
    priors=list(sigmaPsi=c(1,1))) )
tracePlot(BatHab_T2) # Looks a lot better
densityPlot(BatHab_T2)
plot(BatHab_T2)

# Look at occupancy plots for ponds and nonponds:
psiPond <- pnorm(BatHab_T2$psi_Habitatpond)
psiNonpond <- pnorm(BatHab_T2$psi_Habitatnonpond)
par(mfrow=2:1)
plotPost(psiPond, xlim=0:1)
plotPost(psiNonpond, xlim=0:1)

# If you have already run the ML estimates, compare them:
# (Sites 1-4 ponds, sites 5-6 nonponds)
# head(atHab_T2$real)

# What's the probability that occupancy of ponds is higher?
mean(psiPond > psiNonpond)


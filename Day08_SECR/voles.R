
# "Vole" density survey with SECR
# ===============================

# Details are at
# http://wcsmalaysia.org/analysis/SECR_voles_activity.htm

# Load the 'secr' package
library(secr)

# Read in the data (CHANGE THE FILE NAME to the current value!)
vole.ch <- read.capthist("volecapt_old.txt", "voletrap.txt", noccasions=25)
# You need both capture history and trap location files!

# Plot the data
plot(vole.ch)
?plot.capthist
plot(vole.ch, tracks=TRUE)

summary(vole.ch)
?summary.capthist  # Look for explanations

# MLE analysis
# ============
vole.fit <- secr.fit(vole.ch)
vole.fit

plot(vole.fit)

# Bayesian analysis
# =================
library(wiqid)

# Run Bsecr0 with vole.fit at the starting point
# takes 10 minutes so only do this if you have time!
# voleB <- Bsecr0(vole.ch, start=vole.fit)
# voleB
# predict(vole.fit)  # Comparison

# plot(voleB)  # Ugly!
# plot(voleB, showCurve=TRUE)  # Ok

# plot(voleB, which='sigma')
# plot(voleB, which='lam0')


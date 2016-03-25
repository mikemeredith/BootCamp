

# USING THE secr PACKAGE WITH STOAT DATA SET

# This is the code only: please insert your own
#   comments to explain what's happening.

# ##########################################

# Some of the analyses take a long time to run. You can load pre-cooked
#   results from 'stoats.Rdata':
load("stoats.Rdata")

# Load the secr package; this also loads other packages that secr needs:

library(secr)

? secr
  # At the bottom of this page is a link to the Index of functions.

stt <- read.capthist("stoatcapt.txt", "stoattrap.txt", detector = "proximity")
summary(stt)

? summary.capthist

plot(stt)
?plot.capthist 
plot(stt, rad=50, tracks=TRUE)

?secr.fit
stt.HN <- secr.fit(stt, buffer = 1000)
stt.HN

plot(stt.HN)
plot(stt.HN, xval=(0:100)*8)
abline(v=254.8, col='red')
abline(h=0.0453, lty=2, col='blue')

stt.EX <- secr.fit(stt, buffer = 1000, detectfn=2) # Took 1.1 mins

AIC(stt.HN, stt.EX)


plot(stt.EX, xval=(0:100)*8, col='red')
plot(stt.HN, xval=(0:100)*8, add=TRUE, col='blue')
abline(v=254.8, col='blue')
abline(h=0.0453, lty=2, col='blue')

abline(v=162.6, col='red')
abline(h=0.112, lty=2, col='red')

collate(stt.HN, stt.EX, realnames='D', perm=c(2,3,4,1))


# stt.g0.b <- secr.fit(stt, model=g0 ~ b, buffer = 1000) # Took 8 mins 
stt.g0.b 
# stt.g0.B <- secr.fit(stt, model=g0 ~ B, buffer = 1000) # Took 7 mins 
stt.g0.B 

AIC(stt.HN, stt.g0.b, stt.g0.B)

# These models take a long time to run, so I stored the results for you to
#    load.
# stt.sigma.t <- secr.fit(stt, model=sigma ~ t, buffer = 1000) # Took 11 mins 
# stt.sigma.T <- secr.fit(stt, model=sigma ~ T, buffer = 1000) # Took 7 mins 
# stt.sigma.T2 <- secr.fit(stt, model=sigma ~ T + I(T^2), buffer = 1000) # Took 7 mins 

stt.sigma.t 
stt.sigma.T 

AIC(stt.HN, stt.sigma.t, stt.sigma.T)
collate(stt.HN, stt.sigma.t, stt.sigma.T, realnames='D', perm=c(2,3,4,1))

# Let's look at the output from one of these models
stt.g0.b
# Look at the betas: g0.bTRUE is the difference between animals caught before
#  and animals not caught before.

coef(stt.g0.b)

plogis(-3.4935752 + 0.4829317) # prob. of capture if caught before

predict(stt.g0.b, newdata = data.frame(b=0:1))
derived(stt.g0.b)        # Takes a moment

# What is a 'mask' in secr?
plot(stt.HN$mask, col='black')
plot(stt, rad=50, tracks=TRUE, add=TRUE)
plot(traps(stt), add=TRUE)

# Bayesian version of 'secr':
library(wiqid)

# THIS TAKES >40 mins, only run it if you have time!
#   sttB <- Bsecr0(stt, buffer=1000)
sttB
plot(sttB)


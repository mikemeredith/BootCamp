library(wiqid)

# The classic Lebreton et al dipper data set:
dippers <- read.csv("dippers.csv")
head(dippers)

DH <- dippers[, 1:7]

# Model with same phi and p each year
survCJS(DH)  # the phi(.) p(.) model

# Try models with different phi or p each year
survCJS(DH, p ~ .time)   # using in-built .time covariate

survCJS(DH, phi ~ .time)


# Try both...
survCJS(DH, list(phi ~ .time, p ~ .time)) # This doesn't work!
	# ...can't be done.

# The flood in 1983 may have affected
#  survival in years 2 and 3.
# Put the data into a data frame:
( fd <- data.frame(flood = c(FALSE, TRUE, TRUE, FALSE, FALSE, FALSE)) )

( dipFlood <- survCJS(DH, phi ~ flood, data=fd) )
	# This has lowest AIC so far
	# Survival depends on flooding
dipFlood$beta

survCJS(DH, list(phi ~ flood, p ~ .time),
   data=fd)
	# AIC higher, p doesn't change


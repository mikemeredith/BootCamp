
# rats survival analysis

rats <- read.csv("AArats.csv", header=TRUE, row.names=1)
dim(rats)
summary(rats)

library(wiqid)

# Do a simple analysis, one value for
#   phi (apparent survival) and one value
#   for recapture probability:
( rats0 <- survCJS(rats) )

# Try a different value for phi for each
#   year:
( rats1 <- survCJS(rats, phi~.time) )
   # Didn't work for my data!

# Try different recapture probabilities:
( rats2 <- survCJS(rats, p~.time) )
	# That worked!

# Not possible to have a different phi and
#  different p for the last occasion:
survCJS(rats, list(phi~.time, p~.time))

# Try Bayesian analysis
ratsB <- BsurvCJS(rats)
ratsB
plot(ratsB)





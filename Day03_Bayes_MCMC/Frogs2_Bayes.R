
# Getting a credible interval for binary data

library(wiqid)

# the Bbinom function needs no. of successes and no. of trials:
frogs <- Bbinom(8, 10)
frogs
plot(frogs)

# With an informative prior:
frogs2 <- Bbinom(8, 10, priors=list(mode=0.6, conc=3))
frogs2
plot(frogs2)


# What happens with 10 out of 10?
frogs <- Bbinom(10, 10)
frogs
plot(frogs)

# What happens with 100 out of 100?
frogs <- Bbinom(100, 100)
frogs
plot(frogs)




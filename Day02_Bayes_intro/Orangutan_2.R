# Bayesian analysis of orangutan data

# Do the 'columns' of a Bayes Table
N <- 10:600
N
# PRIOR
priorMean <- 240
priorSD <- 100
prior <- dnorm(N, priorMean, priorSD)
plot(N, prior, type='l')

# LIKELIHOOD
count <- 19
Na <- N / 160 * 10  # Number we'd expect in 10 sq km
head(Na)
llh <- dpois(count, Na)
llh2plot <- llh / sum(llh)
lines(N, llh2plot, col='green')  # Ooops! we'll replot later

# PRODUCT
product <- llh * prior

# POSTERIOR
post <- product / sum(product)
plot(N, post, type='l', col='brown')
lines(N, llh2plot, col='green')
lines(N, prior, col='blue')

# Posterior mean
sum(N * post)

# Probability that there are > 400 orangutan in the Park:
sum(post[N > 400])

# Get a 95% HDI
library(wiqid)
plotComb(N, post)

# With versions of wiqid < 0.0.399 you'll need to do this:
# dens <- data.frame(x=N, y=post)
# wiqid:::hdi.density(dens)


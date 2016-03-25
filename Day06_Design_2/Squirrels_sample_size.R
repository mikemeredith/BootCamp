
# A common question is "How big should my sample be?". There's no simple answer,
#   but simulations can help you to decide.

# Earlier in the workshop, we simulated data for squirrel weights with sample size n = 10.
# What would happen if we used a smaller sample, or a bigger sample?
#   How good would our estimates be?

# The biological model
# ====================
# We will assume that squirrel weights are normally distributed, with mean
mu <- 1000  # grams, and standard deviation
sigma <- 150

# The observation model
# =====================
# We will assume that our sampling method gives a representative, random sample from
#   the population of squirrels. Then we can use 'rnorm()' to generate samples.
n <- 10  # sample size, we'll try different values later
( x <- rnorm(n, mu, sigma) )  # Produces a different sample each time we run it.

# Generating many samples and many estimates
# ==========================================
# We saw with the plastic chips that each person got a different estimate of the population
#   mean. Let's do 1000 samples and look at the distribution of the estimates.
# For that we need a loop in R.

B <- 1000  # The number of samples to generate
estimate <- numeric(B)  # Create a store to hold all the estimates.

for(b in 1:B)  {
  x <- rnorm(n, mu, sigma)
  estimate[b] <- mean(x)
}

head(estimate)  # Look at the first 6 values
hist(estimate)  # Display all 1000

# Check the mean of the estimates
mean(estimate)
  # if our method is unbiased, this should be close to the true value.
  
# Try different sample sizes
# ==========================
B <- 1000  # The number of samples to generate

# Sample size n = 4
estimate4 <- numeric(B)  # Create a store to hold all the estimates.
for(b in 1:B)  {
  x <- rnorm(4, mu, sigma)
  estimate4[b] <- mean(x)
}

# Sample size n = 10
estimate10 <- numeric(B)  # Create a store to hold all the estimates.
for(b in 1:B)  {
  x <- rnorm(10, mu, sigma)
  estimate10[b] <- mean(x)
}

# Sample size n = 30
estimate30 <- numeric(B)  # Create a store to hold all the estimates.
for(b in 1:B)  {
  x <- rnorm(30, mu, sigma)
  estimate30[b] <- mean(x)
}

# Check for bias
mean(estimate4)
mean(estimate10)
mean(estimate30)

# Compare the estimates
# =====================

# Method 1: look at histograms
# ----------------------------
par(mfrow = c(3, 1))  # Put 3 histograms into the same plot
hist(estimate4)
hist(estimate10)
hist(estimate30)

# For comparison, give them all the same scale on the x axis (and proper titles)
#  and add the true value
hist(estimate4, xlim=c(700, 1300), main="n = 4")
abline(v = mu, col='red')
hist(estimate10, xlim=c(700, 1300), main="n = 10")
abline(v = mu, col='red')
hist(estimate30, xlim=c(700, 1300), main="n = 30")
abline(v = mu, col='red')
par(mfrow = c(1, 1))  # Change back to a single plot when we have finished.

# Method 2: Calculate errors
# --------------------------
# Since we know the true value, we can calculate the errors, and summarise these as
#   Root Mean Square Error (RMSE)
sqrt(mean((estimate4 - mu)^2))
sqrt(mean((estimate10 - mu)^2))
sqrt(mean((estimate30 - mu)^2))

# Method 3: Beeswarm plots
# ------------------------
library(beeswarm)
# The beeswarm function needs a data frame as its input
df <- data.frame(n4 = estimate4, n10 = estimate10, n30 = estimate30)
beeswarm(df)
# Ok... now let's make that prettier
beeswarm(df, method='hex', cex=0.5, col='blue', las=1,
  xlab="Sample size", ylab="Estimated mean weight of squirrels")
# Add a horizontal line with the true value:
abline(h = mu, col='red', lwd=2)

# Decisions, decisions!
# =====================
# How accurate do you need to be?
# Suppose we wanted to be within 100g of the true value, ie, between 900 and 1100g

# Add these to the beeswarm plot:
abline(h = c(900, 1100), col='red', lty=2)

# What's the probability that we will get an estimate with an error greater than 100g?
mean(abs(estimate4 - mu) > 100)
mean(abs(estimate10 - mu) > 100)
mean(abs(estimate30 - mu) > 100)

# How robust is your decision?
# ============================
# Try running the code above with different values of mu and sigma:
#  1. How would your decision be affected if mu = 1200g instead of 1000?
#  2. How would your decision be affected if sigma = 75g instead of 150?
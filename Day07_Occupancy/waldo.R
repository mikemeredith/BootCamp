
# Waldo exercise analysis

# Load the 'wiqid' package
library(wiqid)

# Read in data file - CHANGE 'waldo_old.csv' TO THE NAME OF YOUR FILE!
DH <- read.csv("waldo_old.csv", header=TRUE, row.names=1, na.strings='-')
# DH <- read.csv(file.choose(), header=TRUE, row.names=1, na.strings='-')

dim(DH)
head(DH)

# Do basic analysis
y <- rowSums(DH, na.rm=TRUE)  # how many people saw Waldo
n <- rowSums(!is.na(DH))      # how many people looked

# Naive estimate
mean(y > 0)

?occSS0
wal0 <- occSS(DH)
wal0
# psi is ...
# p is ...

walB <- BoccSS0(y, n)
walB
plot(walB)

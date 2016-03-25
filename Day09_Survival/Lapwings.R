library(wiqid)

# Sociable lapwings data from Kazakhstan

# Read in the data set 
lw <- read.csv("lapwings.csv")
head(lw)
DH <- lw[, 1:7]


survCJSaj(DH, freqj=lw$Chicks, freqa=lw$Adults)

survCJSaj(DH, model=p~.time, freqj=lw$Chicks, freqa=lw$Adults)

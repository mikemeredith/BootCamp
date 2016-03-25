
# Multiseason occupancy with Grand Skinks data

# MacKenzie et al (2006) Occupancy estimation and modeling, page 194ff
# The data are distributed with program PRESENCE.

library(wiqid)

# 'skinks1.csv' is a subset of the MacKenzie et al data set:
#   sites which only have data for the first season have been
#   deleted.
gs <- read.csv("skinks1.csv", header=TRUE, row.names=1, na.str="-")
dim(gs)
head(gs)
str(gs)
DH <- gs[, 1:15]

?occMS0

gsMS0 <- occMS0(DH, 3)
gsMS0

gs_s.s <- occMStime(DH, 3, list(gamma ~ .interval, epsilon~1, p~.season))
   # 13 secs
gs_s.s

# this takes 8 secs
gs_hhh. <- occMS(DH, 3,
   model=list(psi1~Habitat, gamma ~ Habitat, epsilon~Habitat),
   data=gs)
gs_hhh.

AIC(gsMS0, gs_s.s, gs_hhh.)

# takes 43 secs
gs_h_hs_hs_s <- occMS(DH, 3,
   model=list(psi1~Habitat, gamma ~ Habitat+.interval, epsilon~Habitat+.interval, p~.season),
   data=gs)

AIC(gsMS0, gs_s.s, gs_hhh., gs_h_hs_hs_s)


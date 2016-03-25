
# Maximum likelihood analysis of occupancy data for American toads
# ================================================================

# Details are at
# http://www.wcsmalaysia.org/analysis/Occupancy_AmToads.htm


library(wiqid)

# Read in data file with detection histories
at <- read.csv("AmToad.csv", na.string='-')

dim(at)  # dimensions, number of rows and columns
# 29 sites, 165 columns
names(at)  # column names

# separate the detection histories 
DH <- at[, 1:82] # all rows, first 82 columns

# Data summaries
y <- rowSums(DH, na.rm=TRUE)  # Number of times toads were heard
n <- rowSums(!is.na(DH))      # No. of times someone listened
cbind(y, n)

# Naive estimate
mean(y > 0)

# Model without covariates
# ========================
( at0 <- occSS0(y, n) )

# Models with the habitat covariate
# =================================
# occupancy (psi) different for ponds and nonponds
( atHab_. <- occSS(DH, psi ~ Habitat, data=at) )
at$Habitat  # See if sites 1 and 5 are ponds or nonponds
atHab_.$beta

# p different for ponds and nonponds
( at._Hab <- occSS(DH, p ~ Habitat, data=at) )

# psi AND p different for ponds and nonponds
( atHab_Hab <- occSS(DH, list(psi~Habitat, p~Habitat), data=at) )

AICc(at0, atHab_., at._Hab, atHab_Hab)
AICtable(AICc(at0, atHab_., at._Hab, atHab_Hab))

# Including the survey covariate, temperature
# ===========================================

# model psi(.) p(temperature)
( at._Temp <- occSS(DH, p~Temp, data=at) )
AICc(at0, at._Temp)

# The effect of time
# ==================
# occSS with do this, but occSStime draws plots
# Linear trend
( at._T <- occSStime(DH, p~.Time) )

# Quadratic trend ("hump or hollow")
( at._T2 <- occSStime(DH, p~.Time + I(.Time^2)) )

AICc(at0, at._T, at._T2)
  # time is important!

# Time and habitat
( atHab_T2 <- occSS(DH, list(psi~Habitat, p~.Time + I(.Time^2)),
  data=at) )
AICc(at._T2, atHab_T2)


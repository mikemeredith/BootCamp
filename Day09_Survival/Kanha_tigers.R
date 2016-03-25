
# Closed-capture analysis of camera trapping data for
#   tigers from Kanha Tiger Reserve

library(wiqid)

Kanha <- read.csv("Kanha_tigers.csv")
head(Kanha)
dim(Kanha)

closedCapM0(Kanha)
closedCapMb(Kanha)
closedCapMh2(Kanha)
closedCapMhJK(Kanha)
closedCapMt(Kanha)

# Generate some mythical covariates:
covars <- data.frame(Temp = runif(ncol(Kanha), 15, 25),
  Cloud = sample(0:8, ncol(Kanha), replace=TRUE))
closedCapMtcov(Kanha, p~Cloud, data=covars)
  
# Compare the normal (default) and MARK confidence intervals for N:
rbind(closedCapMt(Kanha)$real[1, ],
      closedCapMt(Kanha, ciType="MARK")$real[1, ])
      

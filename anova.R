##ANOVA
#load the data
library(oibiostat)
data("famuss")

#create plot to check whether the association between change in arm strength and genotype
plot(famuss$ndrm.ch ~ famuss$actn3.r577x)

# check assumptions if the obsercations are independent within and across groups
## Q-Q plots
par(mfrow = c(1, 3))

qqnorm(famuss$ndrm.ch[famuss$actn3.r577x == "CC"], main = "Q-Q for CC genotype")
qqline(famuss$ndrm.ch[famuss$actn3.r577x == "CC"])

qqnorm(famuss$ndrm.ch[famuss$actn3.r577x == "CT"], main = "Q-Q for CT genotype")
qqline(famuss$ndrm.ch[famuss$actn3.r577x == "CT"])

qqnorm(famuss$ndrm.ch[famuss$actn3.r577x == "TT"], main = "Q-Q for TT genotype")
qqline(famuss$ndrm.ch[famuss$actn3.r577x == "TT"])
## analysis from Q-Q plots
## Possible of right skew
## the data does not fully follow a normal distribution,but loosely follow a normal distribution

tapply(famuss$ndrm.ch, famuss$actn3.r577x, var)
#  CC        CT        TT 
# 897.3667 1104.3311 1273.8712 
## Rule of thumb for assesing equal variance in the ANOVA is to check the 
## ratio of the largest ratio of the largest variance to the smallest variance
## a ratio less than 3 is considered acceptable to coduct the ANOVA F-test


## Compute the F-statistic and p-value
summary(aov(famuss$ndrm.ch ~ famuss$actn3.r577x))
## There is a differnece in population mean change in non-dominatn arm change between the groups

##For post hoc, pairwise.t.test() with the bonferroni correction
pairwise.t.test(famuss$ndrm.ch, famuss$actn3.r577x, p.adj = "bonf")




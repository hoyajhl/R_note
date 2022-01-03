## GAM visualization/ check for the assumptions

library(gamair)
data("mpg", package="gamair")
library(mgcv)

# Fit the model
mod_city4 <- gam(city.mpg ~ s(weight) + s(length) + s(price) + s(rpm) + s(width),
                 data = mpg, method = "REML")
# View the summary
summary(mod_city4)
## EDF > five represents non-linearlity

mcycle <- MASS::mcycle
library(mgcv)
# Fit the model
mod <- gam(accel ~ s(times), data = mcycle, method = "REML")

# Make the plot with residuals
plot(mod, residuals = TRUE)

# Change shape of residuals
plot(mod, residuals = TRUE, pch = 1, cex = 1)

library(gamair)
data("mpg", package="gamair")
library(mgcv)
mod <- gam(hw.mpg ~ s(weight) + s(rpm) + s(price) + comp.ratio, 
           data = mpg, method = "REML")

# Plot the price effect
plot(mod, select = 3)
# using the select term to view only the partial effect of price

# Plot all effects
plot(mod, pages = 1, all.terms = TRUE)
# showing all terms on a single page,
# including the linear comp.ratio term

# plotting only the partial effect of weight
# Make the confidence interval shaded and "skyblue" in color.
plot(mod, select = 1, shade = TRUE, shade.col = "skyblue")

# Make another plot adding the intercept value and uncertainty
plot(mod, select = 1, shade = TRUE, shade.col = "green", 
     shift = coef(mod)[1], seWithMean = TRUE)
## shifting the scale by the value of the intercept using the shift argument, 
## and including the uncertainty of the model intercept using the seWithMean argument

set.seed(0)
dat <- gamSim(1,n=200)
# Fit the model
mod <- gam(y ~ s(x0, k = 5) + s(x1, k = 5) + s(x2, k = 5) + s(x3, k = 5),
           data = dat, method = "REML")
# Run the check function using gam.check()
par(mfrow = c(2, 2))
gam.check(mod)
## Smooths that have significant effects in the diagnostic test 
## (p < 0.05, with asterisks) generally do not have enough basis functions.
## This indicates non-random patterns in residuals.
## Analysis: x2 does(p-value<0.05) not have enough basis functions.

set.seed(0)
dat <- mgcv::gamSim(1,n=600, scale=0.6, verbose=FALSE)

# Fit the model
mod <- gam(y ~ s(x0, k = 3) + s(x1, k = 3) + s(x2, k = 3) + s(x3, k = 3),
           data = dat, method = "REML")

# Check the diagnostics
gam.check(mod)
## (p < 0.05, with asterisks) generally do not have enough basis functions.
## This indicates non-random patterns in residuals.
## Analysis: x2 does(p-value<0.05) not have enough basis functions.
## by increasing a number of k, the problem could be fixed


# Refit to fix issues
mod2 <- gam(y ~ s(x0, k = 3) + s(x1, k = 3) + s(x2, k = 10) + s(x3, k = 3),
            data = dat, method = "REML")

# Check the new model
gam.check(mod2)
## Analysis: p-value> 0.05 means 
## Neither has significant patterns in their residuals 
## and both have enough basis functions.

# Fit the model
mod <- gam(hw.mpg ~ s(length) + s(width) + s(height) + s(weight),
           data = mpg, method = "REML")
## concurvity() function measures concurvity in model variables. 
## Like gam.check()
## Aim of this function: to examine the quality of our model
## Check overall concurvity
concurvity(mod, full = TRUE)
## it shows how much each smooth is predetermined by all the other smooths.
## always look at the worst case, and if the value is high (say, over 0.8),
## inspect your model more carefully.
## low value means least pre-determined by the other variables
concurvity(mod, full = FALSE)
## concurvity between model variables.
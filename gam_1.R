## GAM (Generalized Additive Models)
library(mgcv)
mcycle <- MASS::mcycle

# Examine the mcycle data frame
head(mcycle)
plot(mcycle)
# Fit a linear model
lm_mod <- lm(accel ~ times, data = mcycle)
# Visualize the model (Simple Linear approach) 
termplot(lm_mod, partial.resid = TRUE, se = TRUE)

# Fit a GAM
gam_mod <- gam(accel ~ s(times), data = mcycle)
# Plot the results
plot(gam_mod, residuals = TRUE, pch = 1)
# Extract the model coefficients
coef(gam_mod)
## Analysis: The smooth is made up of 9 basis functions, 
## each with their own coefficient.

# Fit a GAM with 3 basis functions
gam_mod_k3 <- gam(accel ~ s(times, k = 3), data = mcycle)

# Fit with 20 basis functions
gam_mod_k20 <- gam(accel ~ s(times, k = 20), data = mcycle)

# Visualize the GAMs
par(mfrow = c(1, 2))
plot(gam_mod_k3, residuals = TRUE, pch = 1)
plot(gam_mod_k20, residuals = TRUE, pch = 1)

# Extract the smoothing parameter
gam_mod <-gam(accel ~ s(times), data = mcycle, method = "REML")
gam_mod$sp # sp: smoothing parameter

# Fix the smoothing parameter at 0.1
gam_mod_s1 <-gam(accel ~ s(times), data = mcycle, sp = 0.1)

# Fix the smoothing parameter at 0.0001
gam_mod_s2 <- gam(accel ~ s(times), data = mcycle, sp = 0.0001)

# Plot both models
par(mfrow = c(2, 1))
plot(gam_mod_s1, residuals = TRUE, pch = 1)
plot(gam_mod_s2, residuals = TRUE, pch = 1)

# Fit the GAM
gam_mod_sk <- gam(accel ~ s(times, k = 50), data = mcycle, sp = 0.0001)
# Visualize the model
plot(gam_mod_sk, residuals = TRUE, pch = 1)
## Analysis: The number of basis functions and the smoothing parameters interact to 
## control the wiggliness of a smooth function. 
## Above example of setting the values of knots(k) and smoothing parameter
## show how changing both together affects model behavior

install.packages("gamair")
library(gamair)
data("mpg", package="gamair")
# Fit the model
mod_city <- gam(city.mpg ~ s(weight) + s(length) + s(price), 
                data = mpg, method = "REML")

# Plot the model
plot(mod_city, pages = 1)

# Fit the model with categorical values
# categorical values are inherently linear 
mod_city2 <- gam(city.mpg ~ s(weight) + s(length) + s(price) + fuel + drive + style,
                 data = mpg, method = "REML")

# Plot the model
plot(mod_city2, all.terms = TRUE, pages = 1)

# Fit the model by stratification of categorical value
mod_city3 <- gam(city.mpg ~ s(weight, by = drive) + s(length, by = drive) + s(price, by = drive) + drive,
                 data = mpg, method = "REML")
# Plot the model
plot(mod_city3, pages = 1)
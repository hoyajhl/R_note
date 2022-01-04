#load the data
library(oibiostat)
data("nhanes.samp.adult.500")
#fitting linear model
lm(nhanes.samp.adult.500$BMI ~ nhanes.samp.adult.500$Age)

#plot the data
plot(BMI ~ Age, data = nhanes.samp.adult.500,
     main = "BMI versus Age in the NHANES data (n = 500)",
     pch = 21, col = "cornflowerblue", bg = "slategray2",
     cex = 0.75) ## cex: reduce the size of the dots
#add least squares line
abline(lm(BMI ~ Age, data = nhanes.samp.adult.500),
       col = "red", lty = 2, lwd = 1)

#name the model object
model.BMIvsAge = lm(BMI ~ Age, data = nhanes.samp.adult.500)
#extract residuals with residuals()
residuals = residuals(model.BMIvsAge)
#extract predicted values with predict()
predicted = predict(model.BMIvsAge)

#alternatively... extract predicted values with $fitted.values
#residuals = model.BMIvsAge$residuals
#predicted = model.BMIvsAge$fitted.values

plot(residuals ~ predicted,
     main = "Residual Plot for BMI vs Age (n = 500)",
     xlab = "Predicted BMI", ylab = "Residual",
     pch = 21, col = "cornflowerblue", bg = "slategray2",
     cex = 0.75)
abline(h = 0, lty = 2, lwd = 2, col = "red")

# Normal probability plot of residuals
# Normal Q-Q plot 

qqnorm(residuals,
       pch = 21, col = "cornflowerblue", bg = "slategray2", cex = 0.75)
qqline(residuals,
       col = "red", lwd = 2)

# The qqnorm() function produces a normal quantile-quantile plot 
# of a set of values while qqline() adds a diagonal line 
# through the first and third quartiles.

## **Checking assumptions with residual plots
# 1. linearity 
# 2. Constant variability
# 3. Independent observations
# 4. normally distributed residuals

## Appearing constant variability: no apparent pattern in the residuals
## The variance of the error predicted value should be constant
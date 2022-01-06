#Intro. Multiple Regression
##Assumptions for multiple regression
##Using graph/Index designated

library(oibiostat)
library(openintro)
data("nhanes.samp.adult.500")
#BMI ~ Age + Gender in nhanes.samp.adult.500
model.BMIvsAgeGender = lm(BMI ~ Age + Gender, data = nhanes.samp.adult.500)
predict(model.BMIvsAgeGender, newdata = data.frame(Age = 60, Gender = "male"))
#confirm answer from solving 28.81 + 0.02(60) - 0.95(1)
coef(model.BMIvsAgeGender)[1] + coef(model.BMIvsAgeGender)[2]*60 + 
  coef(model.BMIvsAgeGender)[3]*1

### Plotting Points According to a Condition
data(prevend.samp)
data(COL)
#create statin.use logical
statin.use = (prevend.samp$Statin == 1)

#plot blue points
plot(prevend.samp$Age[statin.use == FALSE], prevend.samp$RFFT[statin.use == FALSE],
     pch = 20, bg = COL[1, 3], col = COL[1], cex = 1.3,
     xlab = "Age (yrs)", ylab = "RFFT Score",
     main = "RFFT Score versus Age (n = 500)")
#plot red points
points(prevend.samp$Age[statin.use == TRUE], prevend.samp$RFFT[statin.use == TRUE],
       pch = 20, bg = COL[4, 3], col = COL[4], cex = 1.3)
#draw vertical lines
abline(v = 40, lty = 2)
abline(v = 50, lty = 2)
abline(v = 60, lty = 2)
abline(v = 70, lty = 2)
abline(v = 80, lty = 2)

# Evaluating Model Fit

#print adjusted R-squared value
summary(model.BMIvsAgeGender)$adj.r.squared

### Plotting Points According to Several Conditions

#load data
library(oibiostat)
data("dds.discr")

# *subsetting data
dds.subset = dds.discr[dds.discr$ethnicity == "Hispanic" | 
                         dds.discr$ethnicity == "White not Hispanic", ]
# *drop unused factor levels
dds.subset$ethnicity = droplevels(dds.subset$ethnicity)
dds.subset$ethnicity
#load colors from openintro

#create hispanic and white.not.hisp logicals
hispanic = (dds.subset$ethnicity == "Hispanic")
white.not.hisp = (dds.subset$ethnicity == "White not Hispanic")
#create age logicals
younger = (dds.subset$age < 21)
older = (dds.subset$age >= 21)
par(mfrow = c(1, 2))
#plot blue points, white not hispanic
plot(expenditures[white.not.hisp & younger] ~ age[white.not.hisp & younger], 
     data = dds.subset,
     pch = 21, bg = COL[1, 4], col = COL[1], cex = 0.8,
     xlab = "Age (yrs)", ylab = "Expenditures",
     main = "Expenditures vs Age in DDS (0 - 21)")
#plot red points, hispanic
points(expenditures[hispanic & younger] ~ age[hispanic & younger], 
       data = dds.subset, pch = 21, bg = COL[4, 4], col = COL[4],
       cex = 0.8)
#plot blue points, white not hispanic
plot(expenditures[white.not.hisp & older] ~ age[white.not.hisp & older], 
     data = dds.subset,
     pch = 21, bg = COL[1, 4], col = COL[1], cex = 0.8,
     xlab = "Age (yrs)", ylab = "Expenditures",
     main = "Expenditures vs Age in DDS (21+)")
#plot red points, hispanic
points(expenditures[hispanic & older] ~ age[hispanic & older], 
       data = dds.subset, pch = 21, bg = COL[4, 4], col = COL[4],
       cex = 0.8)

#####Assumptions for multiple linear regression
# 1.Linearity
# 2.Constant variability
# 3.Independent observations
# 4.Approximate normality of residuals

#fit the model
model2 <- lm(expenditures ~ ethnicity + age, data = dds.subset)
coef(model2)
# 1. Evaluate linearity
plot(resid(model2) ~ dds.subset$age,
     main = "Residuals vs Age in DDS Data",
     xlab = "Age (years)", ylab = "Residual",
     pch = 21, col = "cornflowerblue", bg = "slategray2",
     cex = 0.60)
abline(h = 0, col = "red", lty = 2)

##Analysis: The residuals clearly show a pattern, 
## rather than random scatter about the y = 0 line.
## There is remaining non-linearity with respect to age 

# 2. Evaluate constant variance 
par(mfrow = c(1, 1))
plot(resid(model2) ~ fitted(model2),
     main = "Resid. vs Predicted Exp. in DDS Data",
     xlab = "Predicted Expenditures", ylab = "Residual",
     pch = 21, col = "cornflowerblue", bg = "slategray2",
     cex = 0.60)
abline(h = 0, col = "red", lty = 2)
##Analysis: The variance of the residuals is clearly not constant

# 3. Independent observations
## reasonable to assume that the values in one set of observation
## do not influence the values in another set.

# 4. Normality of residuals
qqnorm(resid(model2),
       pch = 21, col = "cornflowerblue", bg = "slategray2", cex = 0.75,
       main = "Q-Q Plot of Residuals")
qqline(resid(model2),
       col = "red", lty = 2)
##Analysis: The residuals show marked departures from normality,
## particularly in the upper tail.
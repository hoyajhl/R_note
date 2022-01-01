#Cubic and Smoothing Splines

###Cubic Splines
#loading the Splines Packages
install.packages("splines")
install.packages("ISLR")
library(splines)
#ISLR contains the Dataset
library(ISLR)
attach(Wage) #attaching Wage dataset
?Wage #for more details on the dataset
View(Wage)# Data load 

agelims<-range(age)
#Generating Test Data
agelims[1] #18
agelims[2] #80
age.grid<-seq(from=agelims[1], to = agelims[2])
age.grid

#3 cutpoints at ages 25 ,50 ,60
fit<-lm(wage ~ bs(age,knots = c(25,40,60)),data=Wage)
summary(fit)

#Plotting the Regression Line to the scatterplot   
par(mfrow = c(1, 1))
plot(age,wage,col="grey",xlab="Age",ylab="Wages")
points(age.grid,predict(fit,newdata = list(age=age.grid)),col="darkgreen",lwd=2,type="l")
#adding cutpoints
abline(v=c(25,40,60),lty=2,col="darkgreen")
## Dashed Lines represent the Cutpoints or the Knots.
## It shows the smoothing and local effect of Cubic Splines.


###Smoothing splines
## it does not require the selection of the number of Knots, 
## but require selection of only a Roughness Penalty 
## which accounts for the wiggliness(fluctuations) 
## controls the roughness of the function and variance of the Model 
## they have a Knot for every unique value of (xi)
## Aim of smoothing splines: minimize the Error function 
## which is modified by adding a Roughness Penalty 
## which penalizes it for Roughness and high variance

#fitting smoothing splines using smooth.spline(X,Y,df=...)
fit1<-smooth.spline(age,wage,df=16) #smooth.spline(X,Y,df=...) 
#df stands for degrees of freedom
#Plotting both cubic and Smoothing Splines 
plot(age,wage,col="grey",xlab="Age",ylab="Wages")
points(age.grid,predict(fit,newdata = list(age=age.grid)),col="darkgreen",lwd=2,type="l")

#adding cutpoints
abline(v=c(25,40,60),lty=2,col="darkgreen")
lines(fit1,col="red",lwd=2)
legend("topright",c("Smoothing Spline with 16 df","Cubic Spline"),col=c("red","darkgreen"),lwd=1)

## The best way to select the value of λ and df is Cross Validation
## Implementing cross validation in R using smooth.spline()

fit2<-smooth.spline(age,wage,cv = TRUE) ##cv=True options for cross validation
fit2 ## the value of df and lambda are provided in console

#It selects lambda=0.0279 and df = 6.794596
## can take various values for how rough the #function is
plot(age,wage,col="grey")
#Plotting Regression Line
lines(fit2,lwd=2,col="blue")
legend("topright",("Smoothing Splines (6.78 df) selected by CV"),col="blue",lwd=2)

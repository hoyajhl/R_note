## 기본 데이터 프레임 결측 확인 
df = data.frame(aa = 1:3,
                bb = c(NA, 1, NA),
                cc = c(NA, 2, 3))

sum(is.na(df$bb))
apply(X = df, MARGIN = 2, FUN = function(x){sum(!is.na(x))})
apply(X = df, MARGIN = 2, FUN = function(x){sum(is.na(x))})


## apply 이용해서 Margin=2: column 기준
data=airquality
head(data)

apply(X = data, MARGIN = 2, FUN = function(x){sum(is.na(x))})
colnames(data)
mean(data$Solar.R) ## NA값이 존재해서 NA로 반환
mean(data$Solar.R, na.rm = TRUE) # na.rm=TRUE, na 제외 -> 185.9315

## for loop 활용 
data=airquality
head(data)
for(i in colnames(data)){
  if(sum(is.na(data[[i]]))>0){
    print(sum(is.na(data[[i]])))}
  else{
    print("no missing value")
  }
}


## 결측 처리 
data[is.na(data$Solar.R), "Solar.R"] = mean(data$Solar.R, na.rm = TRUE) # mean 값으로 NA imputation


## imputeTS package 이용 
#na_interpolation
install.packages("imputeTS")
library("imputeTS")


apply(X = data, MARGIN = 2, FUN = function(x){sum(is.na(x))}) # 모든 column 결측 확인

data$Solar.R=na_interpolation(data$Solar.R,option = "linear") # 특정 column만 적용

data<- apply(X = data, MARGIN = 2, FUN = function(x){
  x=na_interpolation(x,option = "linear")})     # apply 함수 이용: 모든 column 적용
head(data) #적용 확인

## Imputation 다른 옵션들
x= na_interpolation(x,option = "linear")
x= na_interpolation(x,option = "spline")
x= na_interpolation(x,option = "stine")
x= na_kalman(x) # Imputation by Kalman Smoothing and State Space Models 
x = na_locf(x) # Imputation by Last Observation Carried Forward
x = na_ma(x) # Imputation by Weighted Moving Average 
x = na_mean(x) # Imputation by Mean Value
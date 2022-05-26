###Imputation R코드 예시-mice 함수 사용
### https://cran.r-project.org/web/packages/miceRanger/vignettes/miceAlgorithm.html
library(mice) #결측 채워넣기 
library(missForest) #결측 생성
install.packages("VIM")
library(VIM) #visualization
str(iris)
iris.NA<-prodNA(iris, noNA = 0.1) #결측생성(0.1 비율로 랜덤 생성,missforest package)
summary(iris.NA)
sapply(iris.NA, function(x) sum(is.na(x)))

aggr(iris.NA, cex.axis=.7, gap=3, ylab=c("Missing data","Pattern"))
## 결측치 분포->VIM package로 확인

iris.imp<-mice(iris.NA,5) ##mice package 이용하여 결측 없는 5개의데이터 생성 
summary(iris.imp)
iris.comp<-complete(iris.imp,3) ##5개의 데이터 중 3번째 데이터 채택 
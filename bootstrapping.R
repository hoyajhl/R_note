#표본(original sample) 만들기
set.seed(20) 
x <- rnorm(100) ##100개 난수 생성

set.seed(20) 
num_bootstrap = 1000 #1000개의 부스트랩 갯수
size_bootstrap= 10 #한번 부스트랩 시행 시, 각 추출 갯수  
bootstrap_samples <- lapply(1:num_bootstrap, FUN=function(i) sample(x,size=size_bootstrap,replace = T))



##r_square 함수 생성 
r_square<- function(formula,data,indices){
  d<-data[indices,]
  fit<-lm(formula,data=d)
  return(summary(fit)$r.square)
}

bootstrapping<- boot(data=hoya_data,statistics=r_square,R=1000,formula=cognitive~age+sex+hdl+ldl)
bootstrapping
summary(bootstrapping)
plot(bootstrapping) ## r square 분포 확인 (hist,qq norm) 
boot.ci(bootstrapping,type=c('norm','basic’,perc','bca')) ## 신뢰구간

## https://www.rdocumentation.org/packages/boot/versions/1.3-25/topics/boot
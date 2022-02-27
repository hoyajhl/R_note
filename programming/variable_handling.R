install.packages("stringr")
library(stringr)
xx<-c("네이버","네이버에서","네이버를","inflearn","naver","naver에서","naver는","중앙일보","동아일보")
str_detect(xx,"네이버") ## 문자열 찾기 
yy<-c("네이버","naver","저작권","뉴스","일보","에서")
###들어간 글자 찾기
xx[str_detect(xx,"네이버")] ##xx[ture,false,ture]->값 반환
xx[str_detect(xx,"naver")]
## 정확히 일치 단어 찾기
xx[xx %in% "네이버"]
xx[xx %in% "naver"]
xx[xx %in% yy]

##네이버 또는 naver들어간 글자 찾기
xx[!(str_detect(xx,"네이버") | str_detect(xx,"naver"))]

## 
xx[!(str_detect(xx,"네이버|naver|저작권|뉴스|일보"))]

##
zz<-apply(sapply(xx,str_detect,yy),2,sum)
sapply(xx,str_detect,yy)
zz
xx[zz == 0]


x2<-c(NA,NA,3)
is.na(x2) ##TRUE TRUE FALSE

x2[!is.na(x2)] ## NA 빼고 출력
x2[is.na(x2)] <- 0 ## NA에 0 삽입
x2


for(i in 1:10){
  cat("\n",i)
  Sys.sleep(runif(1,min=0.1,max=1)) ##난수를 사용해서 살짝 쉬게 끔 유도
}

##복원 추출
sample(1:10,100,replace = T)
table(sample(1:10,100,replace = T))

x<-c("강아지","고양이","강아지2","고양이2","강아지3","고양이3")
x[sample(1:length(x),2)] ## x에서 2개뽑고
table(sample(x,10000,replace = T))## 1000번 복원추출 

pr<-rep(1/length(x),length(x)) ## 1/6지정
str_detect(x,"강아지")
pr[str_detect(x,"강아지")]
pr[str_detect(x,"강아지")]<-pr[str_detect(x,"강아지")]*2 ## 학률 값 두배 지정
pr2<-pr/sum(pr) ##  scaling
pr2
sum(pr2)

table(sample(x,10000,replace = T,prob = pr2))

xx<-function(x){
  t2<-x+1
  t3<-t2+1
  t4<-t2+2
  c(t2,t3,t4)
}

xx(1)
t2
t3
t4

xx<-function(x){
  t2<<-x+1
  t3<<-t2+1
  t4<<-t2+2
  c(t2,t3,t4)
}

xx(1)
t2
t3
t4


list1<-list() ##빈 리스트 저장
for(i in 1:10){
  a<-c(1,2,3)
  list1[[i]]<-a
}
length(list1) ## list length
list1




m = data.frame(matrix(1:12,ncol=3))
m
dim(m) ## dataframe dim
nrow(m) 
ncol(m) 

length(m[,1]) ## vector length
length(m[1,]) ## vector length

addr<-c("서울시 서대문구 신촌동","경기도 안산시 단원구",
        "경기도 평택시","전라남도 연수시 선원동 124")

str_split(addr," ")

x2<-str_split(addr," ")
## for문을 활용한 방법
length(x2)
add1<-c()
for( i in 1:length(x2)){
  add1[i]<- x2[[i]][1]    ## i번째 큰방의 첫번째 작은방을 가져옴
}
add1

## for문의 비효율성을 막기위해 
##  sapply는 list의 큰방에 접근하여 함수를 적용시켜주는 함수
sapply(x2,length)
sapply(x2,paste0,collapse=" ")



addr<-c("서울시 서대문구 신촌동","경기도 안산시 단원구",
        "경기도 평택시","전라남도 연수시 선원동 124")
search<-function(x){
  x[1]
}

x2<-str_split(addr," ")
sapply(x2,search)


search2<-function(x,i){
  x[i]
}
x2<-str_split(addr," ")
sapply(x2,search2,1)
sapply(x2,search2,2)
sapply(x2,search2,3)

final<-NULL
for(i in 1:10){
  
  a<-c(1,2,3)
  final<-rbind(final,a)
}

final

list1<-list()
for(i in 1:10){
  
  a<-c(1,2,3)
  list1[[i]]<-a
  
}

addr<-c("서울시 서대문구 신촌동","경기도 안산시 단원구",
        "경기도 평택시","전라남도 연수시 선원동 124")
search<-function(x){
  x[1]
}

x2<-str_split(addr," ") ##string split
x2
sapply(x2,search) ##function 적용

search2<-function(x,i){
  x[i]
}
x2<-str_split(addr," ")
sapply(x2,search2,1)
sapply(x2,search2,2)
sapply(x2,search2,3)

# sapply과 lapply의 비교 
# sapply라는 결과값을 vector로 반환하고, lapply는 아래화면과 같이 결과값을 리스트 자체를  반환 
sapply(x2,search2,1)
lapply(x2,search2,1)





do.call("rbind",list1)

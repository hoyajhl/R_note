# 기본 크롤링 개념 및 방법

url<-"https://www.bobaedream.co.kr/list?code=best"
a<-readLines(url,encoding="UTF-8")

library(stringr)
b<-a[str_detect(a,"<a class=\"bsubject\"")] ## 규칙 찾기
length(b)

bb<-str_extract(b,("(?<=href=).*(?=date)")) 
##정규 표현식 이용해서 b에서 aaa와 bbb 사이에 있는 모든 것
## "(?<=aaa).*(?=bbb)"
str_sub(bb,2) ## 앞 2개 제외
url_list<-paste0("https://www.bobaedream.co.kr/",str_sub(bb,2),"date")
url_list

## 개별적인 url에 접근
title_vec<-c()
con_vec<-c()
j<-1
for(j in 1:length(url_list)){
  b<-readLines(url_list[j],encoding="UTF-8")
  title_vec[j]<-b[str_detect(b,"<title>")]
  con_vec[j]<-b[which(str_detect(b,"<div class=\"bodyCont\""))+6]
  ## which(str_detect(b,"<div class=\"bodyCont\"")): 해당 line만 나옴
  cat("\n",j)
}


title_vec<-str_sub(str_extract(title_vec,("(?<=<title>).*(?=</title>)")),end=-12) ##str_sub이용해서 마지막 12개 제외
con_vec
con_vec<-gsub("<.*?>","",con_vec) # gsub과 정규식 이용해서 지우기
con_vec<-gsub("&nbsp","",con_vec) # 문자열 지우기  
head(con_vec)

data<-cbind(title_vec,con_vec) ##cbind (column bind)
head(data)
colnames(data)<-c("title","contents") #새로운 col names 설정 

setwd("경로 설정")
write.csv(data,"crawling_name.csv",row.names=F)
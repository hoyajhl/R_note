
url<-"URL주소"
b<-readLines(url,encoding="UTF-8")

library(stringr)
b2<-b[str_detect(b,"<td class=\"subject\">")] ## 규칙 찾기
length(b2)

head(b2)
bb<-str_extract(b2,("(?<=target).*(?=</a>)"))
head(bb)
title<-str_sub(bb,9)
head(title)

head(b2) ## 게시물 해당 링크 가져오기 
b3<-str_split(b2,"a href") ## "a href"기준으로 split해서 하나에서 두 개의 리스트를 생성

b4<-sapply(b3, function(x){x[2]}) ## 두개의 리스트중 두번째만 가져옴
b5<-sapply(str_split(b4,"target"),function(x){x[1]}) ## 두개의 리스트중 앞부분 첫번째만 가져오기
head(b5)
b6<-str_sub(b5,3,end=-5)

## 정규표현식 사용햇서 해당 링크 가져오기
head(b2)
b2_a<-str_sub(str_extract(b2,("(?<=a href).*(?=target)")),3,end=-3)

base_url<-paste0("main url 주소",b2_a)


## for 문 이용해서 page loop 가져오기

data<-NULL
for(i in 1:3){
  url<-paste0("url주소&page=",i) #여러 해당 페이지 가져오기
  b<-readLines(url,encoding="UTF-8")
  library(stringr)
  b2<-b[str_detect(b,"<td class=\"subject\">")] ## 규칙 찾기
  bb<-str_extract(b2,("(?<=target).*(?=</a>)"))
  title<-str_sub(bb,9) 
  b2_a<-str_sub(str_extract(b2,("(?<=a href).*(?=target)")),3,end=-3)
  base_url<-paste0("해당 url",b2_a)
  data<-rbind(data,cbind(title,base_url))
  cat("\n",i)
  
}
head(data)
con_url<-data[,2] ## base_url 부분만 가져오기

## 내용 가져오기 
j<-1
final_con<-c()
for(j in 1:length(con_url)){
  b<-readLines(con_url[j],encoding = "UTF-8")
  con_index<-which(str_detect(b,"viewContent")) ## 규칙 찾아서 index 줄 값으로 반환
  con<-paste(b[con_index[1]:con_index[2]],collapse="") ## 간격없이 합치기
  final_con[j]<-con
  cat("\n",j)
  Sys.sleep(1)## 쉬는 거 알려주는 코드
}
final_con
final_con<-gsub("<.*?>","",final_con)
final_con<-gsub("\t","",final_con)
final_con
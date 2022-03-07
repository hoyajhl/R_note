install.packages("RJSONIO")

x<-"잠실 카페"
keyword<-iconv(x,from="CP949",to="UTF-8")
keyword2<-URLencode(keyword)

url<-paste0("https://m.map.naver.com/search2/searchMore.nhn?query=",
            keyword2,
            "&sm=clk&style=v5&page=1&displayCount=75&type=SITE_1")
b
b<-readLines(url,encoding="UTF-8")
head(b)
length(b)
b<-paste(b,collapse = " ")
library(RJSONIO)
b2<-fromJSON(b)
b2
## json 접근
b2$result$site$list[[1]]$name
b2$result$site$list[[1]]$id
b2$result$site$list[[1]]$x
b2$result$site$list[[1]]$y
b2$result$site$list[[1]]$address

name<-sapply(b2$result$site$list,function(x){x$name}) ##list 1,2,3..번째 방 접근 
id<-sapply(b2$result$site$list,function(x){x$id})
x<-sapply(b2$result$site$list,function(x){x$x})
y<-sapply(b2$result$site$list,function(x){x$y})
addr<-sapply(b2$result$site$list,function(x){x$address})



## FOR LOOP 활용해서 카페 접근
keyword_list<-c("교대 카페","이태원 카페","서초 카페","신촌 카페")
keyword_list
length(keyword_list)
for(i in 1:length(keyword_list)){
  x<-keyword_list[i]
  keyword2<-URLencode(x)
  url<-paste0("https://m.map.naver.com/search2/searchMore.nhn?query=",
              keyword2,
              "&sm=clk&style=v5&page=1&displayCount=75&type=SITE_1")
  b<-readLines(url,encoding="UTF-8")
  head(b)
  length(b)
  b<-paste(b,collapse = " ")
  library(RJSONIO)
  b2<-fromJSON(b)
  
  name<-sapply(b2$result$site$list,function(x){x$name})
  id<-sapply(b2$result$site$list,function(x){x$id})
  x<-sapply(b2$result$site$list,function(x){x$x})
  y<-sapply(b2$result$site$list,function(x){x$y})
  addr<-sapply(b2$result$site$list,function(x){x$address})
  
  data<-cbind(name,id,x,y,addr) ## data cbind
  cat("\n",keyword,"완료")
  write.csv(data,paste0(keyword,".csv"),row.names = F)
}
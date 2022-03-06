keyword<-"교대역"
Encoding(keyword) #"UTF-8"
URLencode(keyword) ## URL encode 형식으로 반환: "%EA%B5%90%EB%8C%80%EC%97%AD"

url<-paste0("https://map.naver.com/v5/api/instantSearch?lang=ko&caller=pcweb&types=place,address,bus&coords=37.4939021,127.0143954&query=%",keyword)
a<-readLines(url,encoding="UTF-8")
a ## json 형태
install.packages("RJSONIO")
library(RJSONIO)
a2<-fromJSON(a) ## json -> list형태로 변환 
head(a2)
a2$place[[1]]$title
a2$place[[1]]$x #"127.0143954"
a2$place[[1]]$y #"37.4939021"


keyword<-"신촌역"
Encoding(keyword) #"UTF-8"
## 함수화 using function, 네이버 map url 구조가 바뀌어서 적용 불가..
location_search<-function(x){
encoded_keyword<-URLencode(x) ## URL encode 형식으로 반환: "%EA%B5%90%EB%8C%80%EC%97%AD"
url<-paste0("https://map.naver.com/v5/api/instantSearch?lang=ko&caller=pcweb&types=place,address,bus&coords=37.4939021,127.0143954&query=%",encoded_keyword)
a<-readLines(url,encoding="UTF-8")
a ## json 형태
library(RJSONIO)
a2<-fromJSON(a)
head(a2)
a2$place[[1]]$title
a2$place[[1]]$x
a2$place[[1]]$y
} 
location_search("신촌역")
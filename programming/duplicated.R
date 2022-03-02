data = read.csv(file = "C:/Users/Jaeho/Downloads/duplicated.csv",encoding = "UTF-8")

# NAME이 같은 변수들 중복 제거
data$NAME
which(duplicated(data$NAME)) ## duplicated된 row index 반환
data[-which(duplicated(data$NAME)),]

#NAME, ID 두 개의 값이 같은 중복 데이터 제거 
new_data= data[!duplicated(data[,c('NAME','ID')]),] # 변수명으로 제거
## data[!duplicated(data[,c(2,3)]),] # 인덱스로 제거
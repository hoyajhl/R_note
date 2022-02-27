##설문 응답 -99가 무응답인 경우 처리
data$question[data$question!=-99]<-abs(data$question)
data$question[data$question=-99]<-NA
summary(data[[2]]) ##해당 column이 2번째 case

mean_data=ddply(data,"id",summarize,mean.cost=mean(cost,na.rm=TRUE))
## ddply 함수 이용해 id기준으로 각 cost 변수에대한 mean 값 return, na의 경우 remove


##for문 이용해서 결측 값에 mean cost값 넣어주기
for (i in 1:dim(data)[1]) {
  data[[2]][data[[1]]==i&is.na(data[[2]])]    ## data의 2번째 column에 해당되는 값 중 결측이고 
                                                ## i번째 해당하는 1번째 column인 id값 조건 선택
  <-mean_data[mean_data[[1]]==i,2]## id에 해당되는 i에서 2번째 column의 mean cost값 assign
}
list_ex<-list()
for(i in 1:10){
  
  a<-c(1,2,3)
  list_ex[[i]]<-a
  
}
# for문이 끝난 다음에 do.call("rbind", list객체)를 통해 list안에 있는 큰 방들에 대해 rbind/cbind
list_ex

## 속도 향상을 위해
do.call("rbind",list_ex) ## list안에 있는 큰 방들에대해 rbind 시행 
do.call("cbind",list_ex) ## list안에 있는 큰 방들에대해 cbind 시행 
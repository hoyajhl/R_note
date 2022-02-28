names(darfur) ## 변수 이름 확인
varname<-names(darfur) ## vector로 지정
var_new=varname[-1]## 1번째 variable 제외
varname[2:14] ## 위랑 똑같음 (2번째~14개 지정)

new_data<-darfur[,c(var_new)] ## var_new 변수로 구성된 데이터셋
varname_new<-paste("x",1:13,sep="") #x1~x13 var 이름 지정
names(new_data)[1:13]<-varname_new # 새로운 var로 assign
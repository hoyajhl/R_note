##기본 회귀분석
ols<-lm(dependentvariable~group+age+sex+intelligence,data=hoyadata)
summary(ols)

library(RItools)
xBalance(group~age+sex+intelligence,data=hoyadata,report=c("chisquare.test"))
##chisquare test로 group에 따른 차이가 존재하는 지 확인 

propensityscore<-glm(group~age+sex+intelligence,data=hoyadata,family=bionomial)
propensityscore$pscore<-predict(propensityscore,type="response")
0.25*sd(propensityscore$pscore) #caliper 값, optimal한 caliper 찾기 

library(MatchIt)
match<-matchit(group~age+sex+intelligence,data=hoyadata,
               method="nearest",discard="both",distance="logit",caliper=0.25*sd(propensityscore$pscore))
match_data<-match.data(match)
summary(match)

xBalance(group~age+sex+intelligence,data=match_data,report=c("chisquare.test"))
##chisquare test로 match 된 이후 group에 따른 차이가 존재하는 지 확인

plot(match_data,type="QQ")
plot(match_data,type="hist")

##Matching 이후 회귀분석 결과과
ols_match<-lm(dependentvariable~group+age+sex+intelligence,data=match_data)
summary(ols_match) ## Matching 이후 covariate 변수들의 bias를 줄어주는 효과 
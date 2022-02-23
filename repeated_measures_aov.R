demo1  <- read.csv("https://stats.idre.ucla.edu/stat/data/demo1.csv")
## factor 형식으로 바꾸기
demo1 <- within(demo1, {
  group <- factor(group)
  time <- factor(time)
  id <- factor(id)
})
par(cex = .6)
with(demo1, interaction.plot(time, group, pulse,
                             ylim = c(5, 20), lty= c(1, 12), lwd = 3,
                             ylab = "mean of pulse", xlab = "time", trace.label = "group"))
## 그룹에 따른 평행한 정도를 고려하면 시간의 흐름에 의한 그룹 간의 차이가 유의하지 않음 

demo1.aov <- aov(pulse ~ group * time + Error(id), data = demo1)
summary(demo1.aov)
## 결론: the two groups differ in depression but neither group changes over time


demo2 <- read.csv("https://stats.idre.ucla.edu/stat/data/demo2.csv")
## Convert variables to factor
demo2 <- within(demo2, {
  group <- factor(group)
  time <- factor(time)
  id <- factor(id)
})
par(cex = .6)
with(demo2, interaction.plot(time, group, pulse,
                             ylim = c(10, 40), lty = c(1, 12), lwd = 3,
                             ylab = "mean of pulse", xlab = "time", trace.label = "group"))
## the groups have lines that increase over time. Again, the lines are parallel 
## consistent with the finding that the interaction is not significant.

demo2.aov <- aov(pulse ~ group * time + Error(id), data = demo2)
summary(demo2.aov)

## 결론: Between groups test에서 group간의 차이가 없다고 나옴 (p-value: 0.396)
## 그래프에서 평행한 것으로 보아 예상 가능 

## within subject test에서 time effect가 유의하게 나옴
## 개체 내 그룹에서 시간의 효과가 있어 시간의 흐름에 따라 다르게 나옴 (p-value<0.05)
## 개체 내에서 기울기가 일정하게 평행한 것으로 보아 interaction은 없고, group:time 역시 유의한 결과 나오지 않음

demo3 <- read.csv("https://stats.idre.ucla.edu/stat/data/demo3.csv")
## Convert variables to factor
demo3 <- within(demo3, {
  group <- factor(group)
  time <- factor(time)
  id <- factor(id)
})
par(cex = .6)
with(demo3, interaction.plot(time, group, pulse,
                             ylim = c(10, 60), lty = c(1, 12), lwd = 3,
                             ylab = "mean of pulse", xlab = "time", trace.label = "group"))

demo3.aov <- aov(pulse ~ group * time + Error(id), data = demo3)
summary(demo3.aov)

## 결론: Between groups test에서 group간의 차이가 있다고 나옴 (p-value<0.05)
## 그래프에서 그룹별로 다른 형태를 보아 예상 가능

## within subject test에서 time effect가 유의하게 나옴
## 개체 내 그룹에서 시간의 효과가 있어 시간의 흐름에 따라 다르게 나옴 (p-value<0.05)
## group:time Interaction term이 유의한 결과 나왔는데
## Interaction이 존재한다는 의미: 시간마다 개체 내에서 다른 변화가 이뤄짐
## 한 개체내에서 그래프의 기울기가 일정하게 평행한 형태가 아님 
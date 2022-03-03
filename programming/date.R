install.packages('lubridate')
library('lubridate')
as.Date('2022-03-03')
ymd('20220303') #"2022-03-03"

df <- data.frame(Date=c('29/12/1995','29/12/1994','12/11/2005','3/4/1992'),
                 V2=c( 4, 6, 8, 10))
head(df)
df$Date_M=format(as.Date(df$Date, format="%d/%m/%Y"),"%Y") # 특정 column만 적용해서 생성
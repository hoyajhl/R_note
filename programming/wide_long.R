## dplyr 이용 예시 
## wide, long data 
## dplyr의 gather(), spread()
## reshape2 : melt(), dcast() 

olddata_wide <- read.table(header=TRUE, text='
 subject sex control cond1 cond2
       1   M     7.9  12.3  10.7
       2   F     6.3  10.6  11.1
       3   F     9.5  13.1  13.8
       4   M    11.5  13.4  12.9
')
olddata_wide$subject <- factor(olddata_wide$subject) # factor로 변환

olddata_long <- read.table(header=TRUE, text='
 subject sex condition measurement
       1   M   control         7.9
       1   M     cond1        12.3
       1   M     cond2        10.7
       2   F   control         6.3
       2   F     cond1        10.6
       2   F     cond2        11.1
       3   F   control         9.5
       3   F     cond1        13.1
       3   F     cond2        13.8
       4   M   control        11.5
       4   M     cond1        13.4
       4   M     cond2        12.9
')

olddata_long$subject <- factor(olddata_long$subject)

library(tidyr)
data_long <- gather(olddata_wide, key=condition, value=measurement, control:cond2, factor_key=TRUE)
#gather(olddata_wide, condition, measurement, control, cond1, cond2)
#gather: wide -> long
data_long

# Rename factor names from "cond1" and "cond2" to "first" and "second"
levels(data_long$condition)[levels(data_long$condition)=="cond1"] <- "first"
levels(data_long$condition)[levels(data_long$condition)=="cond2"] <- "second"

# Sort by subject first, then by condition
data_long <- data_long[order(data_long$subject, data_long$condition), ]
data_long

#spread: long -> wide
olddata_long
data_wide <- spread(olddata_long, key=condition, value=measurement)
data_wide

# 변수명 바꾸기
names(data_wide)[names(data_wide)=="cond1"] <- "first"
names(data_wide)[names(data_wide)=="cond2"] <- "second"

# columns 재정렬
data_wide <- data_wide[, c(1,2,5,3,4)]
data_wide
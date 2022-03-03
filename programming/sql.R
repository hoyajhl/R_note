## SQL in R
install.packages("sqldf")
install.packages("googleVis")    # Fruits data set

library(sqldf)
library(googleVis)

sqldf('select * FROM Fruits')
sqldf("select * from Fruits where Year = '2008' ")
sqldf('select SUM(Sales) from Fruits')
sqldf('select Fruit, SUM(Sales) as sum_sales
      FROM Fruits 
      GROUP BY Fruit')

## subquery
sqldf('select * FROM Fruits 
      WHERE Sales > 
      (SELECT Sales FROM Fruits WHERE profit > 10)')
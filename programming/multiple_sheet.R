## 모든 excel sheet 읽어내기 using function 
install.packages("openxlsx")
library(openxlsx)

read_all_sheet <- function(file){ 
  sheet_all = getSheetNames(file) ##getSheetNames 함수 활용
  all_f = list() #빈 리스트 생성
  for (i in sheet_name){
    all_f[[i]] = read_excel(file,sheet = i) # all_f 전체 리스트에 엑셀 시트 하나씩 담기 
   }
  return(all_f) }

all_f= read_all_sheet(file = "/Users/jaehohoyalee/Downloads/excel.xlsx")
all


library("fs")  # File manipulations
library(tidyverse)  # Data manipulation
# Construct a path to a file with `path()`
path("foo", "bar", letters[1:3], ext = "txt")
getwd()
# list files in the current directory
dir_ls()
# create a new directory
tmp <- dir_create(file_temp())
file_temp()
tmp
# create new files in that directory
file_create(path(tmp, "my-file.txt"))
dir_ls(tmp)
# remove files from the directory
file_delete(path(tmp, "my-file.txt"))
dir_ls(tmp)
# remove the directory
dir_delete(tmp)

##Filter files by type, permission and size
##using pipe-line %>% 
dir_info(path = ".", recursive = FALSE) %>%
  filter(type == "file", permissions == "u+r", size > "10KB") %>%
  arrange(desc(size)) %>%
  select(path, permissions, size, modification_time)

# Create separate files for each species
iris %>%
  split(.$Species) %>%
  map(select, -Species) %>%
  iwalk(~ write_tsv(.x, paste0(.y, ".tsv")))
iris
# Show the files
iris_files <- dir_ls(glob = "*.tsv")
iris_files

## **Loading all data files at once 
List_files<-list.files(getwd())
List_files
List_Length=length(List_files)
getwd() ## "C:/Kaggle/heart"
for(k in 1:List_Length){
  assign(List_files[k],read.csv(paste0( "C:/Kaggle/heart/",List_files[k])))}

## assign function (data save file name,working directory)
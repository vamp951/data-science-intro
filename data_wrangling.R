#path variables:
rootdir <- file.path("~", "r projects")
datadir <- file.path(rootdir, "data")
functionsdir <- file.path(rootdir, "code")

#load packages
if (!require(pacman)) {
  install.packages("pacman")
}
library(pacman)

p_load(tidyverse, magrittr, stringi, rattle,
       tidyquant, data.table)

#ingest data
dt <- read_csv(file.path(datadir, "weatherAUS.csv"))

#look at variable names, then normalize
dt %>% 
  names() %T>% 
  print() %>% 
  normVarNames() %T>%
  print() -> 
names(dt)

#quick look at data
glimpse(dt)
dt %>% names() -> vars


#remove % symbols for numeric vars
dt %>% 
  select(contains("_%")) %>% 
  names() %T>%
  print() ->
  percent_vars

dt[percent_vars] %<>% 
  apply(2, function(x) gsub("%", "", x)) %>% 
  as.numeric()

dt[percent_vars] %>% sapply(class)
glimpse(dt)

ratings <- c("value_score", "growth_score", 
             "momentum_score", "vgm_score")
dt[ratings] %<>%
  lapply(factor) %T>%
  {sapply(., class) %>% print()}





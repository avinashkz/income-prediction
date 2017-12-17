#! /usr/bin/env Rscript 
# data_summary.R
# Avinash Prabhakaran, Nov 2016
#
# This script reads the training data  
# and creates a summary csv file.
#
# Usage: Rscript data_summary.R --read=read_path --write=write_path


#Read the folder location where the data is stored in and the script will read in the train.csv from that folder.
#Read the location where you want to save the summary file and it will go and save in that location data_summary.csv
library(optparse)

option_list <- list(
  make_option("--read", type = "character", default = "doc"),
  make_option("--write", type = "character", default = "doc"))

opt <- parse_args(OptionParser(option_list = option_list))

read_path <- opt$read
write_path <- opt$write

library(tidyr)
library(dplyr)
library(readr)

main <- function() {

load_train <- paste(write_path, "/train.csv", sep = "")

train <-  read_csv(file = load_train)  
#train <- read_csv(file = "doc/train.csv")
#print(head(train))

header <- train[1] %>% summary %>% as_data_frame() %>%
  select(n) %>% mutate_if(is.factor, as.character) %>%
  separate(col = n, into = c("Features", "values"), sep = ":") %>%
  select(Features)

row.names(header) <- NULL

for (i in 1:length(train)){
  
  val <- variable_type(train[,i])
  if (val == "continous") {
    
  d1 <- train[i] %>% summary %>% as_data_frame()
  y <- d1 %>% select(n) %>% mutate_if(is.factor, as.character) %>%
    separate(col = n, into = c("Features", "values"), sep = ":")
  
  row.names(y) <- NULL
  
  colnames(y) <- c("Features", colnames(train[i]))
  
  header <- left_join(header, y) 
  }
}

save_train <- paste(write_path, "/data_summary.csv", sep = "")

#Save the summarised data in a csv file
write_csv(x = header, path = save_train)
}

variable_type <- function(x){
  vtype <- typeof(x[[1]][1])
  col_name <- colnames(x)
  exclude_list = c()
  if (vtype == "character") return("categorical")
  else return("continous")
}



main()
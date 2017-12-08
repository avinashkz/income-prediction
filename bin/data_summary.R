#! /usr/bin/env Rscript 
# data_summary.R
# Avinash Prabhakaran, Nov 2016
#
# This script reads the training data  
# and creates a summary csv file.
#
# Usage: Rscript data_summary.R

args = commandArgs(trailingOnly = TRUE)
#Read the folder location where the data is stored in and the script will read in the train.csv from that folder.
read_path <- args[1]
#Read the location where you want to save the summary file and it will go and save in that location data_summary.csv
write_path <- args[2]

library(tidyverse)

main <- function() {

load_train <- paste(write_path, "/train.csv", sep = "")

train <-  read_csv(file = load_train)  

head1 <- test[1] %>% summary %>% as_data_frame() %>%
  select(n) %>% mutate_if(is.factor, as.character) %>%
  separate(col = n, into = c("heading", "values"), sep = ":") %>%
  select(heading)

row.names(head1) <- NULL

head2 <- test[2] %>% summary %>% as_data_frame() %>%
  select(n) %>% mutate_if(is.factor, as.character) %>%
  separate(col = n, into = c("heading", "values"), sep = ":") %>%
  select(heading)

row.names(head2) <- NULL

chead <- bind_rows(head1, head2)

for (i in 1:length()){
  d1 <- test[i] %>% summary %>% as_data_frame()
  y <- d1 %>% select(n) %>% mutate_if(is.factor, as.character) %>%
    separate(col = n, into = c("heading", "values"), sep = ":")
  
  row.names(y) <- NULL
  
  colnames(y) <- c("heading", colnames(test[i]))
  
  chead<- left_join(chead, y) 
}

save_train <- paste(write_path, "/data_summary.csv", sep = "")

#Save the summarised data in a csv file
write_csv(x = chead, path = save_train)
}
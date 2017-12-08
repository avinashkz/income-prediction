#! /usr/bin/env Rscript 
# read_data.R
# Avinash Prabhakaran, Nov 2016
#
# This script reads the raw data from the UCI 
# repository.
#
# Usage: Rscript read_data.R

args = commandArgs(trailingOnly = TRUE)
link_train <- args[1]
link_test <- args[2]

library(tidyverse)

main <- function(){
  
  #read the files using the links from args
  train <-  read_csv(file = link_train, col_names = FALSE)
  test <-  read_csv(file = link_test,skip = 1 ,col_names = FALSE)
  
  #path to where the files are to be saved
  save_train <- "data/train.csv"
  save_test <- "data/test.csv"
  
  #Save the processed train data
  write_csv(train, path = save_train)
  
  #Save the processed test data
  write_csv(test, path = save_test)
  
}

# call main function
main()
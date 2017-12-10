#! /usr/bin/env Rscript 
# read_data.R
# Avinash Prabhakaran, Nov 2016
#
# This script reads the raw data from the UCI 
# repository.
#
# Usage: Rscript data_read.R --train=train_url --test=test_url

library(optparse)
option_list <- list(
  make_option("--train", type = "character",
              default = "http://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data"),
  make_option("--test", type = "character",
              default = "http://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.test"))

opt <- parse_args(OptionParser(option_list = option_list))

link_train <- opt$train
link_test <- opt$test

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
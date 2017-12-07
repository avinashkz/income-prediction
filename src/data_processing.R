#! /usr/bin/env Rscript 
# data-processing.R
# Avinash Prabhakaran, Nov 2016
#
# This script reads the raw data from the data folder 
# and adds heading for both the train and test
# data sets.
#
# Usage: Rscript data-processing.R

args = commandArgs(trailingOnly = TRUE)
#Read the folder location where the data is stored in and the script will read in the test.csv and train.csv from that 
read_path <- args[1]
#Read the location where you want to save the pocessed data and it will go and save in that location as test.csv and train.csv
write_path <- args[2]


library(tidyverse)

main <- function(){
  
  #creating the path for where raw data is stored
  load_train <- paste(write_path, "/train.csv", sep = "")
  load_test <- paste(write_path, "/test.csv", sep = "")  
  
  #loading raw dara
  train <-  read_csv(file = load_train)
  test <-  read_csv(file = load_test)
  
  #Initializing headers
  headings <- c("age","workclass", "fnlwgt", "education", "educationNum", "maritalStatus",
                "occupation", "relationship", "race", "sex", "capitalGain", "capitalLoss",
                "hoursPerWeek", "nativeCountry", "class")
  
  #Adding headers
  names(train) <- headings
  names(test) <- headings
  
  train <- train %>% mutate(k50 = if_else(class == ">50K",true = 1, false = 0))
  test <- test %>% mutate(k50 = if_else(class == ">50K",true = 1, false = 0))
  
  #creating path for saving the file
  save_train <- paste(write_path, "/train.csv", sep = "")
  save_test <- paste(write_path, "/test.csv", sep = "")
  
  #Save the processed train data
  write_csv(train, path = save_train)
  
  #Save the processed test data
  write_csv(test, path = save_test)
  
}

# call main function
main()

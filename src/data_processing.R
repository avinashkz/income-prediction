#! /usr/bin/env Rscript 
# data-processing.R
# Avinash Prabhakaran, Nov 2016
#
# This script reads the raw data from the data folder 
# and adds heading for both the train and test
# data sets.
#
# Usage: Rscript data-processing.R save_folder

library(optparse)
#Read the location where pocessed data files will be saved as test.csv and train.csv
option_list <- list(
  make_option("--write", type = "character", default = "doc"))

opt <- parse_args(OptionParser(option_list = option_list))

write_path <- opt$write

library(tidyverse)

main <- function(){
  
  #creating the path for where raw data is stored
  load_train <- "data/train.csv"
  load_test <- "data/test.csv" 
  
  #loading raw dara
  train <-  read_csv(file = load_train)
  test <-  read_csv(file = load_test)
  
  #Initializing headers
  headings <- c("Age","Work_Class", "Final_Weight", "Education", "Education_Num", "Marital_Status",
                "Occupation", "Relationship", "Race", "Sex", "Capital_Gain", "Capital_Loss",
                "Hours_Per_Week", "Native_Country", "Class")
  
  #Adding headers
  names(train) <- headings
  names(test) <- headings
  
  train <- train %>% mutate(Salary_Class = if_else(Class == ">50K",true = 1, false = 0))
  test <- test %>% mutate(Salary_Class = if_else(Class == ">50K",true = 1, false = 0))
  
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

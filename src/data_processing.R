#! /usr/bin/env Rscript 
# data-processing.R
# Avinash Prabhakaran, Nov 2016
#
# This script reads the raw data from the data folder 
# and adds heading for both the train and test
# data sets.
#
# Usage: Rscript data-processing.R

library(tidyverse)

main <- function(){
  
train <-  read_csv(file = "../data/train.csv")
test <-  read_csv(file = "../data/test.csv")

headings <- c("age","workclass", "fnlwgt", "education", "age", "maritalStatus",
              "occupation", "relationship", "race", "sex", "capital-gain", "capital-loss",
              "hours-per-week", "native-country", "class")

names(train) <- headings
names(test) <- headings

write_csv(train, path = "../docs/train.csv")
write_csv(test, path = "../docs/test.csv")

}

# call main function
main()
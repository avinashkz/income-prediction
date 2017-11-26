#! /usr/bin/env Rscript 
# read_data.R
# Avinash Prabhakaran, Nov 2016
#
# This script reads the raw data from the UCI 
# repository.
#
# Usage: Rscript read_data.R


library(tidyverse)

main <- function(){

train <-  read_csv(file = "http://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data", col_names = FALSE)
test <-  read_csv(file = "http://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.test",skip = 1 ,col_names = FALSE)

write_csv(train, path = "../data/train.csv")
write_csv(test, path = "../data/test.csv")

}

# call main function
main()
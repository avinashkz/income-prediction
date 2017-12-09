#! /usr/bin/env Rscript 
# data_viz.R
# Avinash Prabhakaran, Nov 2016
#
# This script reads the training data and generates data visualisaions  
#
# Usage: Rscript data_viz.R read_path write_path

args = commandArgs(trailingOnly = TRUE)
#Read the folder location where the data is stored in and the script will read in the train.csv from that folder.
#read_path <- "doc"
#write_path <- "doc"
read_path <- args[1]
write_path <- args[2]

library(tidyverse)
library(forcats)

load_train <- paste(read_path, "/train.csv", sep = "")

main <- function() {
  
  
  
  #train <-  read_csv(file = "../doc/train.csv")
  train <<-  read_csv(file = load_train) 
  
  train %>% ggplot() +
    geom_histogram(aes(Age, fill = Class), bins = 25, color = "black") +
    scale_fill_brewer(palette = "Set2") + theme_bw()
  
  ggsave(filename = "age.png", path = "doc")
  
  for (i in 1:(ncol(train)-1)){
    val <- variable_type(train[,i])
    if (val == "categorical") {
      categorical_plots(train[,c(i,15)], i)
    }
  }
}

categorical_plots <- function(x, i){
  colnames(x) <- c("ax1", "class")
  p <-  x %>% group_by(ax1, class) %>%
    summarise(count = n()) %>% ggplot() +
    geom_col(aes(x = fct_reorder(ax1,count, .desc = TRUE),
                 y = count, fill = class), alpha = 0.7) +
    coord_flip() +
    xlab(colnames(train[,i])) +
    scale_fill_brewer(palette = "Set2") +
    theme_bw()
  
  ggsave(filename = paste(colnames(train[,i]),".png",sep = ""), path = write_path)
  plot(p)
}

variable_type <- function(x){
  vtype <- typeof(x[[1]][1])
  col_name <- colnames(x)
  exclude_list = c("Native_Country")
  if (vtype == "character" & col_name %!in% exclude_list) return("categorical")
  else {if (vtype == "integer") {   
    if (col_name %in% exclude_list) return("continous") else return("discrete")}
    else return("continous")}
}

'%!in%' <- function(x,y) {!('%in%'(x,y))}

# call main function
main()

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
  #train is a global variable
  train <<-  read_csv(file = load_train) 
  
  g <- train %>% ggplot() +
    geom_histogram(aes(Age, fill = Class), bins = 25, color = "black") + labs(title = "Histogram of Age", y = "Count") +
    scale_fill_brewer(palette = "Set2") + theme_bw() + theme(plot.title = element_text(hjust = 0.5))
  ggsave(filename = "age.png", path = "doc")
  
  for (i in 1:(ncol(train)-2)){
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
    xlab(colnames(train[,i])) + 
    labs(title = paste("Count Plot of" ,colnames(train[,i])), y = "Count") +
    scale_fill_brewer(palette = "Set2") +
    theme_bw() + theme(plot.title = element_text(hjust = 0.5))
    
    if(n_distinct(train[,i]) > 3){
     ggsave(plot = p + coord_flip(), filename = paste(tolower(colnames(train[,i])),".png",sep = ""), path = write_path)
    }
    else
    {
      ggsave(filename = paste(tolower(colnames(train[,i])),".png",sep = ""), path = write_path)
    }
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

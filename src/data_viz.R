#! /usr/bin/env Rscript 
# data_viz.R
# Avinash Prabhakaran, Nov 2016
#
# This script reads the training data and generates data visualisaions  
#
# Usage: Rscript data_viz.R --read=read_path --write=write_path

#args = commandArgs(trailingOnly = TRUE)
#Read the folder location where the data is stored in and the script will read in the train.csv from that folder.
#read_path <- "doc"
#write_path <- "doc"
#read_path <- args[1]
#write_path <- args[2]

library(optparse)

option_list <- list(
  make_option("--read", type = "character", default = "doc"),
  make_option("--write", type = "character", default = "doc"))

opt <- parse_args(OptionParser(option_list = option_list))

read_path <- opt$read
write_path <- opt$write

library(tidyverse)
library(forcats)

load_train <- paste(read_path, "/train.csv", sep = "")

main <- function() {
  
  #train is a global variable
  train <<-  read_csv(file = load_train) 
  
  
  g <- train %>% ggplot() +
    geom_histogram(aes(Age, fill = Class), bins = 25, color = "black", alpha = 0.7) + 
    labs(title = "Histogram for Age", y = "Count") +
    scale_fill_manual(values = c("black","red")) + 
    theme_bw() + theme(plot.title = element_text(hjust = 0.5, size = 16), 
                       axis.text = element_text(size = 12), 
                       axis.title = element_text(size = 14))
  
  ggsave(filename = "age.png", path = "doc")
  
  q <- train %>% ggplot() +
    geom_histogram(aes(Age, fill = Class), bins = 25, color = "black", position = "fill", alpha = 0.7) + 
    labs(title = "Proportions for Age", y = "Proportion") +
    scale_fill_manual(values = c("darkblue","orange")) + 
    theme_bw() + theme(plot.title = element_text(hjust = 0.5, size = 16), 
                       axis.text = element_text(size = 12), 
                       axis.title = element_text(size = 14))
  
  ggsave(filename = "age_prop.png", path = "doc")  
  
  train %>% ggplot() +
    geom_histogram(aes(Hours_Per_Week, fill = Class), bins = 25, color = "black", alpha = 0.7) + 
    labs(title = "Histogram for Hours Per Week", y = "Proportion") +
    scale_fill_manual(values = c("black","red")) + 
    theme_bw() + theme(plot.title = element_text(hjust = 0.5, size = 16), 
                       axis.text = element_text(size = 12), 
                       axis.title = element_text(size = 14))
  
  ggsave(filename = "hours.png", path = "doc")  
  
  train %>% ggplot() +
    geom_histogram(aes(Hours_Per_Week, fill = Class), bins = 25, color = "black", position = "fill", alpha = 0.7) + 
    labs(title = "Proportions for Hours Per Week", y = "Proportion") +
    scale_fill_manual(values = c("darkblue","orange")) + 
    theme_bw() + theme(plot.title = element_text(hjust = 0.5, size = 16), 
                       axis.text = element_text(size = 12), 
                       axis.title = element_text(size = 14))
  
  ggsave(filename = "hours_prop.png", path = "doc")  
  
  for (i in 1:(ncol(train)-2)){
    val <- variable_type(train[,i])
    if (val == "categorical") {
      categorical_plots(train[,c(i,15)], i)
    }
  }
}

categorical_plots <- function(x, i){
  
  #Function to plot all the categorical variable
  
  colnames(x) <- c("ax1", "Class")
  
  p <-  x %>% group_by(ax1, Class) %>%
    summarise(count = n()) %>% ggplot() +
    geom_col(aes(x = fct_reorder(ax1,count, .desc = TRUE),
                 y = count, fill = Class), alpha = 0.7, color = "black") +
    xlab(colnames(train[,i])) + 
    labs(title = paste("Bar Plot for" ,colnames(train[,i])), y = "Count") +
    scale_fill_manual(values = c("black","red")) +
    theme_bw() + theme(plot.title = element_text(hjust = 0.5, size = 16), 
                       axis.text = element_text(size = 12), 
                       axis.title = element_text(size = 14))
  
  q <- x %>% group_by(ax1) %>% mutate(count = n()) %>% 
    ggplot(aes(fct_reorder(ax1,count, .desc = TRUE))) +
    geom_bar(aes(y = (..count..)/sum(..count..), fill = Class), position = "fill", color = "black", alpha = 0.7) +
    xlab(colnames(train[,i])) +
    labs(title = paste("Proportions for" ,colnames(train[,i])), y = "Proportion") +
    scale_fill_manual(values = c("darkblue","orange")) +
    theme_bw() + theme(plot.title = element_text(hjust = 0.5, size = 16), 
                       axis.text = element_text(size = 12), 
                       axis.title = element_text(size = 14))
  

    if(n_distinct(train[,i]) > 3){
     ggsave(plot = p + coord_flip(),
            filename = paste(tolower(colnames(train[,i])),".png",sep = ""),
            path = write_path)
      
     ggsave(plot = q + coord_flip(),
            filename = paste(tolower(colnames(train[,i])),"_prop.png",sep = ""),
            path = write_path)
    }
    else
    {
      ggsave(plot = p,
             filename = paste(tolower(colnames(train[,i])),".png",sep = ""),
             path = write_path)
      ggsave(plot = q,
             filename = paste(tolower(colnames(train[,i])),"_prop.png",sep = ""),
             path = write_path)
    }
}

variable_type <- function(x){
  #Function to return the type of the variable
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

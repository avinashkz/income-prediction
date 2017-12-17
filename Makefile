# Driver script
# Avinash Prabhakaran, Nov 2017
# Script automates reading, processing and visualising data
#
# usage: make all

train_link = http://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data
test_link = http://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.test
data_path = doc


all: report

#To read the data in from the URL. The arguments are optional and have been stored as variables in the makefile.
read_data:
	Rscript src/data_read.R --train=$(train_link) --test=$(test_link)

#To process the raw data. 
data_processing: read_data
	Rscript src/data_processing.R --write=$(data_path)

#To generate a summary of all the continuous variable
data_summary:
	Rscript src/data_summary.R --read=$(data_path) --write=$(data_path)

#To generate various plots of the dataset.
data_viz: data_processing
	Rscript src/data_viz.R --read=$(data_path) --write=$(data_path)

#To create confusion matrix
matrix:
	python3 src/model.py

#To create the report.
report: data_viz data_summary matrix
	Rscript -e 'rmarkdown::render("src/report.Rmd", output_dir = "results")'

#To delete all the files created.
remove:	clean
	rm data/*

#To delete all the files created for analysis
clean:
	rm results/*
	rm doc/*
	


# Driver script
# Avinash Prabhakaran, Nov 2017
# Script automates reading, processing and visualising data
#
# usage: make all

train_link = http://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data
test_link = http://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.test
data_path = doc


all: report

read_data:
	Rscript src/data_read.R $(train_link) $(test_link)

data_processing: read_data
	Rscript src/data_processing.R $(data_path) $(data_path)

data_summary:
	Rscript src/data_summary.R $(data_path) $(data_path)

data_viz: data_processing
	Rscript src/data_viz.R $(data_path) $(data_path)

report: data_viz data_summary
	Rscript -e 'ezknitr::ezknit("src/report.Rmd", out_dir = "results")'

remove:
	rm doc/*.png


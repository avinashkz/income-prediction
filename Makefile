# Driver script
# Avinash Prabhakaran, Nov 2017
# The script reads in data from the links and processes the data saves it in the doc folder.
#
# usage: make all

train_link = http://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data
test_link = http://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.test
data_path = data


all: data_processing

read_data:
	Rscript src/read_data.R $(train_link) $(test_link) $(data_path)

data_processing:
	Rscript src/data_processing.R data doc

train_link = http://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data
test_link = http://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.test
data_path = data

all1:
	Rscript src/read_data.R $(train_link) $(test_link) $(data_path)


all:
	Rscript src/read_data.R http://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data http://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.test data


read_data:
	Rscript src/read_data.R http://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data http://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.test data

data_processing:
	Rscript src/data_processing.R data doc

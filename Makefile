$train_link = "http://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data"
$test_link = "http://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.test"

all:
	Rscript src/read_data.R $train_link $test_link

	

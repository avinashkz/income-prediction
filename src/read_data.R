library(tidyverse)
train <-  read_csv(file = "http://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data", col_names = FALSE)
test <-  read_csv(file = "http://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.test",skip = 1 ,col_names = FALSE)

headings <- c("age","workclass", "fnlwgt", "education", "age", "maritalStatus",
              "occupation", "relationship", "race", "sex", "capital-gain", "capital-loss",
              "hours-per-week", "native-country", "class")
names(train) <- headings



View(test)
View(train)


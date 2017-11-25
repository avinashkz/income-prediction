library(tidyverse)

train <-  read_csv(file = "http://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data", col_names = FALSE)
test <-  read_csv(file = "http://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.test",skip = 1 ,col_names = FALSE)

headings <- c("age","workclass", "fnlwgt", "education", "age", "maritalStatus",
              "occupation", "relationship", "race", "sex", "capital-gain", "capital-loss",
              "hours-per-week", "native-country", "class")

names(train) <- headings
names(test) <- headings

write_csv(train, path = "../data/train.csv")
write_csv(test, path = "../data/test.csv")

#View(test)
#View(train)

census <- bind_rows(test,train)

#a <- nrow(test)
#b <- nrow(train)
#a+b
#nrow(census)

write_csv(train, path = "../data/census.csv")


library(tidyverse)

train <-  read_csv(file = "../data/train.csv", col_names = FALSE)
test <-  read_csv(file = "../data/test.csv",skip = 1 ,col_names = FALSE)

headings <- c("age","workclass", "fnlwgt", "education", "age", "maritalStatus",
              "occupation", "relationship", "race", "sex", "capital-gain", "capital-loss",
              "hours-per-week", "native-country", "class")

names(train) <- headings
names(test) <- headings

write_csv(train, path = "../docs/train.csv")
write_csv(test, path = "../docs/test.csv")

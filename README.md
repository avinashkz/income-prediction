## Data Set

[Adult Data Set](http://archive.ics.uci.edu/ml/datasets/Adult) from UCI Machine Learning Repository. Also known as "Census Income" dataset. It is used to predict whether a person's income exceeds $50K/yr based on census data.

| Dataset Features           |                      |
|----------------------------|----------------------|
| Number of Records:         | 488442               |
| Number of Variables:       | 14                   |
| Attribute Characteristics: | Categorical, Integer |
| Missing Values?            | Yes                  |
| Associated Tasks:          | Classification       |
| Date Collected:            | 1996-05-01           |


## Question

Is it possible to correctly identify which `salary-class`(greater than or less than $50k) a person belongs to based on the features such as `age`, `workclass`, `final-weight`, `education`, `education-number`, `marital-status`, `occupation`, `relationship`, `race`, `sex`, `capital-gain`, `capital-loss`, `hours-per-week` and `native-country` ?
## Hypothesis

The hypothesis is that it should be able to accurately identify the `salary-class` of a person based on the given features.

## Plan of Action

Create a script to read the data from the UCI Machine Learning Repository and store the data locally in the data folder for processing the data before it is used.

Read the data into a new script to wrangle the data to use data visualization for better understand the dataset and how the different variables are distributed. Also, identify the variables that can better explain the problem.

Split the categorical variables into multiple variables so that these variables can be used in a classification algorithm. Then, select a classification machine learning algorithm and train it on the test data and then predict the `salary-class` of all the people in test dataset to evaluate the model's performance. Now, try tuning the hyper-parameters to improve the model's performance. If the results applied using the algorithm is not satisfactory then apply different supervised classification algorithms to check if the algorithm is most accurate in classifying the data.
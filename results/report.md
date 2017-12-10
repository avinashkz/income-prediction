# Income Prediction Report
Avinash  
29/11/2017  

<style>

.middle {
text-align: center;
}

</style>






## Raw Data Obtained

A quick look at the data obtained from the UCI Machine Learning Reposiotry:


 X1  X2                     X3  X4           X5  X6                   X7                X8              X9      X10      X11   X12   X13  X14             X15   
---  -----------------  ------  ----------  ---  -------------------  ----------------  --------------  ------  -----  -----  ----  ----  --------------  ------
 39  State-gov           77516  Bachelors    13  Never-married        Adm-clerical      Not-in-family   White   Male    2174     0    40  United-States   <=50K 
 50  Self-emp-not-inc    83311  Bachelors    13  Married-civ-spouse   Exec-managerial   Husband         White   Male       0     0    13  United-States   <=50K 

## Summary of Continuous Variables

Statistical summary of all the continious variables from the dataset:


Features      Age   Final_Weight   Education_Num   Capital_Gain   Capital_Loss   Hours_Per_Week   Salary_Class
---------  ------  -------------  --------------  -------------  -------------  ---------------  -------------
Min.        17.00          12285            1.00              0            0.0             1.00         0.0000
1st Qu.     28.00         117827            9.00              0            0.0            40.00         0.0000
Median      37.00         178356           10.00              0            0.0            40.00         0.0000
Mean        38.58         189778           10.08           1078           87.3            40.44         0.2408
3rd Qu.     48.00         237051           12.00              0            0.0            45.00         0.0000
Max.        90.00        1484705           16.00          99999         4356.0            99.00         1.0000


## Data Visualizations

### Analysis of Age Variable

<div class = "middle">
<img src = "../doc/age.png" width = "400" height = "400">
<img src = "../doc/age_prop.png" width = "400" height = "400">
</div>

The number of people who earns more than $50,000 increases from an age of 25 to a maximum number of people at around the age of 35.
About 40% of the people aged around 50 earn above $50,000.


### Analysis of Hours Per Week Variable

<div class = "middle">
<img src = "../doc/hours.png" width = "400" height = "400">
<img src = "../doc/hours_prop.png" width = "400" height = "400">
</div>


About 40% of the people who work about 45-60 hours a week earn more than \$50,000. Only a small proportion of the people who work below 45 hours earn more than \$50,000. Strangely, about 20% of the people who work close to 0 hours a week earn more than \$50,000.

### Analysis of Sex Variable

<div class = "middle">
<img src = "../doc/sex.png" width = "400" height = "400">
<img src = "../doc/sex_prop.png" width = "400" height = "400">
</div>

The number of records for `Male` are double than that of `Female`. The proportion of female who earn more than $50,000 are less than one-third of that of the male population.

### Analysis of Education Variable

<div class = "middle">
<img src = "../doc/education.png" width = "400" height = "400">
<img src = "../doc/education_prop.png" width = "400" height = "400">
</div>

The ratio of people who earn more than \$50,000 increases with their level of education. The proportion of people who earn more than \$50,000 is the people who have `Doctorate` and it is closely followed by people who went to `Professional school`. Following this trend the proportions for people who has not completed High school is very low.

### Analysis of Marital Status Variable

<div class = "middle">
<img src = "../doc/marital_status.png" width = "400" height = "400">
<img src = "../doc/marital_status_prop.png" width = "400" height = "400">

</div>

About 15,000 people from the population have a marital status of `Married-civ-spouse` and about 45% of the people in this group earn more than \$50,000. The next largest group in this section is `Never-married`, closely followed by `Divorced`; and only a small proportion of these groups earn above \$50,000.

### Analysis of Occupation Variable

<div class = "middle">
<img src = "../doc/occupation.png" width = "400" height = "400">
<img src = "../doc/occupation_prop.png" width = "400" height = "400">
</div>

Among the larger groups, about 50% of the people woking as Professional Speciality and Executive Managerial earn above \$50,000. One of the larger groups with the lowest proportion is `Other-services`. Only a small proportion of less than 10% get paid more than \$50,000.

### Analysis of Family Relationship Variable

<div class = "middle">
<img src = "../doc/relationship.png" width = "400" height = "400">
<img src = "../doc/relationship_prop.png" width = "400" height = "400">
</div>

When the sample is classified based on their relation,a higher proportion of `Wives` earn more than $50,000 than any other relation. This is closely follow by `Husband`. However, it should be also noted that the number of wives in the sample are much smaller when compared to husbands.

### Analysis of Race Variable

<div class = "middle">
<img src = "../doc/race.png" width = "400" height = "400">
<img src = "../doc/race_prop.png" width = "400" height = "400">
</div>


The races with the higher proportion of salaries are `White` and `Asian-Pac-Islander` at about 25% and other races have a proportion of about 10%. But it should be noted that there are only a few hundred people in the `Asian-Pac-Islander` group.

### Analysis of Work Class Variable

<div class = "middle">
<img src = "../doc/work_class.png" width = "400" height = "400">
<img src = "../doc/work_class_prop.png" width = "400" height = "400">
</div>


Majority of the people work in `Private` sector and about one-fourth of the people earn above \$50,000. The highest proportion of people who earn above \$50,000 are Self Employed. This is closely followed by `Federal-gov` and then `State-gov`.

### Model Using Random Forests



                        Actual Less than 50   Actual More than 50
---------------------  --------------------  --------------------
Predict Less than 50                  14340                  1941
Predict More than 50                      0                     0


When a model is created using only the age and hours a person works per week then an accuracy of 88% is obtained but this is obtained by classifying everying person as earning less than $50,000.

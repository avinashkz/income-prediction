import numpy as np
import pandas as pd
import csv
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report,confusion_matrix

def main():
    #Read test and train data into script
    train = pd.read_csv("doc/train.csv")
    test = pd.read_csv("doc/test.csv")

    #Select Age and hours per week variables for train dataset
    x_train = train.iloc[:,[0,12]]
    y_train = train.iloc[:,15:16]

    #Select Age and hours per week variables for test dataset
    x_test = test.iloc[:,[0,12]]
    y_test = test.iloc[:,15:16]

    #Use RandomForestClassifier
    rfc = RandomForestClassifier(n_estimators=100)
    rfc.fit(x_train, y_train)

    #Score the model.
    print(rfc.score(x_test, y_test))

    #
    rfc_pred = rfc.predict(x_test)
    cr = classification_report(y_test,rfc_pred)
    cm = confusion_matrix(y_test,rfc_pred)

    #Save the confusion_matrix in a file
    with open('doc/confusion_matrix.csv', 'w') as csvfile:
        writer = csv.writer(csvfile)
        [writer.writerow(r) for r in cm]

    #Save the classification_report in a file
    with open('doc/classification_report.csv', 'w') as csvfile:
        writer = csv.writer(csvfile)
        [writer.writerow(r) for r in cr]


# call main function
if __name__ == "__main__":
    main()

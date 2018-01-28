import pandas as pd
import numpy as np
from sklearn.model_selection import GridSearchCV
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import mean_squared_error as mse
from sklearn.metrics import confusion_matrix
import matplotlib.pyplot as plt
import seaborn as sns

def main():
    #Read test and train data into script
    train = pd.read_csv("doc/train.csv")
    test = pd.read_csv("doc/test.csv")

    #Dropping the row variable
    train.drop(train.columns[0], axis=1, inplace=True)
    test.drop(test.columns[0], axis=1, inplace=True)

    #Select Age and hours per week variables for test dataset
    X = train.iloc[:,np.arange(0,106)]
    y = train.iloc[:,106]
    Xtest = test.iloc[:,np.arange(0,106)]
    ytest = test.iloc[:,106]
    
    X_train, X_val, y_train, y_val = train_test_split(X, y, test_size=0.2)
    
    #Plot for L2 Regularization
    
    train_error = []
    val_error = []

    for i in np.logspace(-8,4,20):
        lr = LogisticRegression(C=i, penalty = 'l2')
        lr.fit(X_train,y_train)
        train_error.append(lr.score(X_train, y_train))
        val_error.append(lr.score(X_val, y_val))
    plt.semilogx(np.logspace(-8,4,20),train_error,'b--', label = "Train Score")
    plt.semilogx(np.logspace(-8,4,20),val_error,'g--', label = "Validation Score")
    plt.legend()
    plt.title("Variation in Score for L2 Model")
    plt.xlabel("C")
    plt.ylabel("Score")
    plt.savefig('../doc/l2.png')

    #Plot for L1 Regularization

    train_error = []
    val_error = []

    for i in np.logspace(-8,4,20):
        lr = LogisticRegression(C=i, penalty = "l1")
        lr.fit(X_train,y_train)
        train_error.append(lr.score(X_train, y_train))
        val_error.append(lr.score(X_val, y_val))
    plt.semilogx(np.logspace(-8,4,20),train_error,'b--', label = "Train Score")
    plt.semilogx(np.logspace(-8,4,20),val_error,'g--', label = "Validation Score")
    plt.legend()
    plt.title("Variation in Score for L1 Model")
    plt.xlabel("C")
    plt.ylabel("Score")
    plt.savefig('../doc/l1.png')

    # Tuning C for Logistic Regression

    parameters = {'C': np.logspace(-4,4,9), 'penalty': ['l1','l2']}
    lr = LogisticRegression()
    cv = GridSearchCV(lr, parameters)
    cv.fit(X, y)

    print(cv.best_params_)

    print(cv.best_score_)


    lr = LogisticRegression(C = 100, penalty='l1')

    lr.fit(X,y)
    print(lr.score(X,y))
    print(lr.score(Xtest,ytest))
    print(lr.coef_)
    
    # Plot for Random Forest Classifier

    train_error = []
    val_error = []

    for i in np.linspace(2,106,5):
        rfc = RandomForestClassifier(max_depth = i)
        rfc.fit(X_train,y_train)
        train_error.append(rfc.score(X_train, y_train))
        val_error.append(rfc.score(X_val, y_val))
    plt.plot(np.linspace(2,106,5),train_error,'b--', label = "Train Score")
    plt.plot(np.linspace(2,106,5),val_error,'g--', label = "Validation Score")
    plt.legend()
    plt.title("Variation in Score for Random Forest Classifier")
    plt.xlabel("Max Depth")
    plt.ylabel("Score")
    plt.savefig('../doc/rfc.png')

    print("Random Forest Classifier")

    # Identifying Optimum maximum depth using Cross validation
    
    parameters = {'max_depth': np.arange(1,106,5)}
    rfc = RandomForestClassifier()
    cv = GridSearchCV(rfc, parameters)
    cv.fit(X, y)
    
    print(cv.best_params_)
    
    print(cv.best_score_)
    
    rfc = RandomForestClassifier(max_depth=16)
    
    rfc.fit(X,y)
    
    y_pred = rf.pred(Xtest)


    print(rfc.score(X,y))
    
    y_pred = rfc.predict(Xtest)
    
    print(rfc.score(Xtest,ytest))

    #Printing the confusion matrix
    
    print(confusion_matrix(y_pred=y_pred,y_true=ytest))
    
    


# call main function
if __name__ == "__main__":
    main()

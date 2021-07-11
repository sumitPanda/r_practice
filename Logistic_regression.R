#library calls.
library(dplyr)
library(datasets)
library(moments)
library(readxl)
library(pivottabler)
library(tidyverse)
library(stringr)

#Must libraries 
library(ggplot2)
library("lattice")
library("caret")
library(ROCR)
library(InformationValue)
library(car)
library(carData)


# settings working directory

setwd("D:\\OneDrive\\My Drive\\IPBA course\\R data sets")

#read the dataset 
titanic_master = read.csv("Titanic_logit.csv",
                          strip.white = TRUE,
                          header=T,
                          na.strings = c(""),
                          stringsAsFactors = T)

#view the data set 
#View(titanic_master)
test_titanic= titanic_master
head(test_titanic)
summary(test_titanic)

#Lets see if we have misisng values? 
colSums(is.na(test_titanic))

#Lets find the balanced values
#this test is done to check if the data is balanced or now. 
table(test_titanic$Survived)

# remove the variables,ID,Name,Ticket and Cabin by selecting the fields we want. 
test_titanic = subset(titanic_master,select=c(2,3,5,6,7,8,10,12)) 


#Outlier treatment? - not now. We will run the model, then come back to this. 


#missing value imputation. We cannot remove the missing values. So we add mean to them. 
test_titanic$Age[is.na(test_titanic$Age)] = mean(test_titanic$Age,na.rm=T)
test_titanic = test_titanic[!is.na(test_titanic$Embarked),]

#Why is it used? Whats the point? 
contrasts(test_titanic$Sex)
contrasts(test_titanic$Embarked)


#divide the dataset
train = test_titanic[1:800,]
test = test_titanic[801:889,]

#Create the model

#Create values
Survived = train$Survived
Sex = train$Sex
Age = train$Age
SiblingCount = train$SibSp
parent_count = train$Parch
PassengerClass = train$Pclass
Embarked = train$Embarked
Ticket = train$Ticket


#model now
model_1 = glm(Survived~.
              ,family=binomial(link='logit')
              ,data=train
              )

summary(model_1)

#Lets check the best way to laod the data. The interaction will be tested by the step functions
step(model_1,direction="both")


#model now, after the step function
model_1 = glm(formula = Survived ~ Pclass + Sex + Age + SibSp, family = binomial(link = "logit"), 
    data = train)

summary(model_1)

#we have the model now. However, we have to test the model. This is against the fit, so Chi Square test is used. 
anova(model_1,test="Chisq")

# Before we move on to any predicted model. We have to tune the model up. This might be required if we have large data model. 
# We are not doing that here as the values are pretty clear. 


#model has been trained. Now, we create the result set
predicted_values = predict(model_1,newdata=subset(test,select=c(2,3,4,5,6,7,8)), type="response")
head(predicted_values)

# The values which are in output, they are not binary. We need to convert them to the binary values
predicted_bucket = ifelse(predicted_values>0.5,1,0)
head(predicted_bucket)

# the values are out. Now we are going to add them to the result set
test$predicted = predicted_values
test$predicted_bucket = predicted_bucket

#lets create the data set and test the values
Predicted_dataset = data.frame(test,predicted_values,predicted_bucket)


#lets create the confusion matrix to validate the accuracy
confusionMatrix(as.factor(test$Survived),as.factor(test$predicted_bucket))

##Misclassification Error
#Misclassification error is the percentage mismatch of predicted vs actuals, irrespective of 1's or 0's.
#The lower the misclassification error, the better is your model.

misClasificError <- mean(predicted_bucket!= test$Survived)
print(paste('Accuracy',1-misClasificError))



#ROCR
pr <- prediction(predicted_values, test$Survived)

prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)

auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
auc



#splitting 70:30 ratio
set.seed(100)
dt = sort(sample(nrow(data), nrow(data)*.7))
train<-data[dt,]
test<-data[-dt,]

vif(model_1)

#If the VIF is equal to 1 there is no multicollinearity among factors, 
#but if the VIF is greater than 1, the predictors may be moderately correlated.
#The output above shows that the VIF for the Publication and Years factors are about 1.5, 
#which indicates some correlation, but not enough to be overly concerned about.
# A VIF between 5 and 10 indicates high correlation that may be problematic. 
#And if the VIF goes above 10, you can assume that the regression coefficients are poorly 
#estimated due to multicollinearity.



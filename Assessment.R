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
library(oddsratio)
library(stats)
library(epitools)

# settings working directory

setwd("D:\\OneDrive\\My Drive\\IPBA course\\R data sets")

#read the dataset 
adult_master = read.csv("adult-1-1.csv",
                          strip.white = TRUE,
                          header=T,
                          na.strings = c(""))
                          #,stringsAsFactors = T)
#=============================
#view the data set 
#View(titanic_master)
test_adult= adult_master
head(test_adult)
summary(test_adult)

#Lets see if we have misisng values? 
colSums(is.na(test_adult))
colnames(test_adult)

#Lets find the balanced values
#this test is done to check if the data is balanced or now. 
table(test_adult$income)

#Outlier treatment? - not now. We will run the model, then come back to this. 


test_adult$HighEarner = ifelse(test_adult$income == '>50K',1,0)


table(test_adult$occupation)

table(test_adult$fnlwgt)


#=============================
#EDA plots 
#age, fnlwgt, education_num, capital_gain, capital_loss, hours_per_week, and two categorical variables - gender and occupation.

hist(test_adult$age)
barplot(table(test_adult$income))


#=============================
#model now
model_ALL = glm(income~.
              ,family=binomial(link='logit')
              ,data=test_adult
)

summary(model_1)
colnames(test_adult)
table(test_adult$occupation)


#model now, after the step function

model_1 = glm(formula = HighEarner ~ age +gender + fnlwgt + educational.num + capital.gain+ capital.loss + hours.per.week + factor(gender) + factor(occupation), 
              family = binomial(link = "logit"), data = test_adult) 
vif(model_1)
summary(model_1)


model_2 = glm(formula = HighEarner ~ gender, 
              family = binomial(link = "logit"), data = test_adult)

summary(model_2)


model_3 = glm(formula = HighEarner ~ age + fnlwgt + educational.num + capital.gain+ capital.loss + hours.per.week, 
              family = binomial(link = "logit"), data = test_adult)
          
summary(model_3)


vif(model_3)

model_2 = glm(formula = HighEarner ~ gender, 
              family = binomial(link = "logit"), data = test_adult)

summary(model_2)

oddsratio(model_2)
exp(coef(model_2))

#Lets check the best way to laod the data. The interaction will be tested by the step functions
step(model_1,direction="both")

#we have the model now. However, we have to test the model. This is against the fit, so Chi Square test is used. 
anova(model_1,test="Chisq")

# Before we move on to any predicted model. We have to tune the model up. This might be required if we have large data model. 
# We are not doing that here as the values are pretty clear. 


#model has been trained. Now, we create the result set
predicted_values = predict(model_1,newdata=test_adult, type="response")
head(predicted_values)

# The values which are in output, they are not binary. We need to convert them to the binary values
predicted_bucket = ifelse(predicted_values>0.5,1,0)
head(predicted_bucket)

predicted_bucket = ifelse(predicted_values>0.75,1,0)


# the values are out. Now we are going to add them to the result set
test_adult$predicted = predicted_values
test_adult$predicted_bucket = predicted_bucket

misClasificError <- mean(predicted_bucket!= test_adult$HighEarner)
print(paste('Accuracy',1-misClasificError))

#lets create the data set and test the values
Predicted_dataset = data.frame(test_adult,predicted_values,predicted_bucket)


#lets create the confusion matrix to validate the accuracy
confusionMatrix(as.factor(test_adult$HighEarner),as.factor(test_adult$predicted_bucket))

##Misclassification Error
#Misclassification error is the percentage mismatch of predicted vs actuals, irrespective of 1's or 0's.
#The lower the misclassification error, the better is your model.

misClasificError <- mean(predicted_bucket!= test_adult$HighEarner)
print(paste('Accuracy',1-misClasificError))



#ROCR
pr <- prediction(predicted_values, test_adult$HighEarner)

prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)

auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
auc



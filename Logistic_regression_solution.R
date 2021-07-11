#Logistic Regression- Case study##

#Import the data
titanic=read.csv("D://Desktop//IPBA session//Titanic.csv",header=T,na.strings=c(""))

head(titanic)
table(titanic$Survived)

# missing values
colSums(is.na(titanic))

# remove the variables,ID,Name,Ticket and Cabin
data <- subset(titanic,select=c(2,3,5,6,7,8,10,12))

#missing value imputation
data$Age[is.na(data$Age)] <- mean(data$Age,na.rm=T)

data <- data[!is.na(data$Embarked),]
#rownames(data) <- NULL

contrasts(data$Sex)
contrasts(data$Embarked)

# Split the data as train and test (80:20)
train <- data[1:800,]
test <- data[801:889,]

model <- glm(Survived ~.,family=binomial(link='logit'),data=train)
summary(model)

anova(model, test="Chisq")

#Prediction
#fitted.results <- predict(model,newdata=subset(test,select=c(2,3,4,5,6,7,8)),type='response')
#fitted.results <- ifelse(fitted.results > 0.5,1,0)
#misClasificError <- mean(fitted.results != test$Survived)
#print(paste('Accuracy',1-misClasificError))
p <- predict(model,newdata=subset(test,select=c(2,3,4,5,6,7,8)), type="response")

head(p)

predbkt<-ifelse(p>0.5,1,0)
head(predbkt)
test$predicted<-p
test$predbkt<-predbkt

pred<-data.frame(test,p,predbkt)

# export the data
write.csv(pred,"D://Desktop//predicted1.csv")

library("lattice")
library("ggplot2")
library("caret")

confusionMatrix(as.factor(test$Survived),as.factor(test$predbkt))
#confusionMatrix(as.factor(test$Survived),test$predbkt)


misClasificError <- mean(predbkt!= test$Survived)
print(paste('Accuracy',1-misClasificError))

#ROCR
library(ROCR)
pr <- prediction(p, test$Survived)

prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)

auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
auc
##############################################

##Misclassification Error
#Misclassification error is the percentage mismatch of predcited vs actuals, irrespective of 1's or 0's.
#The lower the misclassification error, the better is your model.



#splitting 70:30 ratio
set.seed(100)
dt = sort(sample(nrow(data), nrow(data)*.7))
train<-data[dt,]
test<-data[-dt,]

library(InformationValue)
library(car)
library(carData)
vif(model)

#If the VIF is equal to 1 there is no multicollinearity among factors, but if the VIF is greater than 1, the predictors may be moderately correlated. The output above shows that the VIF for the Publication and Years factors are about 1.5, which indicates some correlation, but not enough to be overly concerned about. A VIF between 5 and 10 indicates high correlation that may be problematic. 
#And if the VIF goes above 10, you can assume that the regression coefficients are poorly estimated due to multicollinearity.



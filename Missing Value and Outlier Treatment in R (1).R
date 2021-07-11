# -----------------------------------------------------------
# Missing Value and Outlier Treatment in R
# -----------------------------------------------------------

#Loading important libraries
#for data manipulation and Viz
library(dplyr)
library(ggplot2)

#-------Importing the data---------
setwd("D:\\OneDrive\\My Drive\\IPBA course\\R data sets")
titanic<-read.csv("titanic.csv")


#checking outliers
x<-boxplot(titanic$Age)

str(x)

# Outlier treatment - Way 1
#To get list of outliers
list_out<- x$out
list_out

#gives the positions in the data where outliers are present
index<-which(titanic$Age %in% list_out)
index

#---Shortlist the outliers from the dataset and replace
titanic$Age[index]

#na.rm=TRUE --> making sure missing values are removed before calculating mean
mean_Age<-mean(titanic$Age,na.rm=TRUE)

# Let's create another columns with outlier treated Age col
titanic$Age_ot <- titanic$Age
titanic$Age_ot[index]<-mean_Age

# Outlier treatment - way 2
qn= quantile(titanic$Age, c(0.01, 0.05, 0.95, 0.99), na.rm = TRUE)
qn

y<- IQR(titanic$Age)
q1 <- quantile(titanic$Age, 0.25)
q3 <- quantile(titanic$Age, 0.75)

titanic$Age_ot_fc <- ifelse(titanic$Age< q1-1.5*y, qn[1],
                            ifelse(titanic$Age > q3+1.5*y, qn[4],
                                   titanic$Age))

boxplot(titanic$Age_ot_fc)
hist(titanic$Age_ot_fc)
?hist

# Missing value identification and treatment
# airquality dataset from R base library
aq <- airquality

# count of missing values
colSums(is.na(aq))

# Missing imputation with mean
mean_solar <- mean(aq$Solar.R, na.rm = TRUE)
mean_solar

aq$Solar.R <- ifelse(is.na(aq$Solar.R), mean_solar, aq$Solar.R)
colSums(is.na(aq))

# Deleting records with missing

aq_del <- aq[!is.na(aq$Ozone),]
# see how ! symbol is working

!is.na(aq$Ozone)

#-------------------------
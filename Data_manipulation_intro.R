library(moments)
getwd()
#setwd("D:\\My Drive\\IPBA course\\R and Data Viz\\Data Processing and Data Visualization - Pre class Video Datasets\\Introduction to R")
setwd("D:\\My Drive\\IPBA course\\R data sets")
retail<-read.csv("retail_sales (1).csv")
retail


head(retail)
dim(retail)
summary(retail$Cost)
str(retail)

hist(retail$Cost)
skewness(retail$Cost)


retail$profit = retail$Revenue - retail$Cost
summary(retail$profit)
summary(retail$Units_Sold)

skewness(retail$profit)
skewness(retail$Units_Sold)

order(retail$Cost,decreasing = TRUE)

#sorted
sorted = retail [order(retail$Cost,decreasing = TRUE),]
sorted

#logical argument
retail$Cost<3000
retail$Cost[retail$Cost<3000]
retail[retail$Cost<3000,]

#which
which(retail$Cost<3000) #provides row indices where the values are less than 3000




which (retail$Cost==max(retail$Cost))
retail[which (retail$Cost==max(retail$Cost)),]

retail[4,] # Whats this? Why does this behave this way?

retail_sub = retail [which (retail$Cost==max(retail$Cost)),which(names(retail) %in% c("Month","Revenue"))]
retail_sub


#matching
retail[retail$Item_Category == 'Literature','Revenue',]
max(retail[retail$Item_Category == 'Literature','Revenue',])
summary(retail[retail$Item_Category == 'Literature','Revenue',])

####################################
#library calls.
library(dplyr)
library(datasets)
library(moments)
library(readxl)
# settings working directory
getwd()
setwd("D:\\My Drive\\IPBA course\\R data sets")
####################################


netflix_description= read.csv('netflix_show_discription.csv',na.strings = "")
netflix_titles= read.csv('netflix_titles.csv',na.strings = "")


str(netflix_description)
str(netflix_titles)
summary(netflix_titles)
summary(netflix_description)
#1. How many TV show and Movies in the data set
summary(netflix_titles$show_id)

#check frequency? 
table(netflix_titles$show_id)


#2. How many movies and TV show realese in 2017, 2018 and 2019
str(netflix_titles[netflix_titles$release_year<2020 & netflix_titles$release_year>2016, ]$type)
length(netflix_titles[netflix_titles$release_year<2020 & netflix_titles$release_year > 2016 & netflix_titles == c('Movie','TV Show'),'show_id']    )


#3. Filter movies by India and United Kingdom 
netflix_titles_wihout_null_values= filter(netflix_titles,!is.na(country))

Movies_in_IN_and_UK= netflix_titles_wihout_null_values[netflix_titles_wihout_null_values$country=='India' | netflix_titles_wihout_null_values$country=='United Kingdom',]

#4 merge these two data set and remove blank cells

summary(netflix_titles)
netflix_titles_wihout_null_values= filter(netflix_titles,!is.na(country))
  
  
netflix_master_data = merge( x= netflix_titles,    y= netflix_description,    by ='show_id')





### Hands-on practice in Data structures in R
#---------------------------------------------#
##-------------- Vector-----------------------#

#1. Create a vector V with numeric values


#2. Adding each element in vector V with 10



#3. Subtracting each element in vector V with 1



#4. Performing square root operation on each element in vector V



#5. Extract the values 2.1 and 3.3 from the vector x<-c(2.1,4.2,3.3,5.4)

#6. Arrange x in ascending order and descending order


#7. What is the result of x[c(2.1,2.9)]



#8. What is the result of x[-c(3,1)]



#9. What is the output of x[]


###-------------------------------------------------------###

###------------------Matrix------------------------------###

# 1. Create a matrix x with 9 integers of no of rows is 3 and give colnames
#as A,B,C
# What is the output of x[1:2,]
# Select rows 1 & 2 and columns 2 & 3 from the matrix x
# Select all rows except first 

?matrix()
x_matrix=matrix(1:9,nrow=3,ncol=3, byrow=TRUE)
colnames(x_matrix)= c("A","B","C")
rownames(x_matrix)= c("R1","R2","R3")
x_matrix

x_matrix[1:2,]
x_matrix[1:2,c(1,3)]
x_matrix[1:2,1:3]

x_matrix[-1,]
#-----------------------------------------------------##
# 2. Create three vectors x,y,z with integers and each vector has 3 elements. 
# Combine the three vectors to become a 3×3 matrix A where each column 
# represents a vector. Change the row names to a,b,c.
x_1 = 1:3
y_1 = 4:6
z_1 = 7:9

A= cbind(x_1,y_1,z_1)
typeof(A)
class(A)

new_matrix= matrix(c(x_1,y_1,z_1),nrow = 3, ncol= 3,byrow= TRUE)
rownames(new_matrix) = c("A","B","C")
class(new_matrix)


###-------------------------------##\
# Create a vector with 12 integers. Convert the vector to a 4*3 matrix
# B using matrix().  change the column names to x, y, z 
# and row names to a, b, c, d.The argument byrow in matrix() is
# set to be FALSE by default. Please change it to TRUE and print B to
# see the differences.

new_vector = 1:12
new_matrix = matrix(new_vector,nrow=4, ncol=3, byrow=TRUE)
rownames(new_matrix) = c("a",'b','c','d')
colnames(new_matrix) = c ('x','y','z')

new_matrix = matrix(new_vector,nrow=4, ncol=3,dimnames = list(c("a",'b','c','d'),c ('x','y','z')), byrow=TRUE)
new_matrix

##obtain the transpose matrix of B named tB.

1/(new_matrix)
transpose_matrix= t(new_matrix)
transpose_matrix


###-----------------------------------------------------##
##------------- Array----------------------------------##
# Create an array of 25 elements by using array()

array_new = array(1:25,c(2,4,3))

array_new
# Assign dim names by using dimnames()

dimnames(array_new)= list(c('a','b'),c('u','v','w','x'),c('p','q','r'))

array_new[ , , 'r']

###-----------------------------------------------###
##----------------List---------------------------###
# Create a list x from the given two vector objects p and q
# p <- c(2,7,8),q <- c("A", "B", "C")
# And find the value of x[2]

p <- c(2,7,8);q <- c("A", "B", "C")
x=list(p,q)

x[[2]][1]
x[[c(2,1)]]

#---------------------------------------------#
#If a <- list ("x"=5, "y"=10, "z"=15), which R statement will 
#give the sum of all elements in a?
a <- list ("x"=5, "y"=10, "z"=15)
sum(as.numeric(a))
sum(unlist(a))

#--------------------------------------------#
# If Newlist <- list(a=1:10, b="Good morning", c="Hi"), write an R statement
# that will add 1 to each element of the first vector in Newlist

Newlist <- list(a=1:10, b="Good morning", c="Hi")

Newlist$a+1


#-------------------------------------------#
# If b <- list(a=1:10, c="Hello", d="AA"), write an R expression that
# will give all elements, except the second, of the first vector of b.

b <- list(a=1:10, c="Hello", d="AA")
b$a[-2]

#-----------------------------------------#
# Let x <- list(a=5:10, c="Hello", d="AA"), write an R statement 
# to add a new item z = "NewItem" to the list x.

x <- list(a=5:10, c="Hello", d="AA")
x$z[3] = 'NewItem'
x

#---------------------------------------#
##---------------DataFrame--------------#



# Add this data frame column-wise to the previous one.
# a)How many rows and columns does the new data frame have?
#   b)What class of data is in each column?


age=c(25,31,23)
height = c(177,163,190)
weight=c(57,69,83)
gender= c ('F','F','M')
data_frame=data.frame(age,height,weight,gender)
dim(data_frame)
str(data_frame)
summary.data.frame(data_frame)
  
#--------------------------------------------#
# Create a simple data frame from 3 vectors. 
# Order the entire data frame by the first column.
 
##------------------------------------------#

library(dplyr)


data_frame_sorted= arrange(data_frame,age)
data_frame_sorted

data_frame_sorted= data_frame[order(data_frame$age),]
data_frame_sorted



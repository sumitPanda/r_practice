#opening the fie and setting the wokring directory. 

getwd()
setwd("D:\\My Drive\\IPBA course\\R and Data Viz\\Data Processing and Data Visualization - Pre class Video Datasets\\Introduction to R")


#some of the important commands: Run the current line CTRL+Enter
# ctrl+shift+enter : Run all the lines
# CTRL+ Alt+B : Run from beginng till the current line, were the cursor is.
# CTRL+ ALT + E : From the current line to the end. 

a = 'A'
typeof(a)

b <- 'B'
typeof(b)


'C'-> c
typeof(c)

class(c)
length(c)
attributes(c)

x3=c('a','b','c')

typeof(x3)
class(x3)
length(x3)
attributes(x3)


x=as.integer()


x <- c(10.4, 5.6, 3.1, 6.4, 21.7)

y <- c(x, 0, x)
y


v <- (2*x)+y+1



# Goals: A first look at R objects - vectors, lists, matrices, data frames.

# To make vectors "x" "y" "year" and "names"
x <- c(2,3,7,9)
y <- c(9,7,3,2)
year <- 1990:1993
names <- c("payal", "shraddha", "kritika", "itida")
# Accessing the 1st and last elements of y --
y[1]
y[length(y)]

# To make a list "person" --
person <- list(name="payal", x=2, y=9, year=1990)
person
# Accessing things inside a list --
person$name
person$x

# To make a matrix, pasting together the columns "year" "x" and "y"
# The verb cbind() stands for "column bind"
cbind(year, x, y)

# To make a "data frame", which is a list of vectors of the same length --
D <- data.frame(names, year, x, y)
nrow(D)
# Accessing one of these vectors
D$names
# Accessing the last element of this vector
D$names[nrow(D)]
# Or equally,
D$names[length(D$names)]




n<-10 
n

m<- 1:15
2*m-1
seq_var=seq(-1,1,0.3)
seq_var

rep_var= rep(seq_var,2)
rep_var



0/0
?Quotes

labs <- paste(c("X","Y"), 1:9, sep="")
labs


x <- c('A',1,10.4, 5.6, 3.1, 6.4, 21.7,-1)
class(as.numeric(x[2]))
y <- x[!is.na(x)]
y
(x+1)[(!is.na(x)) & x>0] -> z
z

x[1:10]
c("x",'y')[rep(c(1,2,2,1),4)]



fruit <- c(5, 10, 1, 20)
fruit
names(fruit) <- c("orange", "banana", "apple", "peach")
names(fruit)
lunch <- fruit[c("apple","orange")]
lunch


1:15 + 6:10


y=1:9
y
class(y)
dim(y)=c(3,3)
class(y)
y
typeof(y)



my_array=array(1:500,dim=c(4,5,6))
class(my_array)
my_array


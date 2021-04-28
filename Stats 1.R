##Probability distributions##
#Two types of functions : Density and Cumulative
# Density functions are like excel functions where we provide FALSE as the input to cumulative
# Cumulative functions in R, akin to excel's functions when cumulative parameter is TRUE

## Binomial distribution ##
# Density function #
# dbinom(number of success,number of trials, prob of success)

# P(X=3), X-> # heads in a toss of 10 coins
dbinom(3,10,0.5) #binom.dist(3,10,0.5,false)

# P(X=1,2,3,4,5,6,7,8,9,10), X-> # heads in a toss of 10 coins
dbinom(1:10,10,0.5) # supply number of success as a vector

# Cummulative probability function
#pbinom(number of successes, number of trails,prob success)

#P(X<=3),X-> # heads in a toss of 10 coins
pbinom(3,10,0.5) #excel binom.dist(3,10,0.5,true)

#P(X<=1,2,3,4,5,6,7,8,9,10), X-> # heads in a toss of 10 coins
pbinom(1:10,10,0.5) # supply number of success as a vector


## Negative Binomial Distribution ##

#dnbinom(num_f,num_s,prob_s)
#P(x=2), X-> Number of heads, P(2nd head occurs in 5th trial)
dnbinom(3,2,0.5) #excel negbinom.dist(3,2,0.5,false)

#P(Upto 2 heads occur in 5th trial)
#pnbinom(num_f,num_s,prob_s)
pnbinom(3,2,0.5)  #excel negbinom.dist(3,2,0.5,true)

## Hypergeometric Distribution
#dhyper(sample_s,pop_s,pop_f,sample_size)

#P(2 red when 5 cards are drawn at random from a deck without replacement)
dhyper(2,26,26,5) #excel hypgeom.dist(2,5,26,52,false)

#P(upto 2 red when 5 cards are drawn at random from a deck without replacement)
#phyper(sample_s,pop_s,pop_f,sample_size)
phyper(2,26,26,5) #excel hypgeom.dist(2,5,26,52,true)

##Poisson Distribution##
#dpois(x,mean)
#P(X=4|Mean=6), X->observed rate
dpois(4,6) #excel poisson.dist(4,6,false)

#ppois(x,mean)
#P(X<=4|Mean=6),  X->observed rate
ppois(4,6) #excel poisson.dist(4,6,true)


##Normal Distribution##
#P(X<=1.65)
pnorm(1.65,0,1) #excel, norm.dist(1.65,0,1,true)


##############################################################################################################################################################
# t distribution
#P(t<=x)
pt(1.65,29)

# We take a sample of 28 items the sample mean is 30, sample sd = 5, the sample comes from a population whose mean is 35, what are the chances we'll observe a sample mean of atmost 30?

#P(X<=30) 

# t value corresponding to 30 = (30-35)/(5/sqrt(28))
# t value = -5.291503

#P(X<=30) => P(t<=-5.291503)
#options(scipen=999)
pt(-5.291503,27) #excel, t.dist(-5.291503,27,true)

## t tests ##
# Single sample t tests
# Create a vector of data
set.seed(100)
x<-rnorm(16,2,1) #Data series of 16 points with mean 2 and sd 1
mean(x)
# H0: Mean = 2
# Ha: Mean < 2
t.test(x,alternative = "less",mu = 2)

# H0: Mean = 2
# Ha: Mean Not equal to 2
t.test(x,alternative="two.sided" ,mu = 2)

#Two sample t-tests#
#Independent Sample Test
#Create two random samples
set.seed(100)
x1<-rnorm(20,2,1)
x2<-rnorm(20,3,1.5)
mean(x1)
mean(x2)
#Ho: Mean1 = Mean2 (Mean difference is zero)
#Ha: Mean1 and Mean2 are different
t.test(x1,x2,alternative = "two.sided",mu = 0)

#Paired sample
#Ho: Mean1 = Mean2 (Mean difference is zero)
#Ha: Mean1 and Mean2 are different
t.test(x1,x2,alternative = "two.sided",mu = 0,paired = TRUE)

############################################################################################################################################################

## ANOVA ##

#One way ANOVA#

#Create a data set with three groups
mpg = c(34,35,34.3,35.5,35.8,35.3,36.5,36.4,37,37.6,33.3,34,34.7,33,34.9)
brand = factor(c("A","A","A","A","A","B","B","B","B","B","C","C","C","C","C"))
mileage = data.frame(mpg = mpg,brand = brand)
mileage

anova<-aov(mpg~brand,data = mileage )

summary(anova)

#Two way ANOVA#
setwd("E:\\Work\\Jigsaw Academy\\Data Scientist Course\\Data Science Redo\\Stats")
tw<-read.csv("TW.csv")
res<-aov(Satisfaction~Format+Subject+Format:Subject,data=tw)
summary(res)

#Chi-Square test of goodness of fit#
#Create a data set with observations and expectations#
Obs=c(195,165,47,15,30,35,8,5)
pct=c(0.374,0.357,0.085,0.034,0.066,0.063,0.015,0.006)
dat<-data.frame(Blood_type=c("O+","A+","B+","AB+","O-","A-","B-","AB-"),pct,Obs,Exp=sum(Obs)*pct)

chisq.test(x = dat$Obs,p=dat$pct)

#Chi-Square test of factor independence#
Monthly<- c(91,150,109)
Occasionally<-c(90,200,198)
Never<-c(51,155,172)
dat<-data.frame(Monthly,Occasionally,Never)
row.names(dat)<-c("under 45","45-59","60 and over")
dat

chisq.test(dat)

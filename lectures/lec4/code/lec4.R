#### QTM 220 Lecture 4 R code ####

library(foreign)
library(ggplot2)
setwd("~/Documents") #different for each user

### Turnout Stuff ###

# Generate Population Data
N = 7233584

b0 = floor(.7*N)
b1 = ceiling(.3*N)
y0 = rbinom(n=b0,size=1,prob=.68)
y1 = rbinom(n=b1,size=1,prob=.74)
y = c(y0,y1)
x = c(rep(0,b0),rep(1,b1))
dfpop = data.frame(y,x)
mean(dfpop$y)
mean(dfpop$y[dfpop$x==1])

# Generate Sample Data
set.seed(111)
ind = sample(1:N,size=625,replace=T)
dfsam = dfpop[ind,]
mean(dfsam$y)
mean(dfsam$y[dfsam$x==1])
mean(dfsam$y[dfsam$x==0])

# Generate Sampling Distribution
S = 10000
subpopMean = rep(NA,S)
for( s in 1:S ){
	ind = sample(1:N,size=625,replace=T)
	dfind = dfpop[ind,]
	subpopMean[s] = mean(dfind$y[dfind$x==1])	
}
hist(subpopMean)

B = 10000
bootMean = rep(NA,B)
for( b in 1:B ){
bootind = sample(1:625,size=625,replace=T)
dfboot = dfsam[bootind,]
bootMean[b] = mean(dfboot$y[dfboot$x==1])
}
hist(bootMean)
quantile(bootMean,prob =c(.025,.975))


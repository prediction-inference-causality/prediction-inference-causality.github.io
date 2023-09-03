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
mean(dfsam$x)
mean(dfsam$y[dfsam$x==1]) -
mean(dfsam$y[dfsam$x==0])
mean(dfsam$x)

# Generate Sampling Distribution
S = 10000
subsamMean = rep(NA,S)
diffMean = rep(NA,S)
for( s in 1:S ){
	ind = sample(1:N,size=625,replace=T)
	dfind = dfpop[ind,]
	subsamMean[s] = mean(dfind$y[dfind$x==1])
	diffMean[s] = mean(dfind$y[dfind$x==1])-mean(dfind$y[dfind$x==0])	
}
pdf("GitHub/qtm220/lectures/lec4/figs/samdistSub.pdf")
hist(subsamMean,main="Sampling Distribution of Subsample Mean")
dev.off()

pdf("GitHub/qtm220/lectures/lec4/figs/samdistDiff.pdf")
hist(diffMean,main="Sampling Distribution of Difference")
dev.off()


B = 10000
bootsubsamMean = rep(NA,B)
bootdiffsamMean = rep(NA,B)
for( b in 1:B ){
bootind = sample(1:625,size=625,replace=T)
dfboot = dfsam[bootind,]
bootsubsamMean[b] = mean(dfboot$y[dfboot$x==1])
bootdiffsamMean[b] = mean(dfboot$y[dfboot$x==1]) - mean(dfboot$y[dfboot$x==0])
}

pdf("GitHub/qtm220/lectures/lec4/figs/bootdistSub.pdf")
hist(bootsubsamMean,main="Bootstrapped Sampling Distribution of Subsample Mean")
dev.off()

pdf("GitHub/qtm220/lectures/lec4/figs/bootdistDiff.pdf")
hist(bootdiffsamMean,main="Bootstrapped Sampling Distribution of Difference")
dev.off()


pdf("GitHub/qtm220/lectures/lec4/figs/bootdistvssamdistSub.pdf")
par(mfrow=c(2,1))
hist(subsamMean,xlim=c(.60,.85),main="Sampling Distribution of Subsample Mean")
hist(bootsubsamMean,xlim=c(.60,.85),main="Bootstrapped Sampling Distribution of Subsample Mean")
dev.off()

pdf("GitHub/qtm220/lectures/lec4/figs/bootdistvssamdistDiff.pdf")
par(mfrow=c(2,1))
hist(diffMean,xlim=c(-.10,.25),main="Sampling Distribution of Difference")
hist(bootdiffsamMean,xlim=c(-.10,.25),main="Bootstrapped Sampling Distribution of Difference")
dev.off()

quantile(bootsubsamMean,prob =c(.025,.975))
quantile(bootdiffsamMean,prob =c(.025,.975))


#### QTM 220 Lecture 3 R code ####

library(foreign)
library(ggplot2)
library(boot)
setwd("~/Documents") #different for each user
	
### cps stuff ###

cps <- read.csv("GitHub/qtm220/lectures/lec2/data/allstates_employment.csv")       

cpsLec3 <- subset(cps,state.code==6&age>24&age <36&education >8)
n = dim(cpsLec3)[1]

# bootstrap distribution for sample mean
pdf("GitHub/qtm220/lectures/lec3/figs/bootdist.pdf")
B=10000
y.bar <- rep(NA,B)
for(b in 1:B){
	y.bar[b]= mean(sample(cpsLec3$income,size=n,replace=T))	
}
hist(y.bar)
dev.off()

# boot CI
quantile(y.bar,probs=c(.025,.975))

# Plug-in CI
mean(cpsLec3$income)- 1.96*sd(cpsLec3$income)/sqrt(2258)
mean(cpsLec3$income)+ 1.96*sd(cpsLec3$income)/sqrt(2258)

# bootstrap distribution for estimated se
pdf("GitHub/qtm220/lectures/lec3/figs/bootse.pdf")
B=10000
theta <- rep(NA,B)
for(b in 1:B){
	theta[b]= sd(sample(cpsLec3$income,size=n,replace=T))	
}
hist(theta/sqrt(n),main="",xlab="")
dev.off()








temp.hist <- hist(y.bar,col="blue",yaxt="n",main=expression(paste("Bootstrapped Sampling Distribution of ",bar(Y)[2258])),xlab=expression(bar(y)[2258]),ylab=expression(paste(f[bar(Y)[2258]],"(",bar(y)[2258],")")))
#axis(2,at=seq(0,35000,5000),labels=seq(0,35000,5000)/S)
#segments(x0=quantile(y.bar,probs=c(.025,.975)),y0=0,y1=15000,col="red",lwd=2)
#segments(x0=.70,y0=-4000,y1=50000,col="blue",lwd=2)
#segments(x0=.68,y0=-4000,y1=25000,col="green",lwd=2)
indmin <- max(which(temp.hist$breaks <= quantile(y.bar,probs=.025)))
indmax <- min(which(temp.hist$breaks >= quantile(y.bar,probs=.975)))
xx <- temp.hist$mids[indmin:indmax]
yy <- temp.hist$counts[indmin:indmax]
xx <- xx[yy > 0]
yy <- yy[yy > 0]
polygon(x=c(xx,rev(xx)),y=c(rep(0,length(yy)),rev(yy)),col=rgb(1,0,0,.45),border=NA)    
text(x=.70,y=-1500,"Middle 95%",col="red")
#segments(x0=.71,x1=.71+.036,y0=-3000,col="red",lwd=2)
#text(x=.71 + .036/2,y=-5000,"Margin-of-Error",col="red")
legend("topleft",legend=c("Population Proportion","Sample Proportion"),col=c("blue","green"),lwd=2)
dev.off()

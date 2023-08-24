#### QTM 220 Lecture 4 R code ####

library(foreign)
library(ggplot2)
setwd("~/Documents") #different for each user

### Turnout Stuff ###

pdf("GitHub/qtm220/lectures/lec4/figs/samdist.pdf")
S <-1000000
y.bar <- rbinom(n=S,size=625,prob=.70)/625
temp.hist <- hist(y.bar,breaks=seq(.6,.8,.0005),col="blue",yaxt="n",ylim=c(-5000,40000),main=expression(paste("Sampling Distribution of ",bar(Y)[625])),xlab=expression(bar(y)[625]),ylab=expression(paste(f[bar(Y)[625]],"(",bar(y)[625],")")))
axis(2,at=seq(0,35000,5000),labels=seq(0,35000,5000)/S)
#segments(x0=quantile(y.bar,probs=c(.025,.975)),y0=0,y1=15000,col="red",lwd=2)
segments(x0=.70,y0=-4000,y1=50000,col="blue",lwd=2)
segments(x0=.68,y0=-4000,y1=25000,col="green",lwd=2)
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


pdf("GitHub/qtm220/lectures/lec2/figs/estsamdist.pdf")
par(mfrow=c(2,1))
S <-1000000
y.bar <- rbinom(n=S,size=625,prob=.68)/625
temp.hist <- hist(y.bar,breaks=seq(.55,.85,.0005),col="green",yaxt="n",ylim=c(-7000,40000),main=expression(paste("Estimated Sampling Distribution of ",bar(Y)[625])),xlab=expression(bar(y)[625]),ylab=expression(paste(hat(f)[bar(Y)[625]],"(",bar(y)[625],")")))
axis(2,at=seq(0,35000,5000),labels=seq(0,35000,5000)/S)
segments(x0=.68,y0=-4000,y1=50000,col="green",lwd=2)
indmin <- max(which(temp.hist$breaks <= quantile(y.bar,probs=.025)))
indmax <- min(which(temp.hist$breaks >= quantile(y.bar,probs=.975)))
xx <- temp.hist$mids[indmin:indmax]
yy <- temp.hist$counts[indmin:indmax]
xx <- xx[yy > 0]
yy <- yy[yy > 0]
polygon(x=c(xx,rev(xx)),y=c(rep(0,length(yy)),rev(yy)),col=rgb(0,1,0,.35),border=NA)    
lb <- quantile(y.bar,probs=.025)
ub <- quantile(y.bar,probs=.975)
#segments(x0=.68,x1=ub,y0=-3000,col="green",lwd=2)
text(x=.68 ,y=-5000,"Middle 95%",col="green")
legend("topleft",legend=c("Sample Proportion"),col=c("green"),lwd=2)
S <-1000000
y.bar <- rbinom(n=S,size=625,prob=.7)/625
temp.hist <- hist(y.bar,breaks=seq(.55,.85,.0005),col="blue",yaxt="n",ylim=c(-7000,40000),main=expression(paste("Sampling Distribution of ",bar(Y)[625])),xlab=expression(bar(y)[625]),ylab=expression(paste(f[bar(Y)[625]],"(",bar(y)[625],")")))
axis(2,at=seq(0,35000,5000),labels=seq(0,35000,5000)/S)
#segments(x0=quantile(y.bar,probs=c(.025,.975)),y0=0,y1=15000,col="red",lwd=2)
segments(x0=.70,y0=-4000,y1=50000,col="blue",lwd=2)
segments(x0=.68,y0=-4000,y1=25000,col="green",lwd=2)
indmin <- max(which(temp.hist$breaks <= quantile(y.bar,probs=.025)))
indmax <- min(which(temp.hist$breaks >= quantile(y.bar,probs=.975)))
xx <- temp.hist$mids[indmin:indmax]
yy <- temp.hist$counts[indmin:indmax]
xx <- xx[yy > 0]
yy <- yy[yy > 0]
polygon(x=c(xx,rev(xx)),y=c(rep(0,length(yy)),rev(yy)),col=rgb(1,0,0,.35),border=NA)    
#text(x=.7075,y=-1500,"Middle 95%",col="red")
segments(x0=lb,x1=ub,y0=-3000,col="green",lwd=2)
text(x=.68,y=-5000,"Confidence Interval",col="green")
legend("topleft",legend=c("Population Proportion","Sample Proportion"),col=c("blue","green"),lwd=2)
dev.off()

pdf("GitHub/qtm220/lectures/lec2/figs/samdistCI.pdf")
par(mfrow=c(2,1))
S <-1000000
y.bar <- rbinom(n=S,size=625,prob=.7)/625
temp.hist <- hist(y.bar,breaks=seq(.55,.85,.0005),col="blue",yaxt="n",ylim=c(-7000,40000),main=expression(paste("Sampling Distribution of ",bar(Y)[625])),xlab=expression(bar(y)[625]),ylab=expression(paste(f[bar(Y)[625]],"(",bar(y)[625],")")))
axis(2,at=seq(0,35000,5000),labels=seq(0,35000,5000)/S)
#segments(x0=quantile(y.bar,probs=c(.025,.975)),y0=0,y1=15000,col="red",lwd=2)
segments(x0=.7,y0=-4000,y1=50000,col="blue",lwd=2)
segments(x0=.68,y0=-4000,y1=25000,col="green",lwd=2)
indmin <- max(which(temp.hist$breaks <= quantile(y.bar,probs=.025)))
indmax <- min(which(temp.hist$breaks >= quantile(y.bar,probs=.975)))
xx <- temp.hist$mids[indmin:indmax]
yy <- temp.hist$counts[indmin:indmax]
xx <- xx[yy > 0]
yy <- yy[yy > 0]
polygon(x=c(xx,rev(xx)),y=c(rep(0,length(yy)),rev(yy)),col=rgb(1,0,0,.35),border=NA)    
#text(x=.7075,y=-1500,"Middle 95%",col="red")

segments(x0=.68-.037,x1=.68+.037,y0=-3000,col="green",lwd=2)
#text(x=.68,y=-5000,"95% Confidence Interval",col="green")
legend("topleft",legend=c("Population Proportion","Sample Proportion"),col=c("blue","green"),lwd=2)
S <-1000000
y.bar <- rbinom(n=S,size=625,prob=.7)/625
temp.hist <- hist(y.bar,breaks=seq(.55,.85,.0005),col="blue",yaxt="n",ylim=c(-7000,40000),main=expression(paste("Sampling Distribution of ",bar(Y)[625])),xlab=expression(bar(y)[625]),ylab=expression(paste(f[bar(Y)[625]],"(",bar(y)[625],")")))
axis(2,at=seq(0,35000,5000),labels=seq(0,35000,5000)/S)
#segments(x0=quantile(y.bar,probs=c(.025,.975)),y0=0,y1=15000,col="red",lwd=2)
segments(x0=.7,y0=-4000,y1=50000,col="blue",lwd=2)
segments(x0=.75,y0=-4000,y1=25000,col="green",lwd=2)
indmin <- max(which(temp.hist$breaks <= quantile(y.bar,probs=.025)))
indmax <- min(which(temp.hist$breaks >= quantile(y.bar,probs=.975)))
xx <- temp.hist$mids[indmin:indmax]
yy <- temp.hist$counts[indmin:indmax]
xx <- xx[yy > 0]
yy <- yy[yy > 0]
polygon(x=c(xx,rev(xx)),y=c(rep(0,length(yy)),rev(yy)),col=rgb(1,0,0,.35),border=NA)    
#text(x=.7075,y=-1500,"Middle 95%",col="red")
segments(x0=.75-.037,x1=.75+.037,y0=-3000,col="green",lwd=2)
#text(x=.75,y=-5000,"95% Confidence Interval",col="green")
legend("topleft",legend=c("Population Proportion","Sample Proportion"),col=c("blue","green"),lwd=2)
dev.off()

	
### cps stuff ###

cps <- read.csv("GitHub/qtm220/lectures/lec2/data/allstates_employment.csv")       

cpsLec2 <- subset(cps,state.code==6&age>24&age <36&education >8)
dim(cpsLec2)
head(cpsLec2)

pdf("GitHub/qtm220/lectures/lec2/figs/CLhist.pdf")
hist(CLlib,freq=FALSE,col="blue",xlab="% Support for Liberal Position on Civil Liberties Cases (CLlib)")
lines(density(CLlib),col="red",lwd=2)
rug(CLlib,lwd=1.5)
dev.off()

pdf("GitHub/qtm220/lectures/lec1/figs/CLhistAct.pdf")
hist(CLlib,freq=FALSE,col="blue",xlab="% Support for Liberal Position on Civil Liberties Cases (CLlib)")
lines(density(CLlib),col="red",lwd=2)
dev.off()


pdf("GitHub/qtm220/lectures/lec1/figs/CLhistActSol.pdf")
hist(CLlib,freq=FALSE,col="blue",ylim=c(-.002,.025),xlab="% Support for Liberal Position on Civil Liberties Cases (CLlib)")
lines(density(CLlib),col="red",lwd=2)
points(x=mean(CLlib),y=-.0015,pch=2,cex=3,lwd=2,col="red")
points(x=median(CLlib),y=-.0015,pch="|",cex=3,lwd=2,col="red")
dev.off()

pdf("GitHub/qtm220/lectures/lec1/figs/CLhistMSD.pdf")
hist(CLlib,freq=FALSE,col="blue",ylim=c(-.002,.025),xlab="% Support for Liberal Position on Civil Liberties Cases (CLlib)")
lines(density(CLlib),col="red",lwd=2)
points(x=mean(CLlib),y=-.0015,pch=2,cex=3,lwd=2,col="red")
points(x=mean(CLlib)-sd(CLlib),y=-.0015,pch="[",cex=2,lwd=2,col="red")
points(x=mean(CLlib)+sd(CLlib),y=-.0015,pch="]",cex=2,lwd=2,col="red")
dev.off()

### Least Squares Derivation Plots ###

## Sample Average ##

y <- CLlib
mu.tilde <- seq(0,100,.5)
S <- function(mu.tilde,y){
	sum((y-mu.tilde)^2)
	}
S.mu.tilde <- rep(0,length(mu.tilde))
for(i in 1:length(mu.tilde)){
	S.mu.tilde[i] <- S(mu.tilde[i],y)
	}

pdf("GitHub/qtm220/lectures/lec1/figs/objectiveFunction1.pdf")
plot(mu.tilde,S.mu.tilde,type="l",lwd=2,col="red",xlab= expression(tilde(m)),ylab=expression(paste("S(",tilde(m),")")),main="Sum of Squared Residuals")
dev.off()

S1 <- function(mu.tilde,y){
	sum(-2*y + 2*mu.tilde)
	}

pdf("GitHub/qtm220/lectures/lec1/figs/objectiveFunction2.pdf")
plot(mu.tilde,S.mu.tilde,type="l",lwd=2,col="red",xlab= expression(tilde(m)),ylab=expression(paste("S(",tilde(m),")")),main="Sum of Squared Residuals")
abline(a=S(mu.tilde=20,y=y) - 20*S1(mu.tilde=20,y=y),b=S1(mu.tilde=20,y=y),lwd=2,col="blue")
text(x=20,y=10010,labels="|",col="blue",cex=2)
dev.off()

pdf("GitHub/qtm220/lectures/lec1/figs/objectiveFunction3.pdf")
plot(mu.tilde,S.mu.tilde,type="l",lwd=2,col="red",xlab= expression(tilde(m)),ylab=expression(paste("S(",tilde(m),")")),main="Sum of Squared Residuals")
abline(a=S(mu.tilde=35,y=y) - 35*S1(mu.tilde=35,y=y),b=S1(mu.tilde=35,y=y),lwd=2,col="blue")
text(x=35,y=10010,labels="|",col="blue",cex=2)
dev.off()

pdf("GitHub/qtm220/lectures/lec1/figs/objectiveFunction4.pdf")
plot(mu.tilde,S.mu.tilde,type="l",lwd=2,col="red",xlab= expression(tilde(m)),ylab=expression(paste("S(",tilde(m),")")),main="Sum of Squared Residuals")
abline(a=S(mu.tilde=mean(CLlib),y=y) - mean(CLlib)*S1(mu.tilde=mean(CLlib),y=y),b=S1(mu.tilde=mean(CLlib),y=y),lwd=2,col="blue")
text(x=mean(CLlib),y=10010,labels="|",col="blue",cex=2)
dev.off()

# Chebyshev

pdf("GitHub/qtm220/lectures/lec1/figs/Chebyshev.pdf")
hist(CLlib,freq=FALSE,col="blue",ylim=c(-.002,.025),xlab="% Support for Liberal Position on Civil Liberties Cases (CLlib)",xlim=c(0,100),main="At most 25% outside of 2 SDs")
lines(density(CLlib),col="red",lwd=2)
points(x=mean(CLlib),y=-.0015,pch=2,cex=3,lwd=2,col="red")
points(x=mean(CLlib)-2*sd(CLlib),y=-.0015,pch="[",cex=2,lwd=2,col="red")
points(x=mean(CLlib)+2*sd(CLlib),y=-.0015,pch="]",cex=2,lwd=2,col="red")
dev.off()


# Conditional Means

pdf("GitHub/qtm220/lectures/lec1/figs/CLhistMeanMed.pdf")
hist(CLlib,freq=FALSE,col="blue",ylim=c(-.002,.025),xlab="% Support for Liberal Position on Civil Liberties Cases (CLlib)")
points(x=mean(CLlib),y=-.0015,pch=2,cex=3,lwd=2,col="red")
points(x=median(CLlib),y=-.0015,pch="|",cex=3,lwd=2,col="red")
dev.off()

pdf("GitHub/qtm220/lectures/lec1/figs/CLhistCond.pdf")
par(mfrow=c(2,1))
hist(CLlib[party==0],freq=FALSE,col="blue",xlim=c(0,100),ylim=c(-.002,.025),xlab="% Support for Liberal Position on Civil Liberties Cases (CLlib)")
points(x=mean(CLlib[party==0]),y=-.0015,pch=2,cex=3,lwd=2,col="red")
points(x=median(CLlib[party==0]),y=-.0015,pch="|",cex=3,lwd=2,col="red")
hist(CLlib[party==1],freq=FALSE,col="blue",xlim=c(0,100),ylim=c(-.002,.025),xlab="% Support for Liberal Position on Civil Liberties Cases (CLlib)")
points(x=mean(CLlib[party==1]),y=-.0015,pch=2,cex=3,lwd=2,col="red")
points(x=median(CLlib[party==1]),y=-.0015,pch="|",cex=3,lwd=2,col="red")
dev.off()

png("GitHub/qtm220/lectures/lec1/figs/partyMean.png")
plot(party,CLlib, xaxt="n",xlab="Party of Appointing President",ylab="% Support for Liberal Position on Civil Liberties Cases (CLlib)")
axis(side=1, at=c(0,1), labels=c("Rep","Dem"))
points(c(0+.02,1+.02),tapply(CLlib,party,mean),pch=-9668,col="red",cex=1.25)
dev.off()

png("GitHub/qtm220/lectures/lec1/figs/lmBin.png")
plot(party,CLlib,xlab="Party of Appointing President",ylab="% Support for Liberal Position on Civil Liberties Cases (CLlib)")
points(c(0+.02,1+.02),tapply(CLlib,party,mean),pch=-9668,col="red",cex=1.25)
abline(lm(CLlib~party),col="red",lwd=2)
dev.off()

png("GitHub/qtm220/lectures/lec1/figs/lmBinSD.png")
plot(party,CLlib,xlab="Party of Appointing President",ylab="% Support for Liberal Position on Civil Liberties Cases (CLlib)")
points(c(0+.02,1+.02),tapply(CLlib,party,mean),pch=-9668,col="red",cex=1.25)
abline(lm(CLlib~party),col="red",lwd=2)
text(x=0,y=mean(CLlib[party==0])+sd(CLlib[party==0]),labels="]",cex=2,col="red",srt=90)
text(x=0,y=mean(CLlib[party==0])-sd(CLlib[party==0]),labels="]",cex=2,col="red",srt=-90)
text(x=1,y=mean(CLlib[party==1])+sd(CLlib[party==1]),labels="]",cex=2,col="red",srt=90)
text(x=1,y=mean(CLlib[party==1])-sd(CLlib[party==1]),labels="]",cex=2,col="red",srt=-90)
dev.off()

png("GitHub/qtm220/lectures/lec1/figs/BinlmBin.png")
plot(party,ur,xlab="Party of Appointing President",ylab="Underrepresented Groups (Ur)")
points(c(0+.02,1+.02),tapply(ur,party,mean),pch=-9668,col="red",cex=1.25)
abline(lm(ur~party),col="red",lwd=2)
dev.off()

png("GitHub/qtm220/lectures/lec1/figs/jitterBinlmBin.png")
plot(jitter(party,.05),jitter(ur,.05),xlab="Party of Appointing President",ylab="Underrepresented Groups (Ur)")
points(c(0+.02,1+.02),tapply(ur,party,mean),pch=-9668,col="red",cex=1.25)
abline(lm(ur~party),col="red",lwd=2)
dev.off()

png("GitHub/qtm220/lectures/lec1/figs/BinlmBinSD.png")
plot(jitter(party,.05),jitter(ur,.05),xlab="Party of Appointing President",ylab="Underrepresented Groups (Ur)")
points(c(0+.02,1+.02),tapply(ur,party,mean),pch=-9668,col="red",cex=1.25)
abline(lm(ur~party),col="red",lwd=2)
text(x=0,y=mean(ur[party==0])+sd(ur[party==0]),labels="]",cex=2,col="red",srt=90)
text(x=0,y=mean(ur[party==0])-sd(ur[party==0]),labels="]",cex=2,col="red",srt=-90)
text(x=1,y=mean(ur[party==1])+sd(ur[party==1]),labels="]",cex=2,col="red",srt=90)
text(x=1,y=mean(ur[party==1])-sd(ur[party==1]),labels="]",cex=2,col="red",srt=-90)
dev.off()

#### QTM 220 Lecture 2 R code ####

library(foreign)
library(ggplot2)
setwd("~/Documents") #different for each user

cps <- read.csv("GitHub/qtm220/lectures/lec2/data/CPS.csv")       



attach(EMdata)

pdf("GitHub/qtm220/lectures/lec1/figs/CLhist.pdf")
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

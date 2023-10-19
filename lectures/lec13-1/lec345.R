#### Lecture 2 R code ####
## The usual warning applies.##
library(gplots)
library(scatterplot3d)
library(rgl)
library(foreign)

EMdata <- read.table(file="EpstMershData.txt",    
                     header=TRUE)       
EMdata <- na.omit(EMdata)

# 1 Dem, 0 Rep
EMdata$party <- c(1,1,1,1,1,1,1,1,
0,0,0,0,0,
1,1,1,1,
0,0,0,0,0,0,0,0,0,0)

# 1 underrepresented group, 0 otherwise
EMdata$ur <- c(rep(0,16),1,rep(0,5),1,rep(0,3),1)

attach(EMdata)
write.csv(EMdata,file="EMdata.csv")
head(EMdata)


n <- 1000
x <- rnorm(n)
y <- x^2 + rnorm(n)

CVdata <- data.frame(y,x)

write.csv(CVdata,file="CVdata.csv")

lmSqErr <- rep(NA,n)
QuadSqErr <- rep(NA,n)
CubeSqErr <- rep(NA,n)
for(i in 1:n){
	lmSqErr[i] <- (CVdata[i,1] -  predict(lm(y~x,CVdata[-i,]),newdata=CVdata[i,]))^2
	QuadSqErr[i] <- (CVdata[i,1] -  predict(lm(y~x+I(x^2),CVdata[-i,]),newdata=CVdata[i,]))^2
	CubeSqErr[i] <- (CVdata[i,1] -  predict(lm(y~x+I(x^2)+I(x^3),CVdata[-i,]),newdata=CVdata[i,]))^2
}

mean(lmSqErr)
mean(QuadSqErr)
mean(CubeSqErr)




pdf("CLhist.pdf")
hist(CLlib,freq=FALSE,col="blue",xlab="% Support for Liberal Position on Civil Liberties Cases (CLlib)")
lines(density(CLlib),col="red",lwd=2)
rug(CLlib,lwd=1.5)
dev.off()

pdf("CLhistAct.pdf")
hist(CLlib,freq=FALSE,col="blue",xlab="% Support for Liberal Position on Civil Liberties Cases (CLlib)")
lines(density(CLlib),col="red",lwd=2)
dev.off()


pdf("CLhistActSol.pdf")
hist(CLlib,freq=FALSE,col="blue",ylim=c(-.002,.025),xlab="% Support for Liberal Position on Civil Liberties Cases (CLlib)")
lines(density(CLlib),col="red",lwd=2)
points(x=mean(CLlib),y=-.0015,pch=2,cex=3,lwd=2,col="red")
points(x=median(CLlib),y=-.0015,pch="|",cex=3,lwd=2,col="red")
dev.off()

pdf("CLhistMSD.pdf")
hist(CLlib,freq=FALSE,col="blue",ylim=c(-.002,.025),xlab="% Support for Liberal Position on Civil Liberties Cases (CLlib)")
lines(density(CLlib),col="red",lwd=2)
points(x=mean(CLlib),y=-.0015,pch=2,cex=3,lwd=2,col="red")
points(x=mean(CLlib)+c(-1,1)*sd(CLlib),y=rep(-.0015,2),pch="|",cex=2,lwd=2,col="red")
dev.off()


h2d <- hist2d(SCscore,CLlib,show=FALSE,nbins=c(6,4))

persp(h2d$x,h2d$y,h2d$counts,ticktype="detailed",theta=0,phi=50,expand=.5,shade=.5,col="cyan", ltheta=-60,xlab="Segal/Cover Score",ylab="% Support for Liberal Position on Civil Liberties Cases (CLlib)",zlab="Frequency")

pdf("scat2d.pdf")
plot(SCscore,CLlib,xlab="Segal/Cover Score",ylab="% Support for Liberal Position on Civil Liberties Cases (CLlib)")
dev.off()

pdf("hist2d.pdf")
persp(h2d$x,h2d$y,h2d$counts,ticktype="detailed",theta=0,phi=50,expand=.5,shade=.5,col="cyan", ltheta=-60,xlab="Segal/Cover Score",ylab="% Support for Liberal Position on Civil Liberties Cases (CLlib)",zlab="Frequency")
dev.off()


pdf("scat3d.pdf")
s3d <- scatterplot3d(SCscore, Judlib, CLlib,xlab="Segal/Cover Score",ylab="% Support for Liberal Position on Judicial Power Cases (Judlib)",zlab="% Support for Liberal Position on Civil Liberties Cases (CLlib)")
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

pdf("objectiveFunction1.pdf")
plot(mu.tilde,S.mu.tilde,type="l",lwd=2,col="red",xlab= expression(tilde(m)),ylab=expression(paste("S(",tilde(m),")")),main="Sum of Squared Residuals")
dev.off()

S1 <- function(mu.tilde,y){
	sum(-2*y + 2*mu.tilde)
	}

pdf("objectiveFunction2.pdf")
plot(mu.tilde,S.mu.tilde,type="l",lwd=2,col="red",xlab= expression(tilde(m)),ylab=expression(paste("S(",tilde(m),")")),main="Sum of Squared Residuals")
abline(a=S(mu.tilde=20,y=y) - 20*S1(mu.tilde=20,y=y),b=S1(mu.tilde=20,y=y),lwd=2,col="blue")
text(x=20,y=10010,labels="|",col="blue",cex=2)
dev.off()

pdf("objectiveFunction3.pdf")
plot(mu.tilde,S.mu.tilde,type="l",lwd=2,col="red",xlab= expression(tilde(m)),ylab=expression(paste("S(",tilde(m),")")),main="Sum of Squared Residuals")
abline(a=S(mu.tilde=35,y=y) - 35*S1(mu.tilde=35,y=y),b=S1(mu.tilde=35,y=y),lwd=2,col="blue")
text(x=35,y=10010,labels="|",col="blue",cex=2)
dev.off()

pdf("objectiveFunction4.pdf")
plot(mu.tilde,S.mu.tilde,type="l",lwd=2,col="red",xlab= expression(tilde(m)),ylab=expression(paste("S(",tilde(m),")")),main="Sum of Squared Residuals")
abline(a=S(mu.tilde=mean(CLlib),y=y) - mean(CLlib)*S1(mu.tilde=mean(CLlib),y=y),b=S1(mu.tilde=mean(CLlib),y=y),lwd=2,col="blue")
text(x=mean(CLlib),y=10010,labels="|",col="blue",cex=2)
dev.off()

# Conditional Means

pdf("partyMean.pdf")
plot(party,CLlib, xaxt="n",xlab="Party of Appointing President",ylab="% Support for Liberal Position on Civil Liberties Cases (CLlib)")
axis(side=1, at=c(0,1), labels=c("Rep","Dem"))
points(c(0,1),tapply(CLlib,party,mean),pch="-",col="red",cex=4)
dev.off()

pdf("lmBin.pdf")
plot(party,CLlib,xlab="Party of Appointing President",ylab="% Support for Liberal Position on Civil Liberties Cases (CLlib)")
points(c(0,1),tapply(CLlib,party,mean),pch="-",col="red",cex=4)
abline(lm(CLlib~party),col="red",lwd=2)
dev.off()




n <- length(CLlib)
mod <- lm(CLlib~SCscore)
mod2 <- lm(CLlib~SCscore+I(SCscore^2))
loess.cl1 <- loess(CLlib~SCscore, data=EMdata, degree=1, span=0.95)
loess.cl2 <- loess(CLlib~SCscore, data=EMdata, degree=1, span=0.65)
loess.cl3 <- loess(CLlib~SCscore, data=EMdata, degree=1, span=0.45)
loess.cl4 <- loess(CLlib~SCscore, data=EMdata, degree=2, span=0.95)
loess.cl5 <- loess(CLlib~SCscore, data=EMdata, degree=2, span=0.65)
loess.cl6 <- loess(CLlib~SCscore, data=EMdata, degree=2, span=0.45)
cor(CLlib,SCscore)
cor(CLlib,SCscore)^2
mod$coef[2]
cor(CLlib,SCscore)*(sd(CLlib)/sd(SCscore))



lines(0:100/100, predict(loess.cl4, newdata=0:100/100), col="red", lwd=2)
lines(0:100/100, predict(loess.cl5, newdata=0:100/100), col="blue", lwd=2)
lines(0:100/100, predict(loess.cl6, newdata=0:100/100), col="black", lwd=2)

pdf(file="justicePlot1.pdf",bg="white")
plot(x=SCscore,y=CLlib,type="n",xlab="Segal/Cover Score",ylab="% Support for Liberal Position on Civil Liberties Cases",xlim=c(-.1,1.1))
text(x=SCscore,y=CLlib,labels=Justice)
dev.off()

pdf(file="justicePlot2.pdf",bg="white")
plot(x=SCscore,y=CLlib,type="n",xlab="Segal/Cover Score",ylab="% Support for Liberal Position on Civil Liberties Cases",xlim=c(-.1,1.1))
text(x=SCscore,y=CLlib,labels=Justice)
lines(0:100/100, predict(loess.cl6, newdata=0:100/100), col="black", lwd=2)
dev.off()


pdf(file="justicePlot3.pdf",bg="white")
plot(x=SCscore,y=CLlib,type="n",xlab="Segal/Cover Score",ylab="% Support for Liberal Position on Civil Liberties Cases",xlim=c(-.1,1.1))
text(x=SCscore,y=CLlib,labels=Justice)
abline(a=mean(CLlib) - sd(CLlib)/sd(SCscore)*mean(SCscore),b=sd(CLlib)/sd(SCscore),col="green",lwd=2)
dev.off()

pdf(file="justicePlot4.pdf",bg="white")
plot(x=SCscore,y=CLlib,type="n",xlab="Segal/Cover Score",ylab="% Support for Liberal Position on Civil Liberties Cases",xlim=c(-.1,1.1))
text(x=SCscore,y=CLlib,labels=Justice)
#abline(a=mean(CLlib) - sd(CLlib)/sd(SCscore)*mean(SCscore),b=sd(CLlib)/sd(SCscore),col="green",lwd=2)
lines(0:100/100, predict(loess.cl6, newdata=0:100/100), col="black", lwd=2)
abline(mod,col="red",lwd=2)
dev.off()




pdf(file="justicePlot.pdf",bg="white")
plot(x=SCscore,y=CLlib,type="n")
text(x=SCscore,y=CLlib,labels=Justice)
abline(mod,col="red")
abline(a=mean(CLlib) - sd(CLlib)/sd(SCscore)*mean(SCscore),b=sd(CLlib)/sd(SCscore),col="green")
dev.off()

pdf(file="fitted.pdf",bg="white")
plot(x=SCscore,y=CLlib,type="n",xlab="Segal/Cover Score",ylab="% Support for Liberal Position on Civil Liberties Cases",xlim=c(-.1,1.1))
text(x=SCscore,y=CLlib,labels=Justice)
abline(mod,col="red",lwd=2)
segments(x0=SCscore,y0=predict(mod)-2,x1=SCscore,y1=predict(mod)+2,col="red")
dev.off()

pdf(file="fitted2.pdf",bg="white")
plot(x=SCscore,y=CLlib,type="n",xlab="Segal/Cover Score",ylab="% Support for Liberal Position on Civil Liberties Cases",xlim=c(-.1,1.1))
text(x=SCscore,y=CLlib,labels=Justice)
abline(mod,col="red",lwd=2)
segments(x0=SCscore,y0=predict(mod)-2,x1=SCscore,y1=predict(mod)+2,col="red")
segments(x0=-1,y0=predict(mod),x1=SCscore,y1=predict(mod),col="red")
dev.off()

pdf(file="residuals.pdf",bg="white")
plot(x=SCscore,y=CLlib,type="n",xlab="Segal/Cover Score",ylab="% Support for Liberal Position on Civil Liberties Cases",xlim=c(-.1,1.1))
text(x=SCscore,y=CLlib,labels=Justice)
abline(mod,col="red",lwd=2)
segments(x0=SCscore,y0=CLlib,x1=SCscore,y1=predict(mod),col="green")
dev.off()

pdf("simRegAct.pdf")
xx <- rnorm(1000)
yy <- .5*xx + rnorm(1000)
plot(xx,yy,xlab="x",ylab="y")
dev.off()

pdf("simRegActSol.pdf")
plot(xx,yy,xlab="x",ylab="y")
abline(lm(yy~xx))
abline(a=mean(yy) - sd(yy)/sd(xx)*mean(xx),b=sd(yy)/sd(xx))
dev.off()

pdf(file="lmPlot.pdf",bg="white")
plot(x=SCscore,y=CLlib,type="n",xlab="Segal/Cover Score",ylab="% Support for Liberal Position on Civil Liberties Cases",xlim=c(-.1,1.1))
text(x=SCscore,y=CLlib,labels=Justice)
abline(mod,col="red",lwd=2)
segments(x0=-1,x1=0,y0=27.56,col="red",lwd=2)
segments(x0=0,y0=27.56,y1=27.56+43.15,col="red",lwd=2)
segments(x0=0,x1=1,y0=27.56+43.15,col="red",lwd=2)
text(x=-.08,y=30, expression(paste(B[0],"=27")),col="red",cex=1.25)
text(x=-.08,y=50,expression(paste(B[1],"=43")),col="red",cex=1.25)
dev.off()

pdf(file="QuadLmPlot.pdf",bg="white")
plot(x=SCscore,y=CLlib,type="n",xlab="Segal/Cover Score",ylab="% Support for Liberal Position on Civil Liberties Cases",xlim=c(-.1,1.1))
text(x=SCscore,y=CLlib,labels=Justice)
abline(mod,col="red",lwd=2)
lines(0:100/100, 30.30 + 26.52*(0:100/100) + 15.85*(0:100/100)^2, col="green", lwd=2)
dev.off()

pdf(file="LoessPlot.pdf",bg="white")
plot(x=SCscore,y=CLlib,type="n",xlab="Segal/Cover Score",ylab="% Support for Liberal Position on Civil Liberties Cases",xlim=c(-.1,1.1))
text(x=SCscore,y=CLlib,labels=Justice)
abline(mod,col="red",lwd=2)
lines(0:100/100, 30.30 + 26.52*(0:100/100) + 15.85*(0:100/100)^2, col="green", lwd=2)
lines(0:100/100, predict(loess.cl5, newdata=0:100/100), col="blue", lwd=2)
lines(0:100/100, predict(loess.cl6, newdata=0:100/100), col="black", lwd=2)
dev.off()




## Simple OLS ##

residFunc <- function(a,b,y,x){
	sq.resid <- (y - (a + b*x))^2
	return(sum( sq.resid ))
	}

residFunc(a=27.56,b=43.15,y=CLlib,x=SCscore)

residFunc(a=28,b=43.15,y=CLlib,x=SCscore)
residFunc(a=27.56,b=43,y=CLlib,x=SCscore)


a.seq <- seq(25,30,.1)
b.seq <- seq(40,45,.1)
SSEmat <- matrix(0,nr=length(a.seq),nc=length(b.seq))
for(i in 1:length(a.seq)){
	for(j in 1:length(b.seq)){
		SSEmat[i,j] <- residFunc(a=a.seq[i],b=b.seq[j],y=CLlib,x=SCscore)
		}
	}

#par(mar=c(1,1,1,1))
pdf("OLSobjectiveFunction1.pdf")
image(a.seq,b.seq,SSEmat,xlab=expression(tilde(beta)[0]),ylab=expression(tilde(beta)[1]),labcex=1.5,main = "Sum of Squared Residuals")
contour(a.seq,b.seq,SSEmat,add=TRUE)
dev.off()

pdf("OLSobjectiveFunction2.pdf")
persp(a.seq,b.seq,SSEmat,theta=0,phi=40,col="lightblue",shade=.3,border=NA,zlab="SSR",xlab="beta0",ylab="beta1")
dev.off()

pdf("OLSobjectiveFunction3.pdf")
image(a.seq,b.seq,SSEmat,xlab=expression(tilde(beta)[0]),ylab=expression(tilde(beta)[1]),labcex=1.5)
contour(a.seq,b.seq,SSEmat,add=TRUE)
points(x=27.56,y=43.15,col="blue")
abline(v=27.56,col="blue")
abline(h=43.15,col="blue")
dev.off()

### Goodness of Fit ###

pdf(file="R2Plot.pdf",bg="white")
plot(x=SCscore,y=CLlib,type="n")
text(x=SCscore,y=CLlib,labels=Justice)
abline(mod,col="red",lwd=2)
abline(h=mean(CLlib),col="green",lwd=2)
dev.off()


### Comparing CL and Fed ###



pdf(file="residuals1.pdf",bg="white")
plot(x=SCscore,y=CLlib,type="n",xlab="Segal/Cover Score",ylab="% Support for Liberal Position on Civil Liberties Cases",xlim=c(-.1,1.1),ylim=c(0,100),main="Civil Liberties (R^2 = 45%)")
text(x=SCscore,y=CLlib,labels=Justice)
abline(mod,col="red",lwd=2)
segments(x0=SCscore,y0=CLlib,x1=SCscore,y1=predict(mod),col="green")
dev.off()

pdf(file="residuals2.pdf",bg="white")
plot(x=SCscore,y=Fedlib,type="n",xlab="Segal/Cover Score",ylab="% Support for Liberal Position on Federalism Cases",xlim=c(-.1,1.1),ylim=c(0,100),main="Federalism")
text(x=SCscore,y=Fedlib,labels=Justice)
abline(lm(Fedlib~SCscore),col="red",lwd=2)
segments(x0=SCscore,y0=Fedlib,x1=SCscore,y1=predict(lm(Fedlib~SCscore)),col="green")
dev.off()

pdf(file="residuals3.pdf",bg="white")
plot(x=SCscore,y=Judlib,type="n",xlab="Segal/Cover Score",ylab="% Support for Liberal Position on Judicial Power Cases",xlim=c(-.1,1.1),ylim=c(0,100),main="Judicial Power (R^2 = 7%)")
text(x=SCscore,y=Judlib,labels=Justice)
abline(lm(Judlib~SCscore),col="red",lwd=2)
segments(x0=SCscore,y0=Judlib,x1=SCscore,y1=predict(lm(Judlib~SCscore)),col="green")
dev.off()


plot(gam(Judlib~s(SCscore)))

summary(lm(Fedlib~SCscore))

summary(lm(Judlib~SCscore))
summary(lm(Judlib~SCscore+ I(SCscore^2)))


anscombe2 <- anscombe
anscombe2$y1[3] <- 8.5
anscombe2$y1[10] <- 6
anscombe2$x3[3] <- 10


pdf("AnscombeQ1.pdf")
op <- par(las=1, mfrow=c(2,2), mar=1.5+c(4,4,1,1), oma=c(0,0,0,0),
           lab=c(6,6,7), cex.lab=2.0, cex.axis=1.3, mgp=c(3,1,0))
 ff <- y ~ x
 for(i in 1:4) {
   ff[[2]] <- as.name(paste("y", i, sep=""))
   ff[[3]] <- as.name(paste("x", i, sep=""))
   lmi <- lm(ff, data= anscombe)
   xl <- substitute(expression(x[i]), list(i=i))  
   yl <- substitute(expression(y[i]), list(i=i))
      plot(ff, data=anscombe2, pch=19, cex=1.5, 
        xlim=c(3,19), ylim=c(3,13)
        , xlab=eval(xl), ylab=yl  # for version 3
       ) 
 }
 par(op)
 dev.off()

cor(anscombe2$x1,anscombe2$y1)
cor(anscombe2$x2,anscombe2$y2)

cor(anscombe2$x3,anscombe2$y3)
cor(anscombe2$x4,anscombe2$y4)


pdf("Anscombe.pdf")
op <- par(las=1, mfrow=c(2,2), mar=1.5+c(4,4,1,1), oma=c(0,0,0,0),
           lab=c(6,6,7), cex.lab=2.0, cex.axis=1.3, mgp=c(3,1,0))
 ff <- y ~ x
 for(i in 1:4) {
   ff[[2]] <- as.name(paste("y", i, sep=""))
   ff[[3]] <- as.name(paste("x", i, sep=""))
   lmi <- lm(ff, data= anscombe)
   xl <- substitute(expression(x[i]), list(i=i))  
   yl <- substitute(expression(y[i]), list(i=i))
      plot(ff, data=anscombe, pch=19, cex=1.5, 
        xlim=c(3,19), ylim=c(3,13)
        , xlab=eval(xl), ylab=yl  # for version 3
       ) 

 }
 par(op)
 dev.off()

 
pdf("AnscombeA.pdf")
op <- par(las=1, mfrow=c(2,2), mar=1.5+c(4,4,1,1), oma=c(0,0,0,0),
           lab=c(6,6,7), cex.lab=2.0, cex.axis=1.3, mgp=c(3,1,0))
 ff <- y ~ x
 for(i in 1:4) {
   ff[[2]] <- as.name(paste("y", i, sep=""))
   ff[[3]] <- as.name(paste("x", i, sep=""))
   lmi <- lm(ff, data= anscombe)
   xl <- substitute(expression(x[i]), list(i=i))  
   yl <- substitute(expression(y[i]), list(i=i))
   plot(ff, data=anscombe, col="red", pch=21, cex=2.4, bg = "orange", 
        xlim=c(3,19), ylim=c(3,13)
        , xlab=eval(xl), ylab=yl  # for version 3
      )  
   abline(lmi, col="red",lwd=2)
 }
 par(op)
 dev.off()

data(anscombe)

summary(anscombe)

## Multiple Regression ##
mod2 <- lm(CLlib~SCscore + party)
pdf("psc.pdf")
plot(SCscore,CLlib)
points(SCscore[party==0],CLlib[party==0],pch=19,col="red")
points(SCscore[party==1],CLlib[party==1],pch=19,col="blue")
legend("topleft",legend=c("Rep","Dem"),col=c("red","blue"),pch=19)
dev.off()

# 3D 

pdf("em3D1.pdf")
s3d <- scatterplot3d(SCscore, party, CLlib, color=party*2+2, angle=30, pch=20, zlim=c(0,100), cex.sym=1.2)
dev.off()

pdf("em3D2.pdf")
s3d <- scatterplot3d(SCscore, party, CLlib, color=party*2+2, angle=70, pch=20, zlim=c(0,100), cex.symb=1.2)
dev.off()


pdf("em3D3.pdf")
s3d <- scatterplot3d(party, SCscore, CLlib, color=party*2+2, angle=70, pch=20, zlim=c(0,100), cex.symb=1.2)
mod2a <- lm(CLlib ~ party + SCscore)
s3d$plane3d(mod2a, lty.box = "dashed", col="red")
dev.off()

pdf("em3D4.pdf")
s3d <- scatterplot3d(SCscore, Judlib,  CLlib, angle=70, pch=20, zlim=c(0,100), cex.symb=1.2)
mod3 <- lm(CLlib ~ SCscore + Judlib  )
s3d$plane3d(mod3, lty.box = "dashed", col="red")
dev.off()

n <- 1000
zz <- c(rep(0,n/2),rep(1,n/2))
xx <-  3 + rnorm(n)
yy <- 2*zz*xx - xx + rnorm(n)

pdf("multAct.pdf")
plot(xx,yy,xlab="x",ylab="y")
points(xx[zz==0],yy[zz==0],pch=19,col="red")
points(xx[zz==1],yy[zz==1],pch=19,col="blue")
legend("topleft",legend=c("z=0","z=1"),pch=19,col=c("red","blue"))
dev.off()

pdf("multActSol.pdf")
plot(xx,yy,xlab="x",ylab="y")
points(xx[zz==0],yy[zz==0],pch=19,col="red")
points(xx[zz==1],yy[zz==1],pch=19,col="blue")
legend("topleft",legend=c("z=0","z=1"),pch=19,col=c("red","blue"))
modAct <- lm(yy ~ xx + zz)
abline(a=modAct$coef[1],b=modAct$coef[2],col="red",lwd=2)
abline(a=modAct$coef[1]+modAct$coef[3],b=modAct$coef[2],col="blue",lwd=2)
abline(lm(yy[zz==0]~xx[zz==0]),col="red",lwd=2)
abline(lm(yy[zz==1]~xx[zz==1]),col="blue",lwd=2)
dev.off()


pdf("pscMarg.pdf")
plot(SCscore,CLlib)
points(SCscore[party==0],CLlib[party==0],pch=19,col="red")
points(SCscore[party==1],CLlib[party==1],pch=19,col="blue")
legend("topleft",legend=c("Rep","Dem"),col=c("red","blue"),pch=19)
mod2 <- lm(CLlib~SCscore + party)
abline(a=mod2$coef[1],b=mod2$coef[2],col="red",lwd=2)
abline(a=mod2$coef[1]+mod2$coef[3],b=mod2$coef[2],col="blue",lwd=2)
segments(x0=0,x1=-3,y0=mod2$coef[1],col="red",lwd=2)
segments
dev.off()

pdf("pscMarg2.pdf")
plot(SCscore,Fedlib,xlim=c(-.1,1.1))
points(SCscore[party==0],Fedlib[party==0],pch=19,col="red")
points(SCscore[party==1],Fedlib[party==1],pch=19,col="blue")
legend("topleft",legend=c("Rep","Dem"),col=c("red","blue"),pch=19)
mod2 <- lm(Fedlib~SCscore + party)
abline(a=mod2$coef[1],b=mod2$coef[2],col="red",lwd=2)
abline(a=mod2$coef[1]+mod2$coef[3],b=mod2$coef[2],col="blue",lwd=2)
dev.off()

pdf("pscMarg20.pdf")
plot(SCscore,Fedlib,xlim=c(-.1,1.1))
points(SCscore[party==0],Fedlib[party==0],pch=19,col="red")
points(SCscore[party==1],Fedlib[party==1],pch=19,col="blue")
legend("topleft",legend=c("Rep","Dem"),col=c("red","blue"),pch=19)
mod2 <- lm(Fedlib~SCscore + party)
abline(a=mod2$coef[1],b=mod2$coef[2],col="red",lwd=2)
abline(a=mod2$coef[1]+mod2$coef[3],b=mod2$coef[2],col="blue",lwd=2)
segments(x0=0,x1=-3,y0=mod2$coef[1],lwd=1.5,col="red")
text(x=-.07,y=mod2$coef[1]+1,expression(paste(B[0],"=55")),col="red")
dev.off()

pdf("pscMarg21.pdf")
plot(SCscore,Fedlib,xlim=c(-.1,1.1))
points(SCscore[party==0],Fedlib[party==0],pch=19,col="red")
points(SCscore[party==1],Fedlib[party==1],pch=19,col="blue")
legend("topleft",legend=c("Rep","Dem"),col=c("red","blue"),pch=19)
mod2 <- lm(Fedlib~SCscore + party)
abline(a=mod2$coef[1],b=mod2$coef[2],col="red",lwd=2)
abline(a=mod2$coef[1]+mod2$coef[3],b=mod2$coef[2],col="blue",lwd=2)
segments(x0=0,x1=-3,y0=mod2$coef[1],lwd=1.5,col="red")
text(x=-.07,y=mod2$coef[1]+1,expression(paste(B[0],"=55")),col="red")
segments(x0=0,y0=mod2$coef[1],y1=sum(mod2$coef[1:2]),lwd=1.5,col="red")
segments(x0=0,x1=1,y0=sum(mod2$coef[1:2]),lwd=1.5,col="red")
text(x=-.07,y=sum(mod2$coef[1:2])+1,expression(paste(B[1],"=9.6")),col="red")
dev.off()

pdf("pscMarg22.pdf")
plot(SCscore,Fedlib,xlim=c(-.1,1.1))
points(SCscore[party==0],Fedlib[party==0],pch=19,col="red")
points(SCscore[party==1],Fedlib[party==1],pch=19,col="blue")
legend("topleft",legend=c("Rep","Dem"),col=c("red","blue"),pch=19)
mod2 <- lm(Fedlib~SCscore + party)
abline(a=mod2$coef[1],b=mod2$coef[2],col="red",lwd=2)
abline(a=mod2$coef[1]+mod2$coef[3],b=mod2$coef[2],col="blue",lwd=2)
segments(x0=0,x1=-3,y0=mod2$coef[1],lwd=1.5,col="red")
text(x=-.07,y=mod2$coef[1]+1,expression(paste(B[0],"=55")),col="red")
segments(x0=0,y0=mod2$coef[1],y1=sum(mod2$coef[1:2]),lwd=1.5,col="red")
segments(x0=0,x1=1,y0=sum(mod2$coef[1:2]),lwd=1.5,col="red")
text(x=-.07,y=sum(mod2$coef[1:2])+1,expression(paste(B[1],"=9.6")),col="red")
segments(x0=0,y0=mod2$coef[1],y1=sum(mod2$coef[c(1,3)]),lwd=1.5,col="blue")
text(x=.07,y=sum(mod2$coef[c(1,3)])-1,expression(paste(B[2],"=-1.4")),col="blue")
dev.off()








pdf("pscInt.pdf")
plot(SCscore,Fedlib,xlim=c(-.15,1.15))
points(SCscore[party==0],Fedlib[party==0],pch=19,col="red")
points(SCscore[party==1],Fedlib[party==1],pch=19,col="blue")
legend("topleft",legend=c("Rep","Dem"),col=c("red","blue"),pch=19)
abline(lm(Fedlib[party==0]~SCscore[party==0]),lwd=2,col="red")
abline(lm(Fedlib[party==1]~SCscore[party==1]),lwd=2,col="blue")
dev.off()

pdf("pscInt0.pdf")
plot(SCscore,Fedlib,xlim=c(-.15,1.15))
points(SCscore[party==0],Fedlib[party==0],pch=19,col="red")
points(SCscore[party==1],Fedlib[party==1],pch=19,col="blue")
legend("topleft",legend=c("Rep","Dem"),col=c("red","blue"),pch=19)
abline(lm(Fedlib[party==0]~SCscore[party==0]),lwd=2,col="red")
abline(lm(Fedlib[party==1]~SCscore[party==1]),lwd=2,col="blue")
mod2 <- lm(Fedlib~SCscore * party)
segments(x0=0,x1=-3,y0=mod2$coef[1],lwd=1.5,col="red")
text(x=-.07,y=mod2$coef[1]+1,expression(paste(B[0],"=58")),col="red")
dev.off()

pdf("pscInt1.pdf")
plot(SCscore,Fedlib,xlim=c(-.15,1.15))
points(SCscore[party==0],Fedlib[party==0],pch=19,col="red")
points(SCscore[party==1],Fedlib[party==1],pch=19,col="blue")
legend("topleft",legend=c("Rep","Dem"),col=c("red","blue"),pch=19)
abline(lm(Fedlib[party==0]~SCscore[party==0]),lwd=2,col="red")
abline(lm(Fedlib[party==1]~SCscore[party==1]),lwd=2,col="blue")
mod2 <- lm(Fedlib~SCscore * party)
segments(x0=0,x1=-3,y0=mod2$coef[1],lwd=1.5,col="red")
text(x=-.07,y=mod2$coef[1]+1,expression(paste(B[0],"=58")),col="red")
segments(x0=0,y0=mod2$coef[1],y1=sum(mod2$coef[1:2]),lwd=1.5,col="red")
segments(x0=0,x1=1,y0=sum(mod2$coef[1:2]),lwd=1.5,col="red")
text(x=-.07,y=sum(mod2$coef[1:2])+.5,expression(paste(B[1],"=3.3")),col="red")
dev.off()

pdf("pscInt2.pdf")
plot(SCscore,Fedlib,xlim=c(-.15,1.15))
points(SCscore[party==0],Fedlib[party==0],pch=19,col="red")
points(SCscore[party==1],Fedlib[party==1],pch=19,col="blue")
legend("topleft",legend=c("Rep","Dem"),col=c("red","blue"),pch=19)
abline(lm(Fedlib[party==0]~SCscore[party==0]),lwd=2,col="red")
abline(lm(Fedlib[party==1]~SCscore[party==1]),lwd=2,col="blue")
mod2 <- lm(Fedlib~SCscore * party)
segments(x0=0,x1=-3,y0=mod2$coef[1],lwd=1.5,col="red")
text(x=-.07,y=mod2$coef[1]+1,expression(paste(B[0],"=58")),col="red")
segments(x0=0,y0=mod2$coef[1],y1=sum(mod2$coef[1:2]),lwd=1.5,col="red")
segments(x0=0,x1=1,y0=sum(mod2$coef[1:2]),lwd=1.5,col="red")
text(x=-.07,y=sum(mod2$coef[1:2])+.5,expression(paste(B[1],"=3.3")),col="red")
segments(x0=0,y0=mod2$coef[1],y1=sum(mod2$coef[c(1,3)]),lwd=1.5,col="blue")
text(x=-.07,y=sum(mod2$coef[c(1,3)]),expression(paste(B[2],"=-16")),col="blue")
dev.off()

pdf("pscInt3.pdf")
plot(SCscore,Fedlib,xlim=c(-.15,1.15))
points(SCscore[party==0],Fedlib[party==0],pch=19,col="red")
points(SCscore[party==1],Fedlib[party==1],pch=19,col="blue")
legend("topleft",legend=c("Rep","Dem"),col=c("red","blue"),pch=19)
abline(lm(Fedlib[party==0]~SCscore[party==0]),lwd=2,col="red")
abline(lm(Fedlib[party==1]~SCscore[party==1]),lwd=2,col="blue")
mod2 <- lm(Fedlib~SCscore * party)
segments(x0=0,x1=-3,y0=mod2$coef[1],lwd=1.5,col="red")
text(x=-.07,y=mod2$coef[1]+1,expression(paste(B[0],"=58")),col="red")
segments(x0=0,y0=mod2$coef[1],y1=sum(mod2$coef[1:2]),lwd=1.5,col="red")
segments(x0=0,x1=1,y0=sum(mod2$coef[1:2]),lwd=1.5,col="red")
text(x=-.07,y=sum(mod2$coef[1:2])+.5,expression(paste(B[1],"=3.3")),col="red")
segments(x0=0,y0=mod2$coef[1],y1=sum(mod2$coef[c(1,3)]),lwd=1.5,col="blue")
text(x=-.07,y=sum(mod2$coef[c(1,3)]),expression(paste(B[2],"=-16")),col="blue")
segments(x0=0,x1=1,y0=sum(mod2$coef[c(1,3)]),lwd=1.5,col="blue")
segments(x0=1,y0=sum(mod2$coef[c(1,3)]),y1=sum(mod2$coef[1:3]),lwd=1.5,col="red")
segments(x0=1,y0=sum(mod2$coef[1:3]),y1=sum(mod2$coef),lwd=1.5,col="blue")
text(x=1.07,y=sum(mod2$coef[1:3]),expression(paste(B[1],"=3.3")),col="red")
text(x=1.07,y=sum(mod2$coef)-.5,expression(paste(B[3],"=23")),col="blue")
dev.off()











scatterplot3d(SCscore,party,Fedlib,type="p",pch=20)
mod3a <- lm(Fedlib~ party * SCscore )
sc.sim <- seq(0,1,.01)
p.sim <- seq(0,1,.01)
f <- function(sc.sim,p.sim){
	coef(mod3a)[1]+sc.sim*coef(mod3a)[3] + p.sim*coef(mod3a)[2] + sc.sim*p.sim*coef(mod3a)[4]
	}
z<- outer(sc.sim,p.sim,f)

persp3d(x=sc.sim,y=p.sim,z,col="pink",add=TRUE,alpha=.5)




n <- 1000
zz <- c(rep(0,n/5),rep(1,4*n/5))
set.seed(123456)
xx <-  3 + 2*zz + rnorm(n,mean=0,sd = 1 - .5*zz)
yy <- zz*xx - xx + rnorm(n)

pdf("finalAct.pdf")
plot(xx,yy,xlab="x",ylab="y")
points(xx[zz==0],yy[zz==0],pch=19,col="red")
points(xx[zz==1],yy[zz==1],pch=19,col="blue")
legend("topleft",legend=c("z=0","z=1"),pch=19,col=c("red","blue"))
dev.off()

pdf("finalAct1.pdf")
plot(xx,yy,xlab="x",ylab="y")
points(xx[zz==0],yy[zz==0],pch=19,col="red")
points(xx[zz==1],yy[zz==1],pch=19,col="blue")
legend("topleft",legend=c("z=0","z=1"),pch=19,col=c("red","blue"))
modAct1 <- lm(yy ~ xx)
modAct2 <- lm(yy ~ xx + zz)
abline(modAct1,col="purple",lwd=2)
dev.off()

pdf("finalAct2.pdf")
plot(xx,yy,xlab="x",ylab="y")
points(xx[zz==0],yy[zz==0],pch=19,col="red")
points(xx[zz==1],yy[zz==1],pch=19,col="blue")
legend("topleft",legend=c("z=0","z=1"),pch=19,col=c("red","blue"))
modAct1 <- lm(yy ~ xx)
modAct2 <- lm(yy ~ xx + zz)
abline(modAct1,col="purple",lwd=2)
abline(a=modAct2$coef[1],b=modAct2$coef[2],col="red",lwd=2)
abline(a=modAct2$coef[1]+modAct2$coef[3],b=modAct2$coef[2],col="blue",lwd=2)
dev.off()

pdf("finalAct3.pdf")
plot(xx,yy,xlab="x",ylab="y")
points(xx[zz==0],yy[zz==0],pch=19,col="red")
points(xx[zz==1],yy[zz==1],pch=19,col="blue")
legend("topleft",legend=c("z=0","z=1"),pch=19,col=c("red","blue"))
modAct1 <- lm(yy ~ xx)
modAct2 <- lm(yy ~ xx + zz)
abline(modAct1,col="purple",lwd=2)
abline(a=modAct2$coef[1],b=modAct2$coef[2],col="red",lwd=2)
abline(a=modAct2$coef[1]+modAct2$coef[3],b=modAct2$coef[2],col="blue",lwd=2)
abline(lm(yy[zz==0]~xx[zz==0]),col="red",lwd=2)
abline(lm(yy[zz==1]~xx[zz==1]),col="blue",lwd=2)
dev.off()

pdf("finalAct4.pdf")
plot(xx,yy,xlab="x",ylab="y")
points(xx[zz==0],yy[zz==0],pch=19,col="red")
points(xx[zz==1],yy[zz==1],pch=19,col="blue")
legend("topleft",legend=c("z=0","z=1"),pch=19,col=c("red","blue"))
modAct1 <- lm(yy ~ xx)
modAct2 <- lm(yy ~ xx + zz)
abline(modAct1,col="purple",lwd=2)
abline(a=modAct2$coef[1],b=modAct2$coef[2],col="red",lwd=2)
abline(a=modAct2$coef[1]+modAct2$coef[3],b=modAct2$coef[2],col="blue",lwd=2)
abline(lm(yy[zz==0]~xx[zz==0]),col="red",lwd=2)
abline(lm(yy[zz==1]~xx[zz==1]),col="blue",lwd=2)
abline(a= 0,b=  (1/5)*lm(yy[zz==0]~xx[zz==0])$coef[2] + (4/5)*lm(yy[zz==1]~xx[zz==1])$coef[2],col="green",lwd=2)
dev.off()

pdf("finalActSyll.pdf")
plot(xx,yy,xlab="x",ylab="y")
points(xx[zz==0],yy[zz==0],pch=19,col="red")
points(xx[zz==1],yy[zz==1],pch=19,col="blue")
legend("topleft",legend=c("z=0","z=1"),pch=19,col=c("red","blue"))
modAct1 <- lm(yy ~ xx)
modAct2 <- lm(yy ~ xx + zz)
abline(modAct1,lwd=2)
abline(a=modAct2$coef[1],b=modAct2$coef[2],col="purple",lwd=2)
abline(a=modAct2$coef[1]+modAct2$coef[3],b=modAct2$coef[2],col="purple",lwd=2)
abline(lm(yy[zz==0]~xx[zz==0]),col="red",lwd=2)
abline(lm(yy[zz==1]~xx[zz==1]),col="blue",lwd=2)
dev.off()

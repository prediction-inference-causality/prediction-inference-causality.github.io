#### Lecture 6 R code ####
## The usual warning applies.##
library(gplots)
library(scatterplot3d)
library(rgl)



## Inference ##


EMdata <- read.table(file="EpstMershData.txt",    
                     header=TRUE)       
EMdata <- na.omit(EMdata)

# 1 Dem, 0 Rep
EMdata$party <- c(1,1,1,1,1,1,1,1,
0,0,0,0,0,
1,1,1,1,
0,0,0,0,0,0,0,0,0,0)

attach(EMdata)
head(EMdata)





pdf("partyMean.pdf")
plot(party,CLlib, xaxt="n",xlab="Party of Appointing President",ylab="% Support for Liberal Position on Civil Liberties Cases (CLlib)")
axis(side=1, at=c(0,1), labels=c("Rep","Dem"))
points(c(0,1),tapply(CLlib,party,mean),pch="-",col="blue",cex=4)
dev.off()

pdf("lmBin.pdf")
plot(party,CLlib,xlab="Party of Appointing President",ylab="% Support for Liberal Position on Civil Liberties Cases (CLlib)")
points(c(0,1),tapply(CLlib,party,mean),pch="-",col="blue",cex=4)
abline(lm(CLlib~party),col="blue",lwd=2)
dev.off()


pdf("BinLCEF.pdf")
plot(party,CLlib,xlab="Party of Appointing President",ylab="% Support for Liberal Position on Civil Liberties Cases (CLlib)",type="n")
points(c(0,1),tapply(CLlib,party,mean),pch="-",col="blue",cex=4)
abline(lm(CLlib~party),col="blue",lwd=2)
text(x=.1,y=40,expression(paste(beta[0]," = 44")),col="blue",cex=2)
text(x=.5,y=55,expression(paste(beta[1]," = 15")),col="blue",cex=2)
dev.off()

pdf("BinLCEFsam1.pdf")
plot(party,CLlib,xlab="Party of Appointing President",ylab="% Support for Liberal Position on Civil Liberties Cases (CLlib)",type="n")
points(c(0,1),tapply(CLlib,party,mean),pch="-",col="blue",cex=4)
abline(lm(CLlib~party),col="blue",lwd=2)
set.seed(1)
sam.ind <- sample(1:27,size=12,replace=TRUE)
points(CLlib[sam.ind]~party[sam.ind])
abline(lm(CLlib[sam.ind]~party[sam.ind]),col="red",lwd=1.5)
dev.off()

pdf("BinLCEFsam2.pdf")
plot(party,CLlib,xlab="Party of Appointing President",ylab="% Support for Liberal Position on Civil Liberties Cases (CLlib)",type="n")
points(c(0,1),tapply(CLlib,party,mean),pch="-",col="blue",cex=4)
abline(lm(CLlib~party),col="blue",lwd=2)
set.seed(2)
sam.ind <- sample(1:27,size=12,replace=TRUE)
points(CLlib[sam.ind]~party[sam.ind])
abline(lm(CLlib[sam.ind]~party[sam.ind]),col="red",lwd=1.5)
dev.off()

pdf("BinLCEFsam3.pdf")
plot(party,CLlib,xlab="Party of Appointing President",ylab="% Support for Liberal Position on Civil Liberties Cases (CLlib)",type="n")
points(c(0,1),tapply(CLlib,party,mean),pch="-",col="blue",cex=4)
abline(lm(CLlib~party),col="blue",lwd=2)
set.seed(3)
sam.ind <- sample(1:27,size=12,replace=TRUE)
points(CLlib[sam.ind]~party[sam.ind])
abline(lm(CLlib[sam.ind]~party[sam.ind]),col="red",lwd=1.5)
dev.off()


N <- length(CLlib)
n <- 12 

S <- 10000
b0b1.matrix <- matrix(0,nr=S,nc=2)
for(s in 1:S){
	sam.ind <- sample(1:27,size=12,replace=TRUE)
	b0b1.matrix[s,] <- lm(CLlib[sam.ind]~party[sam.ind])$coef
	}
lm(CLlib~party)$coef
mean(b0b1.matrix[,1],na.rm=TRUE)
mean(b0b1.matrix[,2],na.rm=TRUE)

apply(b0b1.matrix,2,mean,na.rm=TRUE)

sum(is.na(b0b1.matrix[,2]))

pdf("BinLCEFsamdist.pdf")
par(mfrow=c(1,3))
hist(b0b1.matrix[,1],main=expression(paste("Sampling Distribution of ",hat(beta)[0])),xlab=expression(hat(beta)[0]),col="red")
hist(b0b1.matrix[,2],main=expression(paste("Sampling Distribution of ",hat(beta)[1])),xlab=expression(hat(beta)[1]),col="red")
plot(b0b1.matrix[1:500,1],b0b1.matrix[1:500,2],xlab=expression(hat(beta)[0]),ylab=expression(hat(beta)[0]),main=expression(paste("Joint Distribution of ",hat(beta)[0])," and ",hat(beta)[1]),col="red")
dev.off()

pdf("BinLCEFbias1.pdf")
par(mfrow=c(1,2))
hist(b0b1.matrix[,1],main=expression(paste("Sampling Distribution of ",hat(beta)[0])),xlab=expression(hat(beta)[0]),col="red")
points(x=44,y=-75,pch=2,cex=1.8,lwd=2,col="blue")
hist(b0b1.matrix[,2],main=expression(paste("Sampling Distribution of ",hat(beta)[1])),xlab=expression(hat(beta)[1]),col="red")
points(x=15,y=-40,pch=2,cex=1.8,lwd=2,col="blue")
dev.off()

pdf("BinLCEFbias2.pdf")
par(mfrow=c(1,2))
hist(b0b1.matrix[,1],main=expression(paste("Sampling Distribution of ",hat(beta)[0])),xlab=expression(hat(beta)[0]),col="red")
points(x=44,y=-75,pch=2,cex=1.8,lwd=2,col="blue")
points(x=mean(b0b1.matrix[,1],na.rm=TRUE),y=-75,pch=2,cex=1.8,lwd=2,col="red")
hist(b0b1.matrix[,2],main=expression(paste("Sampling Distribution of ",hat(beta)[1])),xlab=expression(hat(beta)[1]),col="red")
points(x=15,y=-40,pch=2,cex=1.8,lwd=2,col="blue")
points(x=mean(b0b1.matrix[,2],na.rm=TRUE),y=-40,pch=2,cex=1.8,lwd=2,col="red")
dev.off()




## Continuous Covariate ##

pdf("lm.pdf")
plot(SCscore,CLlib,xlab="Segal/Cover Score",ylab="% Support for Liberal Position on Civil Liberties Cases (CLlib)")
abline(lm(CLlib~SCscore),col="blue",lwd=2)
dev.off()


pdf("LCEF.pdf")
plot(SCscore,CLlib,xlab="Segal/Cover Score",ylab="% Support for Liberal Position on Civil Liberties Cases (CLlib)",type="n")
abline(lm(CLlib~SCscore),col="blue",lwd=2)
text(x=.1,y=25,expression(paste(beta[0]," = 28")),col="blue",cex=2)
text(x=.5,y=55,expression(paste(beta[1]," = 43")),col="blue",cex=2)
dev.off()

pdf("LCEFsam1.pdf")
plot(SCscore,CLlib,xlab="Segal/Cover Score",ylab="% Support for Liberal Position on Civil Liberties Cases (CLlib)",type="n")
abline(lm(CLlib~SCscore),col="blue",lwd=2)
text(x=.1,y=25,expression(paste(beta[0]," = 28")),col="blue",cex=2)
text(x=.5,y=55,expression(paste(beta[1]," = 43")),col="blue",cex=2)
set.seed(1)
sam.ind <- sample(1:27,size=12,replace=TRUE)
points(CLlib[sam.ind]~SCscore[sam.ind])
abline(lm(CLlib[sam.ind]~SCscore[sam.ind]),col="red",lwd=1.5)
dev.off()

pdf("LCEFsam2.pdf")
plot(SCscore,CLlib,xlab="Segal/Cover Score",ylab="% Support for Liberal Position on Civil Liberties Cases (CLlib)",type="n")
abline(lm(CLlib~SCscore),col="blue",lwd=2)
text(x=.1,y=25,expression(paste(beta[0]," = 28")),col="blue",cex=2)
text(x=.5,y=55,expression(paste(beta[1]," = 43")),col="blue",cex=2)
set.seed(2)
sam.ind <- sample(1:27,size=12,replace=TRUE)
points(CLlib[sam.ind]~SCscore[sam.ind])
abline(lm(CLlib[sam.ind]~SCscore[sam.ind]),col="red",lwd=1.5)
dev.off()

pdf("LCEFsam3.pdf")
plot(SCscore,CLlib,xlab="Segal/Cover Score",ylab="% Support for Liberal Position on Civil Liberties Cases (CLlib)",type="n")
abline(lm(CLlib~SCscore),col="blue",lwd=2)
text(x=.1,y=25,expression(paste(beta[0]," = 28")),col="blue",cex=2)
text(x=.5,y=55,expression(paste(beta[1]," = 43")),col="blue",cex=2)
set.seed(3)
sam.ind <- sample(1:27,size=12,replace=TRUE)
points(CLlib[sam.ind]~SCscore[sam.ind])
abline(lm(CLlib[sam.ind]~SCscore[sam.ind]),col="red",lwd=1.5)
dev.off()


N <- length(CLlib)
n <- 12 

S <- 10000
cb0b1.matrix <- matrix(0,nr=S,nc=2)
for(s in 1:S){
	sam.ind <- sample(1:27,size=12,replace=TRUE)
	cb0b1.matrix[s,] <- lm(CLlib[sam.ind]~SCscore[sam.ind])$coef
	}
lm(CLlib~SCscore)$coef
mean(cb0b1.matrix[,1],na.rm=TRUE)
mean(cb0b1.matrix[,2],na.rm=TRUE)

apply(cb0b1.matrix,2,mean,na.rm=TRUE)

sum(is.na(cb0b1.matrix[,2]))

pdf("LCEFsamdist.pdf")
par(mfrow=c(1,3))
hist(cb0b1.matrix[,1],main=expression(paste("Sampling Distribution of ",hat(beta)[0])),xlab=expression(hat(beta)[0]),col="red")
hist(cb0b1.matrix[,2],main=expression(paste("Sampling Distribution of ",hat(beta)[1])),xlab=expression(hat(beta)[1]),col="red")
plot(cb0b1.matrix[1:500,1],cb0b1.matrix[1:500,2],xlab=expression(hat(beta)[0]),ylab=expression(hat(beta)[0]),main=expression(paste("Joint Distribution of ",hat(beta)[0])," and ",hat(beta)[1]),col="red")
dev.off()

pdf("LCEFbias1.pdf")
par(mfrow=c(1,2))
hist(cb0b1.matrix[,1],main=expression(paste("Sampling Distribution of ",hat(beta)[0])),xlab=expression(hat(beta)[0]),col="red")
points(x=27.5,y=-75,pch=2,cex=1.8,lwd=2,col="blue")
hist(cb0b1.matrix[,2],main=expression(paste("Sampling Distribution of ",hat(beta)[1])),xlab=expression(hat(beta)[1]),col="red")
points(x=43,y=-65,pch=2,cex=1.8,lwd=2,col="blue")
dev.off()

pdf("LCEFbias2.pdf")
par(mfrow=c(1,2))
hist(cb0b1.matrix[,1],main=expression(paste("Sampling Distribution of ",hat(beta)[0])),xlab=expression(hat(beta)[0]),col="red")
points(x=27.5,y=-75,pch=2,cex=1.8,lwd=2,col="blue")
points(x=mean(cb0b1.matrix[,1],na.rm=TRUE),y=-75,pch=2,cex=1.8,lwd=2,col="red")
hist(cb0b1.matrix[,2],main=expression(paste("Sampling Distribution of ",hat(beta)[1])),xlab=expression(hat(beta)[1]),col="red")
points(x=43,y=-65,pch=2,cex=1.8,lwd=2,col="blue")
points(x=mean(cb0b1.matrix[,2],na.rm=TRUE),y=-65,pch=2,cex=1.8,lwd=2,col="red")
dev.off()


pdf("popPlot.pdf")
plot(SCscore,CLlib,xlab="Segal/Cover Score",ylab="% Support for Liberal Position on Civil Liberties Cases (CLlib)")
dev.off()






#############



pdf("sam1.pdf")
plot(SCscore,CLlib,xlab="Segal/Cover Score",ylab="% Support for Liberal Position on Civil Liberties Cases (CLlib)",type="n")
set.seed(1)
sam.ind <- sample(1:27,size=12,replace=TRUE)
points(CLlib[sam.ind]~SCscore[sam.ind])
abline(lm(CLlib[sam.ind]~SCscore[sam.ind]),col="red",lwd=1.5)
dev.off()

summary(lm(CLlib[sam.ind]~SCscore[sam.ind]))

qt(p=.975,df=10)
confint(lm(CLlib[sam.ind]~SCscore[sam.ind]))



S <- 100
conf.int <- matrix(0,nr=S,nc=2)
for (s in 1:S){
	sam.ind <- sample(1:27,size=12,replace=TRUE)
	conf.int[s,] <- 
	confint(lm(CLlib[sam.ind]~SCscore[sam.ind]))[2,]
}

mean(conf.int[,1] < 43.15 & conf.int[,2] > 43.15 )

set.seed(1)
sam.ind <- sample(1:27,size=12,replace=TRUE)

summary(lm(CLlib~SCscore))

qt(p=.975,df=10)
confint(lm(CLlib~SCscore))



B <- 10000
b1.vec <- rep(NA,B)
for(b in 1:B){
	boot.ind <- sample(1:27,replace=TRUE)
	b1.vec[b] <- lm(CLlib[boot.ind]~SCscore[boot.ind])$coef[2]
}

summary(b1.vec)
quantile(b1.vec,probs=c(.025,.975))
sd(b1.vec)










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











plot3d(SCscore,party,Fedlib,type="p",pch=20)
mod3a <- lm(Fedlib~ party * SCscore )
sc.sim <- seq(0,1,.01)
p.sim <- seq(0,1,.01)
f <- function(sc.sim,p.sim){
	coef(mod3a)[1]+sc.sim*coef(mod3a)[3] + p.sim*coef(mod3a)[2] + sc.sim*p.sim*coef(mod3a)[4]
	}
z<- outer(sc.sim,p.sim,f)

persp3d(x=sc.sim,y=p.sim,z,col="pink",add=TRUE,alpha=.5)

n <- 1000
zz <- c(rep(0,n/2),rep(1,n/2))
xx <-  3 + 2*zz + rnorm(n)
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


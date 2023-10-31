

library(car)
library(foreign)
library(mgcv)
#library(KRLS)
netocox <- read.csv("netocox.csv")


netocox$enpres <- netocox$ENPRES 
netocox$eneth <- netocox$ENETH
netocox$ro <- netocox$RUNOFF 

attach(netocox)

country <- 	as.character(COUNTRY)
country[country=="EQUADOR"] <- "ECUADOR"

prox <- c(.55,
.8,
.63,
.93,
1,
1,
.64,
1,
.61,
.96,
.41,
.87,
1,
.05,
1,
1)

y1 <- c(expression(Y(1)[ARG]),
expression(Y(1)[AUS]),
expression(Y(1)[BRA]),
expression(Y(1)[COL]),
expression(Y(1)[CR]),
expression(Y(1)[DR]),
expression(Y(1)[ES]),
expression(Y(1)[ECU]),
expression(Y(1)[FIN]),
expression(Y(1)[FRA]),
expression(Y(1)[ICE]),
expression(Y(1)[KOR]),
expression(Y(1)[PERU]),
expression(Y(1)[POR]),
expression(Y(1)[USA]),
expression(Y(1)[VEN])
)

y0 <- c(expression(Y(0)[ARG]),
expression(Y(0)[AUS]),
expression(Y(0)[BRA]),
expression(Y(0)[COL]),
expression(Y(0)[CR]),
expression(Y(0)[DR]),
expression(Y(0)[ES]),
expression(Y(0)[ECU]),
expression(Y(0)[FIN]),
expression(Y(0)[FRA]),
expression(Y(0)[ICE]),
expression(Y(0)[KOR]),
expression(Y(0)[PERU]),
expression(Y(0)[POR]),
expression(Y(0)[USA]),
expression(Y(0)[VEN])
)

y1hat <- c(expression(hat(Y)(1)[ARG]),
expression(hat(Y)(1)[AUS]),
expression(hat(Y)(1)[BRA]),
expression(hat(Y)(1)[COL]),
expression(hat(Y)(1)[CR]),
expression(hat(Y)(1)[DR]),
expression(hat(Y)(1)[ES]),
expression(hat(Y)(1)[ECU]),
expression(hat(Y)(1)[FIN]),
expression(hat(Y)(1)[FRA]),
expression(hat(Y)(1)[ICE]),
expression(hat(Y)(1)[KOR]),
expression(hat(Y)(1)[PERU]),
expression(hat(Y)(1)[POR]),
expression(hat(Y)(1)[USA]),
expression(hat(Y)(1)[VEN])
)

y0hat <- c(expression(hat(Y)(0)[ARG]),
expression(hat(Y)(0)[AUS]),
expression(hat(Y)(0)[BRA]),
expression(hat(Y)(0)[COL]),
expression(hat(Y)(0)[CR]),
expression(hat(Y)(0)[DR]),
expression(hat(Y)(0)[ES]),
expression(hat(Y)(0)[ECU]),
expression(hat(Y)(0)[FIN]),
expression(hat(Y)(0)[FRA]),
expression(hat(Y)(0)[ICE]),
expression(hat(Y)(0)[KOR]),
expression(hat(Y)(0)[PERU]),
expression(hat(Y)(0)[POR]),
expression(hat(Y)(0)[USA]),
expression(hat(Y)(0)[VEN])
)


# Plot 1

pdf("p1.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=country[ro==0],col="red")
text(eneth[ro==1],enpres[ro==1],labels=country[ro==1],col="blue")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

pdf("p1a.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=country[ro==0],col="red")
#text(eneth[ro==1],enpres[ro==1],labels=country[ro==1],col="blue")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

pdf("p1b.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=y0[ro==0],col="red")
#text(eneth[ro==1],enpres[ro==1],labels=country[ro==1],col="blue")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

pdf("p1c.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=y0[ro==0],col="red")
text(eneth[ro==1],enpres[ro==1],labels=country[ro==1],col="blue")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

pdf("p1d.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=y0[ro==0],col="red")
text(eneth[ro==1],enpres[ro==1],labels=country[ro==1],col="blue")
mod <- lm(enpres ~ eneth*ro, data=netocox)
abline(mod$coef[1]+mod$coef[3],mod$coef[2]+mod$coef[4],col="blue",lwd=2)
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

pdf("p1e.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=y0[ro==0],col="red")
text(eneth[ro==1],enpres[ro==1],labels=country[ro==1],col="blue")
mod <- lm(enpres ~ eneth*ro, data=netocox)
abline(mod$coef[1]+mod$coef[3],mod$coef[2]+mod$coef[4],col="blue",lwd=2)
netocox1 <- netocox
netocox1$ro <- 1
text(eneth[ro==0],predict(mod,newdata=netocox1[ro==0,]),labels=y1hat[ro==0],col="red")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

pdf("p1f.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=y0[ro==0],col="red")
text(eneth[ro==1],enpres[ro==1],labels=country[ro==1],col="blue")
mod <- lm(enpres ~ eneth*ro, data=netocox)
abline(mod$coef[1]+mod$coef[3],mod$coef[2]+mod$coef[4],col="blue",lwd=2)
netocox1 <- netocox
netocox1$ro <- 1
text(eneth[ro==0],predict(mod,newdata=netocox1[ro==0,]),labels=y1hat[ro==0],col="red")
segments(x0=eneth[ro==0],y0=enpres[ro==0],y1=predict(mod,newdata=netocox1[ro==0,]),col="red")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

pdf("p1g.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=y0[ro==0],col="red")
mod <- lm(enpres ~ eneth*ro, data=netocox)
abline(mod$coef[1]+mod$coef[3],mod$coef[2]+mod$coef[4],col="blue",lwd=2)
netocox1 <- netocox
netocox1$ro <- 1
text(eneth[ro==0],predict(mod,newdata=netocox1[ro==0,]),labels=y1hat[ro==0],col="red")
segments(x0=eneth[ro==0],y0=enpres[ro==0],y1=predict(mod,newdata=netocox1[ro==0,]),col="red")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

pdf("p1h.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=y0[ro==0],col="red")
mod <- lm(enpres ~ eneth*ro, data=netocox)
abline(mod$coef[1]+mod$coef[3],mod$coef[2]+mod$coef[4],col="blue",lwd=2)
abline(mod$coef[1],mod$coef[2],col="red",lwd=2)
netocox1 <- netocox
netocox1$ro <- 1
text(eneth[ro==0],predict(mod,newdata=netocox1[ro==0,]),labels=y1hat[ro==0],col="red")
segments(x0=eneth[ro==0],y0=enpres[ro==0],y1=predict(mod,newdata=netocox1[ro==0,]),col="red")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

pdf("p1i.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=y0[ro==0],col="red")
mod <- lm(enpres ~ eneth*ro, data=netocox)
abline(mod$coef[1]+mod$coef[3],mod$coef[2]+mod$coef[4],col="blue",lwd=2)
abline(mod$coef[1],mod$coef[2],col="red",lwd=2)
netocox1 <- netocox
netocox1$ro <- 1
text(eneth[ro==0],predict(mod,newdata=netocox1[ro==0,]),labels=y1hat[ro==0],col="red")
segments(x0=eneth[ro==0],y0=predict(mod,newdata=netocox[ro==0,]),y1=predict(mod,newdata=netocox1[ro==0,]),col="red")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

# Plot 2

pdf("p2.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=country[ro==0],col="red")
text(eneth[ro==1],enpres[ro==1],labels=country[ro==1],col="blue")
mod <- lm(enpres ~ eneth+ro, data=netocox)
abline(mod$coef[1],mod$coef[2],col="red",lwd=2)
abline(mod$coef[1]+mod$coef[3],mod$coef[2],col="blue",lwd=2)
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
text(x=1.75,y=4.5,expression(paste(hat(beta),"=0.63")),cex=1.5,col="purple")
dev.off()

pdf("p2b.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=country[ro==0],col="red")
text(eneth[ro==1],enpres[ro==1],labels=country[ro==1],col="blue")
mod <- lm(enpres ~ eneth+ro, data=netocox)
abline(mod$coef[1],mod$coef[2],col="red",lwd=2)
abline(mod$coef[1]+mod$coef[3],mod$coef[2],col="blue",lwd=2)
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
text(x=1.75,y=4.5,expression(paste(hat(APD),"=0.63")),cex=1.5,col="purple")
segments(x0=eneth[ro==0],y0=predict(mod)[ro==0],y1=predict(mod)[ro==0] + .631,col="red")
segments(x0=eneth[ro==1],y0=predict(mod)[ro==1]-.631,y1=predict(mod)[ro==1],col="blue")
dev.off()

# estimated effect
lm(enpres ~ eneth+ro, data=netocox)$coef[3]

# Plot 3

pdf("p3.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=country[ro==0],col="red")
text(eneth[ro==1],enpres[ro==1],labels=country[ro==1],col="blue")
mod <- lm(enpres ~ eneth, data=netocox[ro==0,])
abline(mod,col="red",lwd=2)
mod <- lm(enpres ~ eneth, data=netocox[ro==1,])
abline(mod,col="blue",lwd=2)
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()


# Plot 4

pdf("p4.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=country[ro==0],col="red")
text(eneth[ro==1],enpres[ro==1],labels=country[ro==1],col="blue")
mod0 <- lm(enpres ~ eneth, data=netocox[ro==0,])
abline(mod0,col="red",lwd=2)
mod1 <- lm(enpres ~ eneth, data=netocox[ro==1,])
abline(mod1,col="blue",lwd=2)
segments(x0=eneth[ro==0],y0=predict(mod0),y1=predict(mod1,newdata=netocox[ro==0,]),col="red")
segments(x0=eneth[ro==1],y0=predict(mod0,newdata=netocox[ro==1,]),y1=predict(mod1),col="blue")
text(x=1.75,y=4.5,expression(paste(hat(ATE),"=0.67")),cex=1.5,col="purple")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

pdf("p4b.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=country[ro==0],col="red")
text(eneth[ro==1],enpres[ro==1],labels=country[ro==1],col="blue")
mod0 <- lm(enpres ~ eneth, data=netocox[ro==0,])
abline(mod0,col="red",lwd=2)
mod1 <- lm(enpres ~ eneth, data=netocox[ro==1,])
abline(mod1,col="blue",lwd=2)
segments(x0=eneth[ro==0],y0=predict(mod0),y1=predict(mod1,newdata=netocox[ro==0,]),col="red")
segments(x0=eneth[ro==1],y0=predict(mod0,newdata=netocox[ro==1,]),y1=predict(mod1),col="blue")
text(x=1.75,y=4.5,expression(paste(hat(APD),"=0.67")),cex=1.5,col="purple")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()



# estimated effect
lm(enpres ~ I(eneth-mean(eneth))*ro, data=netocox)$coef[3] 

# Plot 5

pdf("p5.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==1],enpres[ro==1],labels=country[ro==1],col="blue")
mod0 <- lm(enpres ~ eneth, data=netocox[ro==0,])
abline(mod0,col="red",lwd=2)
mod1 <- lm(enpres ~ eneth, data=netocox[ro==1,])
abline(mod1,col="blue",lwd=2)
segments(x0=eneth[ro==1],y0=predict(mod0,newdata=netocox[ro==1,]),y1=predict(mod1),col="blue")
text(x=1.75,y=4.5,expression(paste(hat(APD)[1],"=0.79")),cex=1.5,col="blue")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

# estimated effect
att.hat <- mean(predict(mod1)-predict(mod0,newdata=netocox[ro==1,]))   

# Plot 6

pdf("p6.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=country[ro==0],col="red")
mod0 <- lm(enpres ~ eneth, data=netocox[ro==0,])
abline(mod0,col="red",lwd=2)
mod1 <- lm(enpres ~ eneth, data=netocox[ro==1,])
abline(mod1,col="blue",lwd=2)
segments(x0=eneth[ro==0],y0=predict(mod0),y1=predict(mod1,newdata=netocox[ro==0,]),col="red")
text(x=1.75,y=4.5,expression(paste(hat(APD)[0],"=0.55")),cex=1.5,col="red")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

# estimated ATC
atc.hat <- mean(predict(mod1,newdata=netocox[ro==0,])-predict(mod0))

# ATE is average of ATT and ATC
8/16*att.hat+8/16*atc.hat



# Plot 7

pdf("p7.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=y0[ro==0],col="red")
mod0 <- lm(enpres ~ eneth, data=netocox[ro==0,])
abline(mod0,col="red",lwd=2)
mod1 <- lm(enpres ~ eneth, data=netocox[ro==1,])
abline(mod1,col="blue",lwd=2)
segments(x0=eneth[ro==0],y0=predict(mod0),y1=predict(mod1,newdata=netocox[ro==0,]),col="red")
text(x=1.75,y=4.5,expression(paste(hat(ATC),"=0.55")),cex=1.5,col="red")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

# Plot 8

pdf("p8.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=y0[ro==0],col="red")
mod0 <- lm(enpres ~ eneth, data=netocox[ro==0,])
abline(mod0,col="red",lwd=2)
mod1 <- lm(enpres ~ eneth, data=netocox[ro==1,])
abline(mod1,col="blue",lwd=2)
segments(x0=eneth[ro==0],y0=enpres[ro==0],y1=predict(mod1,newdata=netocox[ro==0,]),col="red")
text(x=1.75,y=4.5,expression(paste(hat(ATC),"=0.55")),cex=1.5,col="red")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

# Plot 8

pdf("p8b.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=y0[ro==0],col="red")
mod1 <- lm(enpres ~ eneth, data=netocox[ro==1,])
abline(mod1,col="blue",lwd=2)
segments(x0=eneth[ro==0],y0=enpres[ro==0],y1=predict(mod1,newdata=netocox[ro==0,]),col="red")
text(x=1.75,y=4.5,expression(paste(hat(ATC),"=0.55")),cex=1.5,col="red")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

# Plot 9

pdf("p9.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=y0[ro==0],col="red")
#mod0 <- lm(enpres ~ eneth, data=netocox[ro==0,])
#abline(mod0,col="red",lwd=2)
mod1 <- lm(enpres ~ eneth, data=netocox[ro==1,])
abline(mod1,col="blue",lwd=2)
text(eneth[ro==0],predict(mod1,newdata=netocox[ro==0,]),labels=y1hat[ro==0],col="red")
segments(x0=eneth[ro==0],y0=enpres[ro==0],y1=predict(mod1,newdata=netocox[ro==0,]),col="red")
text(x=1.75,y=4.5,expression(paste(hat(ATC),"=0.55")),cex=1.5,col="red")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

# Plot 10

pdf("p10.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=y0[ro==0],col="red")
#mod0 <- lm(enpres ~ eneth, data=netocox[ro==0,])
#abline(mod0,col="red",lwd=2)
mod1 <- lm(enpres ~ eneth, data=netocox[ro==1,])
abline(mod1,col="blue",lwd=2)
text(eneth[ro==1],enpres[ro==1],labels=country[ro==1],col="blue")
#text(eneth[ro==0],predict(mod1,newdata=netocox[ro==0,]),labels=y1hat[ro==0],col="blue")
#segments(x0=eneth[ro==0],y0=enpres[ro==0],y1=predict(mod1,newdata=netocox[ro==0,]),col="red")
#text(x=1.75,y=4.5,expression(paste(hat(ATC),"=0.55")),cex=1.5,col="red")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

# Plot 11

pdf("p11.pdf")
plot(density(eneth[ro==1]),col="blue",lwd=2,type="l",ylim=c(-.02,.75),xlim=c(.75,3),xlab="effective number of ethnic groups",main="")
lines(density(eneth[ro==0]),col="red",lwd=2)
abline(h=0)
legend("topright",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
points(mean(eneth[ro==1]),-.02,pch=2,cex=2,col="blue",lwd=2)
points(mean(eneth[ro==0]),-.02,pch=2,cex=2,col="red",lwd=2)
dev.off()

# Plot 12

pdf("p12.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=y0[ro==0],col="red")
#mod0 <- lm(enpres ~ eneth, data=netocox[ro==0,])
#abline(mod0,col="red",lwd=2)
mod1 <- lm(enpres ~ eneth, data=netocox[ro==1,])
abline(mod1,col="blue",lwd=2)
mod1 <- lm(enpres ~ eneth + I(eneth^2), data=netocox[ro==1,])
lines(seq(0,3,.1),mod1$coef[1]+mod1$coef[2]*seq(0,3,.1)+mod1$coef[3]*seq(0,3,.1)^2,col="blue",lwd=2)
text(eneth[ro==1],enpres[ro==1],labels=country[ro==1],col="blue")
#text(eneth[ro==0],predict(mod1,newdata=netocox[ro==0,]),labels=y1hat[ro==0],col="blue")
#segments(x0=eneth[ro==0],y0=enpres[ro==0],y1=predict(mod1,newdata=netocox[ro==0,]),col="red")
#text(x=1.75,y=4.5,expression(paste(hat(ATC),"=0.55")),cex=1.5,col="red")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

# Plot 13

pdf("p13.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=y0[ro==0],col="red")
#mod0 <- lm(enpres ~ eneth, data=netocox[ro==0,])
#abline(mod0,col="red",lwd=2)
mod1 <- lm(enpres ~ eneth, data=netocox[ro==1,])
abline(mod1,col="blue",lwd=2)
mod1 <- lm(enpres ~ eneth + I(eneth^2), data=netocox[ro==1,])
lines(seq(0,3,.1),mod1$coef[1]+mod1$coef[2]*seq(0,3,.1)+mod1$coef[3]*seq(0,3,.1)^2,col="blue",lwd=2)
text(eneth[ro==0],predict(mod1,newdata=netocox[ro==0,]),labels=y1hat[ro==0],col="red")
segments(x0=eneth[ro==0],y0=enpres[ro==0],y1=predict(mod1,newdata=netocox[ro==0,]),col="red")
text(x=1.75,y=4.5,expression(paste(hat(ATC),"=1.45")),cex=1.5,col="red")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

mean(predict(mod1,newdata=netocox[ro==0,])-enpres[ro==0])

pdf("p13b.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=country[ro==0],col="red")
text(eneth[ro==1],enpres[ro==1],labels=country[ro==1],col="blue")
mod1 <- lm(enpres ~ ro + eneth + I(eneth^2), data=netocox)
lines(seq(0,3,.1),mod1$coef[1]+mod1$coef[3]*seq(0,3,.1)+mod1$coef[4]*seq(0,3,.1)^2,col="red",lwd=2)
lines(seq(0,3,.1),mod1$coef[1]+mod1$coef[2]+mod1$coef[3]*seq(0,3,.1)+mod1$coef[4]*seq(0,3,.1)^2,col="blue",lwd=2)
segments(x0=eneth[ro==0],y0=predict(mod1)[ro==0],y1=predict(mod1)[ro==0] +.7542,col="red")
segments(x0=eneth[ro==1],y0=predict(mod1)[ro==1],y1=predict(mod1)[ro==1] -.7542,col="blue")
text(x=1.75,y=4.5,expression(paste(hat(APD),"=0.75")),cex=1.5,col="purple")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

pdf("p13c.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=country[ro==0],col="red")
text(eneth[ro==1],enpres[ro==1],labels=country[ro==1],col="blue")
mod0 <- lm(enpres ~ eneth + I(eneth^2), data=netocox[ro==0,])
mod1 <- lm(enpres ~ eneth + I(eneth^2), data=netocox[ro==1,])
lines(seq(0,3,.1),mod0$coef[1]+mod0$coef[2]*seq(0,3,.1)+mod0$coef[3]*seq(0,3,.1)^2,col="red",lwd=2)
lines(seq(0,3,.1),mod1$coef[1]+mod1$coef[2]*seq(0,3,.1)+mod1$coef[3]*seq(0,3,.1)^2,col="blue",lwd=2)
segments(x0=eneth[ro==0],y0=predict(mod0),y1=predict(mod1,newdata=netocox[ro==0,]),col="red")
segments(x0=eneth[ro==1],y0=predict(mod1),y1=predict(mod0,newdata=netocox[ro==1,]),col="blue")
text(x=1.75,y=4.5,expression(paste(hat(APD),"=0.99")),cex=1.5,col="purple")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

(sum(predict(mod1,newdata=netocox[ro==0,])-predict(mod0)) + sum(predict(mod1) - predict(mod0,newdata=netocox[ro==1,])))/16

# Plot 14

pdf("p14.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=country[ro==0],col="red")
mod0 <- lm(enpres ~ eneth, data=netocox[ro==0,])
abline(mod0,col="red",lwd=2)
mod0 <- lm(enpres ~ eneth + I(eneth^2), data=netocox[ro==0,])
lines(seq(0,3,.1),mod0$coef[1]+mod0$coef[2]*seq(0,3,.1)+mod0$coef[3]*seq(0,3,.1)^2,col="red",lwd=2)
text(eneth[ro==1],enpres[ro==1],labels=y1[ro==1],col="blue")
#text(eneth[ro==0],predict(mod1,newdata=netocox[ro==0,]),labels=y1hat[ro==0],col="blue")
#segments(x0=eneth[ro==0],y0=enpres[ro==0],y1=predict(mod1,newdata=netocox[ro==0,]),col="red")
#text(x=1.75,y=4.5,expression(paste(hat(ATC),"=0.55")),cex=1.5,col="red")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

# Plot 15

pdf("p15.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=country[ro==0],col="red")
mod0 <- lm(enpres ~ eneth, data=netocox[ro==0,])
abline(mod0,col="red",lwd=2)
mod0 <- lm(enpres ~ eneth + I(eneth^2), data=netocox[ro==0,])
lines(seq(0,3,.1),mod0$coef[1]+mod0$coef[2]*seq(0,3,.1)+mod0$coef[3]*seq(0,3,.1)^2,col="red",lwd=2)
text(eneth[ro==1],enpres[ro==1],labels=y1[ro==1],col="blue")
text(eneth[ro==1],predict(mod0,newdata=netocox[ro==1,]),labels=y0hat[ro==1],col="blue")
segments(x0=eneth[ro==1],y0=enpres[ro==1],y1=predict(mod0,newdata=netocox[ro==1,]),col="blue")
text(x=1.75,y=4.5,expression(paste(hat(ATT),"=0.53")),cex=1.5,col="blue")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

#effect 

mean(enpres[ro==1]-predict(mod0,newdata=netocox[ro==1,]))

# Plot 15a

pdf("p15a.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=country[ro==0],col="red")
mod0 <- lm(enpres ~ eneth, data=netocox[ro==0,])
abline(mod0,col="red",lwd=2)
mod0 <- lm(enpres ~ eneth + I(eneth^2), data=netocox[ro==0,])
lines(seq(0,3,.1),mod0$coef[1]+mod0$coef[2]*seq(0,3,.1)+mod0$coef[3]*seq(0,3,.1)^2,col="red",lwd=2)
mod0 <- gam(enpres ~ s(eneth,k=5), data=netocox[ro==0,])
eneth.plot.vec <- seq(0,3,.1)
eneth.plot <- data.frame(eneth = eneth.plot.vec)
lines(seq(0,3,.1),predict(mod0,newdata=eneth.plot),col="red",lwd=2)

text(eneth[ro==1],enpres[ro==1],labels=y1[ro==1],col="blue")
#text(eneth[ro==1],predict(mod0,newdata=netocox[ro==1,]),labels=y0hat[ro==1],col="blue")
#segments(x0=eneth[ro==1],y0=enpres[ro==1],y1=predict(mod0,newdata=netocox[ro==1,]),col="blue")
#text(x=1.75,y=4.5,expression(paste(hat(ATT),"=0.64")),cex=1.5,col="blue")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

# Plot 15b

pdf("p15b.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=country[ro==0],col="red")
#mod0 <- lm(enpres ~ eneth, data=netocox[ro==0,])
#abline(mod0,col="red",lwd=2)
#mod0 <- lm(enpres ~ eneth + I(eneth^2), data=netocox[ro==0,])
#lines(seq(0,3,.1),mod0$coef[1]+mod0$coef[2]*seq(0,3,.1)+mod0$coef[3]*seq(0,3,.1)^2,col="red",lwd=2)
mod0 <- gam(enpres ~ s(eneth,k=5), data=netocox[ro==0,])
eneth.plot.vec <- seq(0,3,.1)
eneth.plot <- data.frame(eneth = eneth.plot.vec)
lines(seq(0,3,.1),predict(mod0,newdata=eneth.plot),col="red",lwd=2)

text(eneth[ro==1],enpres[ro==1],labels=y1[ro==1],col="blue")
#text(eneth[ro==1],predict(mod0,newdata=netocox[ro==1,]),labels=y0hat[ro==1],col="blue")
#segments(x0=eneth[ro==1],y0=enpres[ro==1],y1=predict(mod0,newdata=netocox[ro==1,]),col="blue")
#text(x=1.75,y=4.5,expression(paste(hat(ATT),"=0.64")),cex=1.5,col="blue")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()



# Plot 15c

pdf("p15c.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=country[ro==0],col="red")
#mod0 <- lm(enpres ~ eneth, data=netocox[ro==0,])
#abline(mod0,col="red",lwd=2)
#mod0 <- lm(enpres ~ eneth + I(eneth^2), data=netocox[ro==0,])
#lines(seq(0,3,.1),mod0$coef[1]+mod0$coef[2]*seq(0,3,.1)+mod0$coef[3]*seq(0,3,.1)^2,col="red",lwd=2)
mod0 <- gam(enpres ~ s(eneth,k=5), data=netocox[ro==0,])
eneth.plot.vec <- seq(0,3,.1)
eneth.plot <- data.frame(eneth = eneth.plot.vec)
lines(seq(0,3,.1),predict(mod0,newdata=eneth.plot),col="red",lwd=2)

text(eneth[ro==1],enpres[ro==1],labels=y1[ro==1],col="blue")
text(eneth[ro==1],predict(mod0,newdata=netocox[ro==1,]),labels=y0hat[ro==1],col="blue")
segments(x0=eneth[ro==1],y0=enpres[ro==1],y1=predict(mod0,newdata=netocox[ro==1,]),col="blue")
text(x=1.75,y=4.5,expression(paste(hat(ATT),"=0.64")),cex=1.5,col="blue")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

#effect 

mean(enpres[ro==1]-predict(mod0,newdata=netocox[ro==1,]))

# Plot 15d

pdf("p15d.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=country[ro==0],col="red")
text(eneth[ro==1],enpres[ro==1],labels=country[ro==1],col="blue")
mod0 <- gam(enpres ~ s(eneth,k=5), data=netocox[ro==0,])
eneth.plot.vec <- seq(0,3,.1)
eneth.plot <- data.frame(eneth = eneth.plot.vec)
lines(seq(0,3,.1),predict(mod0,newdata=eneth.plot),col="red",lwd=2)
mod1 <- gam(enpres ~ s(eneth,k=5), data=netocox[ro==1,])
eneth.plot.vec <- seq(0,3,.1)
eneth.plot <- data.frame(eneth = eneth.plot.vec)
lines(seq(0,3,.1),predict(mod1,newdata=eneth.plot),col="blue",lwd=2)
segments(x0=eneth[ro==0],y0=predict(mod0),y1=predict(mod1,newdata=netocox[ro==0,]),col="red")
segments(x0=eneth[ro==1],y0=predict(mod1),y1=predict(mod0,newdata=netocox[ro==1,]),col="blue")
text(x=1.75,y=4.5,expression(paste(hat(APD),"=0.91")),cex=1.5,col="purple")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

#effect 

(sum(predict(mod1,newdata=netocox[ro==0,])-predict(mod0)) + sum(predict(mod1)-predict(mod0,newdata=netocox[ro==1,])))/16 





# Plot 16

pdf("p16.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=y0[ro==0],col="red")
text(eneth[ro==1],enpres[ro==1],labels=y1[ro==1],col="blue")
text(eneth[ro==1],c(enpres[country=="KOREA"],
enpres[country=="VENEZUELA"],
enpres[country=="ICELAND"],
enpres[country=="ARGENTINA"],
enpres[country=="COLOMBIA"],
enpres[country=="FINLAND"],
enpres[country=="COLOMBIA"],
enpres[country=="KOREA"]
),labels=y0hat[ro==1],col="blue")
segments(x0=eneth[ro==1],y0=enpres[ro==1],y1=c(enpres[country=="KOREA"],
enpres[country=="VENEZUELA"],
enpres[country=="ICELAND"],
enpres[country=="ARGENTINA"],
enpres[country=="COLOMBIA"],
enpres[country=="FINLAND"],
enpres[country=="COLOMBIA"],
enpres[country=="KOREA"]
),col="blue")
text(x=1.75,y=4.5,expression(paste(hat(ATT),"=0.56")),cex=1.5,col="blue")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

#effect 

mean(enpres[ro==1]-mean(c(enpres[country=="KOREA"],
enpres[country=="VENEZUELA"],
enpres[country=="ICELAND"],
enpres[country=="ARGENTINA"],
enpres[country=="COLOMBIA"],
enpres[country=="FINLAND"],
enpres[country=="COLOMBIA"],
enpres[country=="KOREA"]
)))

# Plot 17

pdf("p17.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=y0[ro==0],col="red")
text(eneth[ro==1],enpres[ro==1],labels=y1[ro==1],col="blue")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

# Plot 17

pdf("p17b.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=y0[ro==0],col="red")
text(eneth[ro==1],enpres[ro==1],labels=y1[ro==1],col="blue")
text(eneth[ro==1],rep(enpres[country=="FINLAND"],8),labels=y0hat[ro==1],col="blue")
segments(x0=eneth[ro==1],y0=enpres[ro==1],y1=rep(enpres[country=="FINLAND"],8),col="blue")
text(x=1.75,y=4.5,expression(paste(hat(ATT),">-0.30")),cex=1.5,col="blue")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

mean(enpres[ro==1]-rep(enpres[country=="FINLAND"],8))

# Plot 18

pdf("p18.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=y0[ro==0],col="red")
text(eneth[ro==1],enpres[ro==1],labels=y1[ro==1],col="blue")
text(eneth[ro==1],rep(enpres[country=="FINLAND"],8),labels=y0hat[ro==1],col="blue")
segments(x0=eneth[ro==1],y0=enpres[ro==1],y1=rep(enpres[country=="FINLAND"],8),col="blue")
text(x=1.75,y=4.5,expression(paste(hat(ATT),"=-0.30")),cex=1.5,col="blue")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()



##############################




# Plot 8

pdf("p8.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=y0[ro==0],col="red")
mod0 <- lm(enpres ~ eneth, data=netocox[ro==0,])
abline(mod0,col="red",lwd=2)
mod1 <- lm(enpres ~ eneth, data=netocox[ro==1,])
abline(mod1,col="blue",lwd=2)
text(eneth[ro==0],predict(mod1,newdata=netocox[ro==0,]),labels=y1hat[ro==0],col="blue")
segments(x0=eneth[ro==0],y0=predict(mod0),y1=predict(mod1,newdata=netocox[ro==0,]),col="red")
text(x=1.75,y=4.5,expression(paste(hat(ATC),"=0.55")),cex=1.5,col="red")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()




pdf("roenethPO.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=y0[ro==0],col="red")
text(eneth[ro==1],enpres[ro==1],labels=y1[ro==1],col="blue")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()


# Plot 3 #

pdf("roenethPO0lin.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=y0[ro==0],col="red")
text(eneth[ro==1],enpres[ro==1],labels=y1[ro==1],col="blue")
mod <- lm(enpres ~ eneth, data=netocox[ro==1,])
abline(mod,col="blue",lwd=2)
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()

# Plot 4 #

pdf("roenethPO0lin.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=y0[ro==0],col="red")
mod <- lm(enpres ~ eneth, data=netocox[ro==1,])
abline(mod,col="blue",lwd=2)
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()



# Plot 5 #
y1hat <- c(expression(hat(Y)(1)[ARG]),
expression(hat(Y)(1)[AUS]),
expression(hat(Y)(1)[BRA]),
expression(hat(Y)(1)[COL]),
expression(hat(Y)(1)[CR]),
expression(hat(Y)(1)[DR]),
expression(hat(Y)(1)[ES]),
expression(hat(Y)(1)[ECU]),
expression(hat(Y)(1)[FIN]),
expression(hat(Y)(1)[FRA]),
expression(hat(Y)(1)[ICE]),
expression(hat(Y)(1)[KOR]),
expression(hat(Y)(1)[PERU]),
expression(hat(Y)(1)[POR]),
expression(hat(Y)(1)[USA]),
expression(hat(Y)(1)[VEN])
)

pdf("roenethImputePO1.pdf")
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=y0[ro==0],col="red")
mod <- lm(enpres ~ eneth, data=netocox[ro==1,])
abline(mod,col="blue",lwd=2)
text(eneth[ro==0],predict(mod,newdata=netocox[ro==0,]),labels=y1hat[ro==0],col="blue")
legend("topleft",legend=c("no runoff","runoff"),lwd=1.5,col=c("red","blue"))
dev.off()









## Part B - plot model 1 ##


mod <- lm(enpres ~ eneth , data=netocox[ro==0,])
summary(mod)
mod <- lm(enpres ~ eneth + I(eneth^2), data=netocox[ro==0,])
summary(mod)

mod <- lm(enpres ~ eneth, data=netocox[ro==1,])
abline(mod,col="blue",lwd=2)
mod <- lm(enpres ~ eneth + I(eneth^2), data=netocox[ro==1,])
summary(mod)
lines(seq(0,3,.1),mod$coef[1]+mod$coef[2]*seq(0,3,.1)+mod$coef[3]*seq(0,3,.1)^2,col="blue",lwd=2)

lines(seq(0,3,.1),mod$coef[1]+mod$coef[2]*seq(0,3,.1)+mod$coef[3]*seq(0,3,.1)^2,col="red",lwd=2)


kmod <- krls(X=as.matrix(eneth[ro==1]),y=enpres[ro==1],derivative=TRUE)
fit <- predict.krls(kmod,newdata=as.matrix(eneth),se.fit=TRUE)
points(y=fit$fit,as.matrix(eneth))

pdf("roeneth.pdf")
par(mar=c(7, 4, 4, 2) + 0.1)
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="effective number of ethnic groups",ylab="effective number of presidential candidates")
text(eneth[ro==0],enpres[ro==0],labels=country[ro==0],col="red")
text(eneth[ro==1],enpres[ro==1],labels=country[ro==1],col="blue")
legend("topleft",legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))
dev.off()




par(mar=c(7, 4, 4, 2) + 0.1)
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="number of ethnic groups",ylab="number of presidential parties")
text(eneth[ro==0],enpres[ro==0],labels=country[ro==0],col="red")
text(eneth[ro==1],enpres[ro==1],labels=country[ro==1],col="blue")
abline(a=mod1$coef[1],b=mod1$coef[3],lwd=2,col="red")
abline(a=sum(mod3$coef[1:2]),b=mod1$coef[3],lwd=2,col="blue")
legend(x=1,y=5.5,legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))


# standard additive model "expected difference" interpretations

# model doesn't make theoretical sense because we expect the ``effect'' of ENETH to depend on whether or not a country has a runoff election.

## Part C - plot model 3 ##

par(mar=c(7, 4, 4, 2) + 0.1)
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="number of ethnic groups",ylab="number of presidential parties")
text(eneth[ro==0],enpres[ro==0],labels=country[ro==0],col="red")
text(eneth[ro==1],enpres[ro==1],labels=country[ro==1],col="blue")
abline(a=mod3$coef[1],b=0,lwd=2,col="red")
abline(a=mod3$coef[1],b=mod3$coef[2],lwd=2,col="blue")
legend(x=1,y=5.5,legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))

# all non-runoff countries expected to have the same enpress
# among runoff countries, standard "expected difference" interpretation
# expected enpress difference between runoff and non-runoff countries with the same eneth will be larger for higher eneth

# model doesn't fit the data well
# flat line for non-runoff countries seems to miss the slight negative trend
# line for runoff countries seems to understate the slope for that group

## Part D ##

par(mar=c(7, 4, 4, 2) + 0.1)
plot(eneth,enpres,type="n",xlim=c(0.75,3),xlab="number of ethnic groups",ylab="number of presidential parties")
text(eneth[ro==0],enpres[ro==0],labels=country[ro==0],col="red")
text(eneth[ro==1],enpres[ro==1],labels=country[ro==1],col="blue")
abline(a=mod2$coef[1],b=mod2$coef[3],lwd=2,col="red")
abline(a=sum(mod2$coef[1:2]),b=sum(mod2$coef[3:4]),lwd=2,col="blue")
legend(x=1,y=5.5,legend=c("no runoff","runoff"),lwd=2,col=c("red","blue"))


# Exploring the RUNOFF effect
summary(mod2)

# 1) expected difference between runoff and nonrunoff countries with zero eneth not statistically significant, and not substantively meaningful because no country can have zero eneth

# 2) beta_{ro} + beta_{ro:eneth}*eneth

#  -2.4911 + 2.0054*eneth

# 3) 

summary(lm(enpres ~ ro*I(eneth - 1.5), data=netocox))

.5170 + c(-1,1)*qt(p=.975,df=16-4)*.5422

sqrt(vcov(mod2)[2,2] + (1.5)^2*vcov(mod2)[4,4] + 1.5*2*vcov(mod2)[2,4])

# 4)

summary(lm(enpres ~ ro*I(eneth - 2), data=netocox))
1.5197 + c(-1,1)*qt(p=.975,df=16-4)*.6817


# 5) expected difference interpretation for two countries with ENETH =2. Should present some discussion of omitted variable (or similar reasoning) to express the difficulty of causal interpretation.

# Exploring the ENETH effect

# 1) not significant, but substantively meaningful (there are countries in the non-runoff category)

# 2) 

# what is the expected difference between two runoff countries with a one unit difference in eneth

gamma.eneth <- sum(mod2$coef[3:4])

# what is the standard error for this expected difference within this model 

se.eneth <- sqrt(vcov(mod2)[3,3] + vcov(mod2)[4,4] + 2*vcov(mod2)[3,4])

# is this result significant at the 10 percent level

2*pt(q=gamma.eneth/se.eneth, df=16-4,lower.tail=FALSE)


# 3)

netocox.noro <- subset(netocox,ro==0)
mod.noro <-lm(enpres~eneth,data=netocox.noro)
summary(mod.noro)

netocox.ro <- subset(netocox,ro==1)
mod.ro <- lm(enpres~eneth,data=netocox.ro)
summary(mod.ro)


# 4) coefficient from non-runoff data set equal to model 2 eneth, coefficient from runoff data set equal to marginal effect in Part #2.

#5) effect for the non-runoff countries insignificant in model 2 but significant in separate analysis... effect for runoff countries significant in model 2 but insignificant in separate analysis. 

#6 ) Heteroskedasticity can be seen in the original scatterplot (more spread for runoff countries). This is easier to see in a residual plot with the runoff indicator on the x-axis.

plot(ro,residuals(mod2))

var(residuals(mod.ro))/var(residuals(mod.noro))

###############
## Problem 2 ## 

library(car)

# A) Generate one data set

set.seed(12345)

day <- 0:89

errors <- rnorm(length(day), mean = 0, sd = 50.1)

funds <- 1000 + 52.4*day + errors

out <- lm(funds ~ day) #1001.02, 52.69

# B)

# Now simulate 10000 datasets, regress funds on day, and 
# store the bounds of the 95% confidence intervals

set.seed(12345)
sims <- 10000
holder <- matrix(data = NA, nrow = sims, ncol = 2)

for (i in 1:sims){
  
  day <- 0:89
  errors <- rnorm(length(day), mean = 0, sd = 50.1)

  funds <- 1000 + 52.4*day + errors

  lm.samp <- lm(funds ~ day)
  holder[i,] <- confint(lm.samp)["day",]
}


# So the proportion of simulated confidence intervals which contain
# the truth is:

sum((52.4 >= holder[,1]) & (52.4 <= holder[,2]))/nrow(holder)
#95.25

# C)
# Now simulate a dataset for days 0:100.  Now we have to draw
# separate errors for the observations before day 90 and after day 90

day180 <- 0:100

set.seed(12345)
errors.bf <- rnorm(sum(day180<90), mean = 0, sd = 50.1)
errors.aft <- rnorm(sum(day180>=90), mean = 0, sd = 13.5)

errors2 <- c(errors.bf, errors.aft)

# And our dependent variable is

funds2 <- 1000 + 52.4*day180 + errors2

out2 <- lm(funds2 ~ day180)
summary(out2)

# D)

# Now drawing 10000 of these datasets and storing the boundaries 
# of a 95% confidence interval:

set.seed(12345)
sims <- 10000
holder2 <- matrix(data = NA, nrow = sims, ncol = 2)

for (i in 1:sims){
  day180 <- 1:100  

  errors.1 <- rnorm(sum(day180<90), mean = 0, sd = 50.1)
  errors.2 <- rnorm(sum(day180>=90), mean = 0, sd = 13.5)

  errors <- c(errors.1, errors.2)

  funds <- 1000 + 52.4*day180 + errors

  lm.samp <- lm(funds ~ day180)
  holder2[i,1:2] <- confint(lm.samp)["day180",]
}
  
sum((52.4 >= holder2[,1]) & (52.4 <= holder2[,2]))/nrow(holder2) #97.04


# E)

# Now let's use White corrected standard errors to see 
# if we improve coverage


set.seed(12345)
sims <- 10000
holder3 <- matrix(data = NA, nrow = sims, ncol = 2)

for (i in 1:sims){
  day180 <- 1:100  

  errors.1 <- rnorm(sum(day180<90), mean = 0, sd = 50.1)
  errors.2 <- rnorm(sum(day180>=90), mean = 0, sd = 13.5)

  errors <- c(errors.1, errors.2)

  funds <- 1000 + 52.4*day180 + errors

  lm.samp <- lm(funds ~ day180)

  ## White corrected standard errors:
  white.se <-sqrt(diag(hccm(lm.samp))) 
  #white.se <-sqrt(diag(hccm(lm.samp,type="hc0"))) 

  lower.ci <- coef(lm.samp)["day180"] - 1.96*white.se["day180"]  
  upper.ci <- coef(lm.samp)["day180"] + 1.96*white.se["day180"]  
  
  holder3[i,1] <- lower.ci
  holder3[i,2] <- upper.ci
}
  
sum((52.4 >= holder3[,1]) & (52.4 <= holder3[,2]))/nrow(holder3) #95.19 with hc3, 94.58 with hc0
																				










### Lecture 7 ###

library(foreign)
library(car)
library(lattice)

fishdata <- read.spss("Fish_data.sav",
                    use.value.labels=FALSE,
                    to.data.frame=TRUE)


fishdata <- fishdata[-46,]
colnames(fishdata)[1] <- "Country"
colnames(fishdata)[2] <- "Democracy"
colnames(fishdata)[4] <- "Income"
colnames(fishdata)[5] <- "EthnicHeterogeneity"
colnames(fishdata)[6] <- "Growth"
colnames(fishdata)[16] <- "Muslim"
colnames(fishdata)[7] <- "BritishColony"
colnames(fishdata)[8] <- "PostComm"

fishdata <- na.omit(fishdata[,c("Country","Democracy","Muslim", "Income","EthnicHeterogeneity", "Growth", "BritishColony","PostComm", "OPEC")])

n <- dim(fishdata)[1]

attach(fishdata)
mod <- lm(Democracy~ Muslim + Income + EthnicHeterogeneity + Growth + BritishColony +PostComm+ OPEC)

model.matrix(mod)


## Models ##

mod1 <- lm(Democracy~Income)
pdf("fishIncome1.pdf")
plot(Income, Democracy)
abline(mod1,lwd=2)
dev.off()

pdf("fishIncome2.pdf")
plot(Income, Democracy)
abline(mod1,lwd=2)
points(Income[BritishColony==1], Democracy[BritishColony==1], col="red", pch=20)
dev.off()

pdf("fishIncome3.pdf")
plot(Income, Democracy)
abline(mod1,lwd=2)
points(Income[BritishColony==1], Democracy[BritishColony==1], col="red", pch=20)
points(Income[BritishColony==0], Democracy[BritishColony==0], col="blue", pch=20)
dev.off()


mod2 <- lm(Democracy ~ Income + BritishColony)
pdf("fishBrit1.pdf")
plot(Income, Democracy, type="n")
points(Income[BritishColony==1], Democracy[BritishColony==1], col="red", pch=20)
points(Income[BritishColony==0], Democracy[BritishColony==0], col="blue", pch=20)
dev.off()

pdf("fishBrit2.pdf")
plot(Income, Democracy, type="n")
points(Income[BritishColony==1], Democracy[BritishColony==1], col="red", pch=20)
points(Income[BritishColony==0], Democracy[BritishColony==0], col="blue", pch=20)
abline(mod2$coef[1], mod2$coef[2], lwd=2, col="blue")

dev.off()

pdf("fishBrit3.pdf")
plot(Income, Democracy, type="n")
points(Income[BritishColony==1], Democracy[BritishColony==1], col="red", pch=20)
points(Income[BritishColony==0], Democracy[BritishColony==0], col="blue", pch=20)
abline(mod2$coef[1], mod2$coef[2], lwd=2, col="blue")
abline(mod2$coef[1] + mod2$coef[3], mod2$coef[2], lwd=2, col="red")
dev.off()


pdf("fishBritquant1.pdf")
plot(Income, Democracy, type="n", xlim=c(-0.5,5.5), ylim=c(-2, 7))
abline(mod2$coef[1], mod2$coef[2], lwd=2, col="blue")
abline(mod2$coef[1] + mod2$coef[3], mod2$coef[2], lwd=2, col="red")
abline(h=0)
lines(c(0,0), c(0, mod2$coef[1]), lwd=2)
text(-.25, -.75, expression(hat(beta)[0]))
dev.off()

pdf("fishBritquant2.pdf")
plot(Income, Democracy, type="n", xlim=c(-0.5,5.5), ylim=c(-2, 7))
abline(mod2$coef[1], mod2$coef[2], lwd=2, col="blue")
abline(mod2$coef[1] + mod2$coef[3], mod2$coef[2], lwd=2, col="red")
abline(h=0)
lines(c(2,3,3), c(mod2$coef[1] + mod2$coef[2]*2, mod2$coef[1] + mod2$coef[2]*2, mod2$coef[1] + mod2$coef[2]*3), lwd=2)
lines(c(2,2,3), c(mod2$coef[1] + mod2$coef[3] + mod2$coef[2]*2, mod2$coef[1] + mod2$coef[3] + mod2$coef[2]*3, mod2$coef[1] + mod2$coef[3]+ mod2$coef[2]*3), lwd=2)
text(3.25, 3, expression(hat(beta)[1]))
text(2.5, 1.5, 1)
dev.off()

pdf("fishBritquant3.pdf")
plot(Income, Democracy, type="n", xlim=c(-0.5,5.5), ylim=c(-2, 7))
abline(mod2$coef[1], mod2$coef[2], lwd=2, col="blue")
abline(mod2$coef[1] + mod2$coef[3], mod2$coef[2], lwd=2, col="red")
abline(h=0)
lines(c(0,0), c(mod2$coef[1] + mod2$coef[3], mod2$coef[1]), lwd=2)
lines(c(2,2), c(mod2$coef[1] + mod2$coef[3] + mod2$coef[2]*2, mod2$coef[1]+ mod2$coef[2]*2), lwd=2)
lines(c(4,4), c(mod2$coef[1] + mod2$coef[3] + mod2$coef[2]*4, mod2$coef[1]+ mod2$coef[2]*4), lwd=2)
text(.15, -.95, expression(hat(beta)[2]))
dev.off()


pdf("fishBrit3D1.pdf")
s3d <- scatterplot3d(Income, BritishColony, Democracy, color=BritishColony*2+2, angle=30, pch=20, zlim=c(1,7), cex.sym=1.2)
#s3d$plane3d(mod2, lty.box = "dashed", col="red")
s3d$points3d(c(2,5), c(0,0), c(mod2$coef[1]+ mod2$coef[2]*2, mod2$coef[1]+5*mod2$coef[2]), type="l", lwd=2, col="red")
s3d$points3d(c(2,5), c(1,1), c(mod2$coef[1] + mod2$coef[3]+ mod2$coef[2]*2, mod2$coef[1]+ mod2$coef[3]+5*mod2$coef[2]), type="l", lwd=2, col="blue")
dev.off()

pdf("fishBrit3D2.pdf")
s3d <- scatterplot3d(BritishColony, Income, Democracy, color=BritishColony*2+2, angle=70, pch=20, zlim=c(1,7), cex.symb=1.2)
mod2a <- lm(Democracy ~ BritishColony + Income)
#s3d$plane3d(mod2a, lty.box = "dashed", col="red")
s3d$points3d(c(0,0), c(2,5) , c(mod2$coef[1]+ mod2$coef[2]*2, mod2$coef[1]+5*mod2$coef[2]), type="l", lwd=2, col="red")
s3d$points3d(c(1,1),c(2,5),  c(mod2$coef[1] + mod2$coef[3]+ mod2$coef[2]*2, mod2$coef[1]+ mod2$coef[3]+5*mod2$coef[2]), type="l", lwd=2, col="blue")
dev.off()


pdf("fishBrit3D3.pdf")
s3d <- scatterplot3d(BritishColony, Income, Democracy, color=BritishColony*2+2, angle=70, pch=20, zlim=c(1,7), cex.symb=1.2)
mod2a <- lm(Democracy ~ BritishColony + Income)
s3d$plane3d(mod2a, lty.box = "dashed", col="red")
s3d$points3d(c(0,0), c(2,5) , c(mod2$coef[1]+ mod2$coef[2]*2, mod2$coef[1]+5*mod2$coef[2]), type="l", lwd=2, col="red")
s3d$points3d(c(1,1),c(2,5),  c(mod2$coef[1] + mod2$coef[3]+ mod2$coef[2]*2, mod2$coef[1]+ mod2$coef[3]+5*mod2$coef[2]), type="l", lwd=2, col="blue")
dev.off()



pdf("fishEth3D1.pdf")
mod3 <- lm(Democracy ~ Income + EthnicHeterogeneity)
s3d <- scatterplot3d(Income, EthnicHeterogeneity, Democracy, angle=30, pch=20, zlim=c(1,7), cex.sym=1.2)
dev.off()

pdf("fishEth3D2.pdf")
mod3 <- lm(Democracy ~ Income + EthnicHeterogeneity)
s3d <- scatterplot3d(Income, EthnicHeterogeneity, Democracy, angle=30, pch=20, zlim=c(1,7), cex.sym=1.2)
s3d$plane3d(mod3, lty.box = "dashed", col="red")
dev.off()


mod3a <- lm(Democracy ~ EthnicHeterogeneity + Income)
pdf("fishEth3D3.pdf")
s3d <- scatterplot3d( EthnicHeterogeneity, Income, Democracy, angle=30, pch=20,zlim=c(1,7), cex.sym=1.2)
s3d$plane3d(mod3a, lty.box = "dashed", col="red")
dev.off()



pdf("margeth1.pdf")
plot(Democracy ~ Income, type="n")
abline(mod3$coef[1] + mod3$coef[3]*0, mod3$coef[2], lwd=2, col="red")
legend(3, 2.5, c("Ethnic Heterogeneity = 0"), lwd=2, col=c("red"), box.lty=0)
dev.off()

pdf("margeth2.pdf")
plot(Democracy ~ Income, type="n")
abline(mod3$coef[1] + mod3$coef[3]*0, mod3$coef[2], lwd=2, col="red")
legend(3, 2.5, c("Ethnic Heterogeneity = 0", "Ethnic Heterogeneity = 0.25"), lwd=2, col=c("red", "magenta"), box.lty=0)
abline(mod3$coef[1] + mod3$coef[3]*0.25, mod3$coef[2], lwd=2, col="magenta")
dev.off()

pdf("margeth3.pdf")
plot(Democracy ~ Income, type="n")
abline(mod3$coef[1] + mod3$coef[3]*0, mod3$coef[2], lwd=2, col="red")
legend(3, 2.5, c("Ethnic Heterogeneity = 0", "Ethnic Heterogeneity = 0.25", "Ethnic Heterogeneity = 0.5"), lwd=2, col=c("red", "magenta", "purple"), box.lty=0)
abline(mod3$coef[1] + mod3$coef[3]*0.25, mod3$coef[2], lwd=2, col="magenta")
abline(mod3$coef[1] + mod3$coef[3]*0.5, mod3$coef[2], lwd=2, col="purple")
dev.off()

pdf("margeth4.pdf")
plot(Democracy ~ Income, type="n")
abline(mod3$coef[1] + mod3$coef[3]*0, mod3$coef[2], lwd=2, col="red")
legend(3, 2.5, c("Ethnic Heterogeneity = 0", "Ethnic Heterogeneity = 0.25", "Ethnic Heterogeneity = 0.5", "Ethnic Heterogeneity = 0.75"), lwd=2, col=c("red", "magenta", "purple", "blue"), box.lty=0)
abline(mod3$coef[1] + mod3$coef[3]*0.25, mod3$coef[2], lwd=2, col="magenta")
abline(mod3$coef[1] + mod3$coef[3]*0.5, mod3$coef[2], lwd=2, col="purple")
abline(mod3$coef[1] + mod3$coef[3]*0.75, mod3$coef[2], lwd=2, col="blue")
dev.off()


pdf("fishBritResid.pdf")
plot(Income, Democracy, type="n")
points(Income[BritishColony==1], Democracy[BritishColony==1], col="red", pch=20)
points(Income[BritishColony==0], Democracy[BritishColony==0], col="blue", pch=20)
abline(mod2$coef[1], mod2$coef[2], lwd=2, col="blue")
abline(mod2$coef[1] + mod2$coef[3], mod2$coef[2], lwd=2, col="red")
segments(Income, mod2$fitted, Income, Democracy, col=(1-BritishColony)*2+2)
dev.off()


pdf("fishEthResid.pdf")
s3d <- scatterplot3d(Income, EthnicHeterogeneity, Democracy, angle=30, pch=20,zlim=c(.9,7), cex.sym=1.2)
s3d$plane3d(mod3, lty.box = "dashed", col="red")
for(i in 1:156){
s3d$points3d(c(Income[i], Income[i]), c(EthnicHeterogeneity[i], EthnicHeterogeneity[i]), c(mod3$fitted[i], Democracy[i]), type="l")
par(ask=T)
}
dev.off()

lm(Democracy ~ EthnicHeterogeneity)
lm(Democracy ~ EthnicHeterogeneity + Income)

modav1 <- lm(Democracy ~ Income)
modav2 <- lm(EthnicHeterogeneity ~ Income)


pdf("av1.pdf")
plot(Democracy ~ Income)
abline(modav1, col="blue", lwd=2)
dev.off()

pdf("av2.pdf")
plot(EthnicHeterogeneity ~ Income)
abline(modav2, col="blue", lwd=2)
dev.off()

pdf("av3.pdf")
plot(residuals(modav1) ~ residuals(modav2),xlab="residuals(EthnicHeterogeneity ~ Income)",ylab="residuals(Democracy ~ Income)")
dev.off()

pdf("av4.pdf")
plot(residuals(modav1) ~ residuals(modav2),xlab="residuals(EthnicHeterogeneity ~ Income)",ylab="residuals(Democracy ~ Income)")
abline(lm(residuals(modav1) ~ residuals(modav2)), col="red", lwd=2)
dev.off()


mod5 <- lm(Democracy ~ Income + EthnicHeterogeneity + BritishColony)
mod5
pdf("fishBoth1.pdf")
s3d <- scatterplot3d(Income, EthnicHeterogeneity, Democracy, color=(1-BritishColony)*2+2, angle=29, pch=20,zlim=c(.9,7), cex.sym=1.2)
dev.off()

pdf("fishBoth2.pdf")
s3d <- scatterplot3d(Income, EthnicHeterogeneity, Democracy, color=(1-BritishColony)*2+2, angle=29, pch=20,zlim=c(.9,7), cex.sym=1.2)
s3d$plane3d(mod5$coef[1], mod5$coef[2], mod5$coef[3], lty.box = "dashed", col="blue")
dev.off()

pdf("fishBoth3.pdf")
s3d <- scatterplot3d(Income, EthnicHeterogeneity, Democracy, color=(1-BritishColony)*2+2, angle=29, pch=20,zlim=c(.9,7), cex.sym=1.2)
s3d$plane3d(mod5$coef[1], mod5$coef[2], mod5$coef[3], lty.box = "dashed", col="blue")
s3d$plane3d(mod5$coef[1] + mod5$coef[4], mod5$coef[2], mod5$coef[3], lty.box = "dashed", col="red")
dev.off()


### Interaction Terms Section ###



mod2 <- lm(Democracy ~ Income + Muslim)
pdf("fishMuslim1.pdf")
plot(Income, Democracy, type="n")
points(Income[Muslim==1], Democracy[Muslim==1], col="purple", pch=20)
points(Income[Muslim==0], Democracy[Muslim==0], col="green", pch=20)
dev.off()

pdf("fishMuslim2.pdf")
plot(Income, Democracy, type="n")
points(Income[Muslim==1], Democracy[Muslim==1], col="purple", pch=20)
points(Income[Muslim==0], Democracy[Muslim==0], col="green", pch=20)
abline(mod3$coef[1], mod3$coef[2], lwd=2, col="green")
dev.off()

pdf("fishMuslimLec1.pdf")
plot(Income, Democracy, type="n")
points(Income[Muslim==1], Democracy[Muslim==1], col="purple", pch=20)
points(Income[Muslim==0], Democracy[Muslim==0], col="green", pch=20)
abline(mod2$coef[1], mod2$coef[2], lwd=2, col="green")
abline(mod2$coef[1] + mod2$coef[3], mod2$coef[2], lwd=2, col="purple")
dev.off()


mod3 <- lm(Democracy ~ Income*Muslim)
mean(Income)
mod3shift <- lm(Democracy ~ I(Income-3.22)*Muslim)


pdf("fishMuslim3.pdf")
plot(Income, Democracy, type="n")
points(Income[Muslim==1], Democracy[Muslim==1], col="purple", pch=20)
points(Income[Muslim==0], Democracy[Muslim==0], col="green", pch=20)
abline(mod3$coef[1], mod3$coef[2], lwd=2, col="green")
abline(mod3$coef[1] + mod3$coef[3], mod3$coef[2] + mod3$coef[4], lwd=2, col="purple")
dev.off()

mod3 <- lm(Democracy ~ Income*Muslim)
pdf("fishMuslim5.pdf")
plot(Income, Democracy, type="n",xlim=c(0,max(Income)))
points(Income[Muslim==1], Democracy[Muslim==1], col="purple", pch=20)
points(Income[Muslim==0], Democracy[Muslim==0], col="green", pch=20)
abline(mod3$coef[1], mod3$coef[2], lwd=2, col="green")
abline(mod3$coef[1] + mod3$coef[3], mod3$coef[2] + mod3$coef[4], lwd=2, col="purple")
dev.off()

pdf("fishMuslim5shift.pdf")
plot(I(Income-3.22), Democracy, type="n",xlim=c(min(Income)-3.22,max(Income)-3.22))
points(Income[Muslim==1]-3.22, Democracy[Muslim==1], col="purple", pch=20)
points(Income[Muslim==0]-3.22, Democracy[Muslim==0], col="green", pch=20)
abline(mod3shift$coef[1], mod3shift$coef[2], lwd=2, col="green")
abline(mod3shift$coef[1] + mod3shift$coef[3], mod3shift$coef[2] + mod3shift$coef[4], lwd=2, col="purple")
dev.off()



pdf("fishMuslimquant1.pdf")
plot(Income, Democracy, type="n", xlim=c(-0.5,5.5), ylim=c(-2, 7))
abline(mod3$coef[1], mod3$coef[2], lwd=2, col="green")
abline(mod3$coef[1] + mod3$coef[3], mod3$coef[2]+mod3$coef[4], lwd=2, col="purple")
abline(h=0)
lines(c(0,0), c(0, mod3$coef[1]), lwd=2)
text(-.25, -.75, expression(hat(beta)[0]))
dev.off()

pdf("fishMuslimquant2.pdf")
plot(Income, Democracy, type="n", xlim=c(-0.5,5.5), ylim=c(-2, 7))
abline(mod3$coef[1], mod3$coef[2], lwd=2, col="green")
abline(mod3$coef[1] + mod3$coef[3], mod3$coef[2]+mod3$coef[4], lwd=2, col="purple")
abline(h=0)
lines(c(1,2,2), c(mod3$coef[1] + mod3$coef[2]*1, mod3$coef[1] + mod3$coef[2]*1, mod3$coef[1] + mod3$coef[2]*2), lwd=2)
text(2.25, 1.5, expression(hat(beta)[1]))
text(1.5, 0.6, 1)
dev.off()




pdf("fishMuslimquant3.pdf")
plot(Income, Democracy, type="n", xlim=c(-0.5,5.5), ylim=c(-2, 7))
abline(mod3$coef[1], mod3$coef[2], lwd=2, col="green")
abline(mod3$coef[1] + mod3$coef[3], mod3$coef[2]+mod3$coef[4], lwd=2, col="purple")
abline(h=0)
lines(c(0,0), c(mod3$coef[1] + mod3$coef[3], mod3$coef[1]), lwd=2)
text(.15, 1, expression(hat(beta)[2]))
dev.off()


pdf("fishMuslimquant4.pdf")
plot(Income, Democracy, type="n", xlim=c(-0.5,5.5), ylim=c(-2, 7))
abline(mod3$coef[1], mod3$coef[2], lwd=2, col="green")
abline(mod3$coef[1] + mod3$coef[3], mod3$coef[2]+mod3$coef[4], lwd=2, col="purple")
abline(h=0)
lines(c(1,2,2), c(mod3$coef[1] + mod3$coef[3] + mod3$coef[2]*1 + mod3$coef[4]*1, mod3$coef[1] + mod3$coef[3] + mod3$coef[2]*1 + mod3$coef[4]*1, mod3$coef[1] + mod3$coef[3] + mod3$coef[2]*2 + mod3$coef[4]*2), lwd=2)
text(2.4, 3.15, expression(hat(beta)[1] + hat(beta)[3]))
text(1.5, 3.5, 1)
dev.off()


colvec <- c("green", "purple")

library(scatterplot3d)
pdf("fishMuslim3D1.pdf")
s3d <- scatterplot3d(Income, Muslim, Democracy, color=colvec[Muslim+1], angle=60, pch=20, zlim=c(1,7), cex.sym=1.2)
#s3d$plane3d(mod2, lty.box = "dashed", col="red")
s3d$points3d(c(2,5), c(0,0), c(mod3$coef[1]+ mod3$coef[2]*2, mod3$coef[1]+5*mod3$coef[2]), type="l", lwd=2, col="green")
s3d$points3d(c(2,5), c(1,1), c(mod3$coef[1] + mod3$coef[3]+ mod3$coef[2]*2 + mod3$coef[4]*2, mod3$coef[1]+ mod3$coef[3]+5*mod3$coef[2]+ mod3$coef[4]*5), type="l", lwd=2, col="purple")
dev.off()

pdf("fishMuslim3D2.pdf")
s3d <- scatterplot3d(Muslim, Income, Democracy, color=colvec[Muslim+1], angle=70, pch=20, zlim=c(1,7), cex.symb=1.2)
mod3a <- lm(Democracy ~  Muslim*Income)
#s3d$plane3d(mod2a, lty.box = "dashed", col="red")
s3d$points3d(c(0,0), c(2,5), c(mod3a$coef[1]+ mod3a$coef[3]*2, mod3a$coef[1]+5*mod3a$coef[3]), type="l", lwd=2, col="green")
s3d$points3d(c(1,1), c(2,5), c(mod3a$coef[1] + mod3a$coef[2]+ mod3a$coef[3]*2 + mod3a$coef[4]*2, mod3a$coef[1]+ mod3a$coef[2]+5*mod3a$coef[3]+ mod3a$coef[4]*5), type="l", lwd=2, col="purple")
dev.off()

pdf("fishMuslim3D3.pdf")
s3d <- scatterplot3d(Muslim, Income, Democracy, color=colvec[Muslim+1], angle=70, pch=20, zlim=c(1,7), cex.symb=1.2)
mod3a <- lm(Democracy ~  Muslim*Income)
s3d$points3d(c(0,0), c(2,5), c(mod3a$coef[1]+ mod3a$coef[3]*2, mod3a$coef[1]+5*mod3a$coef[3]), type="l", lwd=2, col="green")
s3d$points3d(c(1,1), c(2,5), c(mod3a$coef[1] + mod3a$coef[2]+ mod3a$coef[3]*2 + mod3a$coef[4]*2, mod3a$coef[1]+ mod3a$coef[2]+5*mod3a$coef[3]+ mod3a$coef[4]*5), type="l", lwd=2, col="purple")
for(ii in 1:4){
xx <- ii/5
s3d$points3d(c(xx,xx), c(2,5), c(mod3a$coef[1] + mod3a$coef[2]*xx + mod3a$coef[3]*2 + mod3a$coef[4]*2*xx ,mod3a$coef[1] + mod3a$coef[2]*xx + mod3a$coef[3]*5 + mod3a$coef[4]*5*xx ), type="l", lwd=1, lty=2, col="red")
}
for(ii in 0:6){
xx <- ii/2+2
s3d$points3d(c(0,1),c(xx,xx), c(mod3a$coef[1] + mod3a$coef[2]*0 + mod3a$coef[3]*xx + mod3a$coef[4]*0*xx ,mod3a$coef[1] + mod3a$coef[2]*1 + mod3a$coef[3]*xx + mod3a$coef[4]*1*xx ), type="l", lwd=1, lty=2, col="red")
}
dev.off()


mod3b <- lm(Democracy ~ Income + Income:Muslim)
pdf("fishMuslimIntercept.pdf")
plot(Income, Democracy, type="n")
points(Income[Muslim==1], Democracy[Muslim==1], col="purple", pch=20)
points(Income[Muslim==0], Democracy[Muslim==0], col="green", pch=20)
abline(mod3b$coef[1], mod3b$coef[2], lwd=2, col="green")
abline(mod3b$coef[1], mod3b$coef[2] + mod3b$coef[3], lwd=2, col="purple")
dev.off()




boix <- read.dta("boix.dta")

boixiw <- boix[boix$interwar==1,]
attach(boixiw)

plot(boixiw$socialism, boixiw$threshold)
plot(boixiw$parties, boixiw$threshold)

pdf("boixSocial.pdf")
plot(threshold ~ socialism)
abline(lm(threshold ~ socialism), lwd=2)
dev.off()

pdf("boixParties.pdf")
plot(threshold ~ parties)
abline(lm(threshold ~ parties), lwd=2)
dev.off()


pdf("boix3D1.pdf")
mod4 <- lm(threshold ~ socialism + parties)
s3d <- scatterplot3d(socialism, parties, threshold, angle=30, pch=20, cex.sym=1.2)
#s3d$plane3d(mod4, lty.box = "dashed", col="red")
dev.off()

mod4a <- lm(threshold ~ socialism*parties)

pdf("boix3D2.pdf")
s3d <- scatterplot3d(socialism, parties, threshold, angle=40, pch=20, cex.sym=1.2)
for(ii in 1:7){
xx <- ii
s3d$points3d(c(0,60), c(xx,xx), c(mod4a$coef[1] + mod4a$coef[3]*xx, (mod4a$coef[1] + mod4a$coef[2]*60)+ (mod4a$coef[3]+mod4a$coef[4]*60)*xx), type="l", lwd=1, lty=2, col="red")
}
for(ii in 0:6){
xx <- ii*10
s3d$points3d(c(xx,xx), c(1,7), c(mod4a$coef[1] + mod4a$coef[2]*xx + mod4a$coef[3]*1 + mod4a$coef[4]*1*xx ,mod4a$coef[1] + mod4a$coef[2]*xx + mod4a$coef[3]*7 + mod4a$coef[4]*7*xx ), type="l", lwd=1, lty=2, col="red")
}

dev.off()

pdf("boix3D3.pdf")
s3d <- scatterplot3d(parties, socialism, threshold, angle=60, pch=20, cex.sym=1.2)
for(ii in 1:7){
xx <- ii
s3d$points3d( c(xx,xx), c(0,60), c(mod4a$coef[1] + mod4a$coef[3]*xx, (mod4a$coef[1] + mod4a$coef[2]*60)+ (mod4a$coef[3]+mod4a$coef[4]*60)*xx), type="l", lwd=1, lty=2, col="red")
}
for(ii in 0:6){
xx <- ii*10
s3d$points3d( c(1,7), c(xx,xx), c(mod4a$coef[1] + mod4a$coef[2]*xx + mod4a$coef[3]*1 + mod4a$coef[4]*1*xx ,mod4a$coef[1] + mod4a$coef[2]*xx + mod4a$coef[3]*7 + mod4a$coef[4]*7*xx ), type="l", lwd=1, lty=2, col="red")
}
dev.off()

socnew <- seq(0,60, by=5)
partnew <- seq(1, 7, by=.5)
newdata <- expand.grid(socnew, partnew)
colnames(newdata) <-c("socialism", "parties")
newout <- predict(mod4a, newdata=newdata)
newout <- matrix(newout, length(socnew), length(partnew))

pdf("boixpersp1.pdf")
persp(socnew, partnew, newout, col="skyblue", shade=.75, ltheta=120, lphi=10, theta=0, zlab="threshold", ylab="parties", xlab="socialism")
dev.off()

pdf("boixpersp2.pdf")
persp(socnew, partnew, newout, col="skyblue", shade=.75, ltheta=120, lphi=10, theta=40, zlab="threshold", ylab="parties", xlab="socialism")
dev.off()

pdf("boixpersp3.pdf")
persp(socnew, partnew, newout, col="skyblue", shade=.75, ltheta=120, lphi=10, theta=80, zlab="threshold", ylab="parties", xlab="socialism")
dev.off()


mod4b <- lm(threshold ~ socialism:parties)
newoutb <- predict(mod4b, newdata=newdata)
newoutb <- matrix(newoutb, length(socnew), length(partnew))

pdf("boixpersp4.pdf")
persp(socnew, partnew, newoutb, col="skyblue", shade=.75, ltheta=120, lphi=10, theta=0, zlab="threshold", ylab="parties", xlab="socialism")
dev.off()

pdf("boixperspflat.pdf")
persp(socnew, partnew, matrix(mean(threshold, na.rm=T), length(socnew), length(partnew)), zlim=c(0, 35), zlab="threshold", ylab="parties", xlab="socialism", col="skyblue", shade=.75, ltheta=120, lphi=10, theta=0)
dev.off()


summary(lm(Democracy ~ Income*Muslim))
summary(lm(Democracy ~ I(Income-2.5)*Muslim))

xx <- 0:120/20

pdf("fdist1.pdf")
plot(xx, df(xx, 1, 20),lwd=2, col="red" , type="l")
abline(h=0)
legend(3, 1, c("df1 = 1, df2 = 20"), lwd=2, col=c("red"), box.lty=0)
dev.off()

pdf("fdist2.pdf")
plot(xx, df(xx, 1, 20),lwd=2, col="red" , type="l")
abline(h=0)
lines(xx, df(xx, 3, 18), lwd=2, col="blue")
legend(3, 1, c("df1 = 1, df2 = 20", "df1 = 3, df2 = 18"), lwd=2, col=c("red", "blue"), box.lty=0)
dev.off()

pdf("fdist3.pdf")
plot(xx, df(xx, 1, 20),lwd=2, col="red" , type="l")
abline(h=0)
lines(xx, df(xx, 3, 18), lwd=2, col="blue")
lines(xx, df(xx, 9, 12),lwd=2, col="green")
legend(3, 1, c("df1 = 1, df2 = 20", "df1 = 3, df2 = 18", "df1 = 9, df2 = 12"), lwd=2, col=c("red", "blue", "green"), box.lty=0)
dev.off()


pdf("ftest1.pdf")
plot(xx, df(xx, 3, 18),lwd=2, col="blue" , type="l", xlim=c(0,5))
abline(h=0)
segments(2.4, 0, 2.4, .45, col="red", lwd=2)
text(2.4, .47, "F = 2.4", col="red", cex=1.5)
dev.off()

pdf("ftest2.pdf")
plot(xx, df(xx, 3, 18),lwd=2, col="blue" , type="l", xlim=c(0,5))
abline(h=0)
segments(2.4, 0, 2.4, .45, col="red", lwd=2)
text(2.4, .47, "F = 2.4", col="red", cex=1.5)
idx <- which(xx >=2.4)
polygon(c(2.4, xx[idx],6), c(0, df(xx[idx], 3, 18), 0), col="grey")
lines(xx, df(xx, 3, 18),lwd=2, col="blue")
dev.off()

pdf("ftest3.pdf")
plot(xx, df(xx, 3, 18),lwd=2, col="blue" , type="l", xlim=c(0,5))
abline(h=0)
segments(2.4, 0, 2.4, .45, col="red", lwd=2)
text(2.4, .47, "F = 2.4", col="red", cex=1.5)
idx <- which(xx >=2.4)
polygon(c(2.4, xx[idx],6), c(0, df(xx[idx], 3, 18), 0), col="grey")
lines(xx, df(xx, 3, 18),lwd=2, col="blue")
text(4, .1, "p = 0.101", cex=1.5)
dev.off()



summary(mod4a)



library(mgcv)
?vis.gam

tmp <- gam(threshold ~ s(socialism, parties))
?gam



pdf("margparties1.pdf")
plot(threshold ~ socialism, type="n")
abline(mod4a$coef[1] + mod4a$coef[3]*1, mod4a$coef[2] + mod4a$coef[4]*1 , lwd=2, col="red")
legend(30, 35, c("Parties = 1"), lwd=2, col=c("red"), box.lty=0)
dev.off()

pdf("margparties2.pdf")
plot(threshold ~ socialism, type="n")
abline(mod4a$coef[1] + mod4a$coef[3]*1, mod4a$coef[2] + mod4a$coef[4]*1 , lwd=2, col="red")
legend(30, 35, c("Parties = 1", "Parties = 2"), lwd=2, col=c("red", "magenta"), box.lty=0)
abline(mod4a$coef[1] + mod4a$coef[3]*2, mod4a$coef[2] + mod4a$coef[4]*2 , lwd=2, col="magenta")
dev.off()

pdf("margparties3.pdf")
plot(threshold ~ socialism, type="n")
abline(mod4a$coef[1] + mod4a$coef[3]*1, mod4a$coef[2] + mod4a$coef[4]*1 , lwd=2, col="red")
legend(30, 35, c("Parties = 1", "Parties = 2", "Parties = 3"), lwd=2, col=c("red", "magenta", "purple"), box.lty=0)
abline(mod4a$coef[1] + mod4a$coef[3]*2, mod4a$coef[2] + mod4a$coef[4]*2 , lwd=2, col="magenta")
abline(mod4a$coef[1] + mod4a$coef[3]*3, mod4a$coef[2] + mod4a$coef[4]*3 , lwd=2, col="purple")
dev.off()

pdf("margparties4.pdf")
plot(threshold ~ socialism, type="n")
abline(mod4a$coef[1] + mod4a$coef[3]*1, mod4a$coef[2] + mod4a$coef[4]*1 , lwd=2, col="red")
legend(30, 35, c("Parties = 1", "Parties = 2", "Parties = 3", "Parties = 4"), lwd=2, col=c("red", "magenta", "purple", "blue"), box.lty=0)
abline(mod4a$coef[1] + mod4a$coef[3]*2, mod4a$coef[2] + mod4a$coef[4]*2 , lwd=2, col="magenta")
abline(mod4a$coef[1] + mod4a$coef[3]*3, mod4a$coef[2] + mod4a$coef[4]*3 , lwd=2, col="purple")
abline(mod4a$coef[1] + mod4a$coef[3]*4, mod4a$coef[2] + mod4a$coef[4]*4 , lwd=2, col="blue")
dev.off()


rownames(boixiw) <- c("Austria", "Australia", "Belgium", "Canada", "Denmark", "Finland", "France", "Germany", "Greece", "Iceland", "Ireland", "Italy", "Japan", "Luxembourg", "Netherlands", "New Zealand", "Norway", "missing", "Spain", "Sweden", "Switzerland", "United Kingdom", "United States")

data.frame(rownames(boixiw)[-18], predict(mod4a), predict(mod4b), threshold[-18])


nes <- read.table("nes96r.dat", header=T)
attach(nes)
agesq <- age^2

plot(jitter(income) ~ jitter(age))
modInc <- lm(income ~ age)
modInc2 <- lm(income ~ age + agesq)
modInc3 <- lm(income ~ agesq)

summary(modInc)
summary(modInc2)
summary(modInc3)


ageval <- 18:95

jitter.income <- jitter(income)
jitter.educ <- jitter(educ)
jitter.age <- jitter(age)

pdf("incEduc.pdf")
plot(jitter.income ~ jitter.educ)
dev.off()

pdf("ageInc1.pdf")
plot(jitter.income ~ jitter.age)
dev.off()

pdf("ageInc2.pdf")
plot(jitter.income ~ jitter.age)
lines(ageval, modInc$coef[1] + modInc$coef[2]*ageval, lwd=2, col="red")
dev.off()

pdf("ageInc3.pdf")
plot(jitter.income ~ jitter.age)

lines(ageval, modInc2$coef[1] + modInc2$coef[2]*ageval + modInc2$coef[3]*ageval^2, lwd=2, col="red")
dev.off()

pdf("ageInc4.pdf")
plot(jitter.income ~ jitter.age)
lines(ageval, modInc3$coef[1] + modInc3$coef[2]*ageval^2, lwd=2, col="red")
dev.off()


modall <- lm(Democracy ~ Income + Growth + EthnicHeterogeneity + BritishColony + Muslim + OPEC + Postcomm)
summary(modall)

pdf("multiSL.pdf")
plot(modall, 3, lwd=2)
dev.off()

pdf("multiQQ.pdf")
plot(modall, 2)
dev.off()

pdf("multiFR.pdf")
plot(modall, 1, lwd=2)
dev.off()

pdf("multiInf.pdf")
plot(modall, 5)
dev.off()

pdf("multiAV.pdf")
av.plot(modall, "Growth", labels=rownames(fishdata))

dev.off()


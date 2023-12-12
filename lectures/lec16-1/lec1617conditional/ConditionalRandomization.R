

#### Problem 3 ####

#install.packages("foreign")
library(foreign)
#library(xtable)
#library(car)

cong <- read.dta("basic.dta")
summary(cong)
head(cong)

## note: data should already be subsetted to 105th
## congress. if not, run

cong <- cong[cong$congress == 105,]

## A## 

my.lm <- lm(aauw ~ ngirls, data = cong)
summary(my.lm)

## B ##
## see write-up

## C ##

#pdf(file= "3c.1.pdf", width = 5, height = 5, family = "Helvetica", pointsize = 10)
plot(my.lm, 5)
#dev.off()

## also


plot(hatvalues(my.lm))
abline(h = 4/length(cong$ngirls), col = "darkred")
identify(hatvalues(my.lm))
#dev.copy(pdf, file = "3c.2.pdf", width = 5, height = 5, family = "Helvetica", pointsize = 10)
#dev.off()

plot(hatvalues(my.lm), rstudent(my.lm))
	## plots hat values against studentized residuals
abline(h = 2, col = "darkred")
abline(v = 4/length(cong$ngirls), col = "darkred")
identify(hatvalues(my.lm),  rstudent(my.lm))
#dev.copy(pdf, file= "3c.3.pdf", width = 5, height = 5, family = "Helvetica", pointsize = 10)
#dev.off()

## D ##

#pdf(file= "3d.1.pdf", width = 5, height = 5, family = "Helvetica", pointsize = 10)
plot(my.lm,2) 
#dev.off()

#pdf(file= "3d.2.pdf", width = 5, height = 5, family = "Helvetica", pointsize = 10)
hist(my.lm$residuals)
#dev.off()

## E ##

my.lm <- lm(aauw ~ ngirls + totchi, data = cong)
summary(my.lm)

a <- my.lm$coef[1] + my.lm$coef[3]*c(0,1,2,3,4,5)
b <- rep(my.lm$coef[2],6)

pdf(file= "3e.pdf", width = 5, height = 5, family = "Helvetica", pointsize = 10)
plot(cong$ngirls,cong$aauw, xlab = "Number of Girls", ylab = "AAUW scores")
for (i in 1:6) {
  abline(a[i], b[i], col = i)
}
legend(x="topleft",col=c(1:6), lty=1,
       legend=c("c = 0","c = 1", "c = 2", "c = 3", "c = 4", "c = 5"), bty="n")
dev.off()

## E ##

my.lm <- lm(aauw ~ ngirls + as.factor(totchi), data = cong)
summary(my.lm)

a <- my.lm$coef[1] + c(0,my.lm$coef[3:7])
b <- rep(my.lm$coef[2],6)

pdf(file= "WashingtonEq1.pdf", width = 5, height = 5, family = "Helvetica", pointsize = 10)
plot(cong$ngirls,cong$aauw, xlab = "Number of Girls", ylab = "AAUW scores")
for (i in 1:6) {
  abline(a[i], b[i], col = i)
}
legend(x="topleft",col=c(1:6), lty=1,
       legend=c("c = 0","c = 1", "c = 2", "c = 3", "c = 4", "c = 5"), bty="n")
dev.off()




## F ##

## for model

my.lm <- lm(aauw ~ ngirls + totchi + ngirls*totchi, data = cong)
summary(my.lm)

## for plot

a <- my.lm$coef[1] + my.lm$coef[3]*c(0,1,2,3,4,5)
b <- my.lm$coef[2] + my.lm$coef[4]*c(0,1,2,3,4,5)

pdf(file= "3f.pdf", width = 5, height = 5, family = "Helvetica", pointsize = 10)
plot(cong$ngirls,cong$aauw, xlab = "Number of Girls", ylab = "AAUW scores")
for (i in 1:6) {
  abline(a[i], b[i], col = i)
}
legend(x="topleft",col=c(1:6), lty=1,
       legend=c("c = 0","c = 1", "c = 2", "c = 3", "c = 4", "c = 5"), bty="n")
dev.off()


table(cong$totchi)/sum(table(cong$totchi))

a <- my.lm$coef[1] + my.lm$coef[3]*c(0,1,2,3,4,5)
b <- my.lm$coef[2] + my.lm$coef[4]*c(0,1,2,3,4,5)

pdf(file= "3ff.pdf", width = 5, height = 5, family = "Helvetica", pointsize = 10)
plot(cong$ngirls,cong$aauw, xlab = "Number of Girls", ylab = "AAUW scores")
for (i in 1:6) {
  abline(a[i], b[i], col = i)
  text(x=5,y=a[i]+b[i]*5+1, labels=round(table(cong$totchi)/sum(table(cong$totchi)),digits=3)[i],col=i)
}
legend(x="topleft",col=c(1:6), lty=1,
       legend=c("c = 0","c = 1", "c = 2", "c = 3", "c = 4", "c = 5"), bty="n")
dev.off()


## extra credit

plot(cong$ngirls,cong$aauw)
my.lm$coef

a <- my.lm$coef[1] + my.lm$coef[3]*c(0,1,2,3,4,5)
b <- my.lm$coef[2] + my.lm$coef[4]*c(0,1,2,3,4,5)

#pdf(file= "3fextra.pdf", width = 5, height = 5, family = "Helvetica", pointsize = 10)
plot(cong$ngirls,cong$aauw, xlab = "Number of Girls", ylab = "AAUW scores")
  segments(0,a[1],0, (a[1] + b[1]*0), col = 1)
  segments(0,a[2],1, (a[2] + b[2]*1), col = 2)
  segments(0,a[3],2, (a[3] + b[3]*2),col = 3)
  segments(0,a[4],3, (a[4] + b[4]*3),col = 4)
  segments(0,a[5],4, (a[5] + b[5]*4),col = 5)
  segments(0,a[6],5, (a[6] + b[6]*5),col = 6)
legend(x="topleft",col=c(1:6), lty=1,
       legend=c("c = 0","c = 1", "c = 2", "c = 3", "c = 4", "c = 5"), bty="n")
#dev.off()


## G ##

my.lm <- lm(aauw ~ ngirls + totchi + female + ngirls*female, data = cong)
summary(my.lm)

xtable(my.lm)


#### Extra Plots ####
pdf("1ch.pdf")
plot(cong$ngirls[cong$totchi==1],jitter(cong$aauw[cong$totchi==1]), xlab = "Number of Girls", ylab = "AAUW scores", main="1 Child Families")
abline(lm(cong$aauw[cong$totchi==1]~cong$ngirls[cong$totchi==1]),lwd=2,col="red")
dev.off()

pdf("2ch.pdf")
plot(cong$ngirls[cong$totchi==2],jitter(cong$aauw[cong$totchi==2]), xlab = "Number of Girls", ylab = "AAUW scores", main="2 Children Families")
abline(lm(cong$aauw[cong$totchi==2]~cong$ngirls[cong$totchi==2]),lwd=2,col="red")
dev.off()

pdf("3ch.pdf")
plot(cong$ngirls[cong$totchi==3],jitter(cong$aauw[cong$totchi==3]), xlab = "Number of Girls", ylab = "AAUW scores", main="3 Children Families")
abline(lm(cong$aauw[cong$totchi==3]~cong$ngirls[cong$totchi==3]),lwd=2,col="red")
dev.off()

pdf("4ch.pdf")
plot(cong$ngirls[cong$totchi==4],jitter(cong$aauw[cong$totchi==4]), xlab = "Number of Girls", ylab = "AAUW scores", main="4 Children Families")
abline(lm(cong$aauw[cong$totchi==4]~cong$ngirls[cong$totchi==4]),lwd=2,col="red")
dev.off()


## Additive vs Interactive with 1 and 2 children and binary T (at least one girl)

cong12 <- subset(cong, totchi==1 | totchi==2)
n <- dim(cong12)[1]
cong12$anygirls <- cong12$ngirls > 0
cong12$twochi <- cong12$totchi==2
n2 <- sum(cong12$twochi)
n1 <- n - n2


lm(aauw ~ anygirls + twochi,data=cong12)


lm(aauw ~ anygirls * twochi ,data=cong12)

lm(aauw ~ anygirls * I(twochi - mean(twochi)) ,data=cong12)

mod <- lm(aauw ~ anygirls * twochi ,data=cong12)
mod$coef[2] + mod$coef[4]*mean(cong12$twochi)


p0 <- (1-mean(cong12$twochi))


p1 <- mean(cong12$twochi)


mod$coef[2]*p0 + sum(mod$coef[c(2,4)])*p1

w0 <- p0*mean(cong12$anygirls[cong12$twochi==0])*
(1-mean(cong12$anygirls[cong12$twochi==0]))
w1 <- p1*mean(cong12$anygirls[cong12$twochi==1])*
(1-mean(cong12$anygirls[cong12$twochi==1]))


mod$coef[2]*(w0/(w0+w1)) + sum(mod$coef[c(2,4)])*(w1/(w0+w1))



## Additive vs Interactive with 1 and 2 children

cong12 <- subset(cong, totchi==1 | totchi==2)


lm(aauw ~ ngirls + totchi,data=cong12)


lm(aauw ~ ngirls * totchi ,data=cong12)




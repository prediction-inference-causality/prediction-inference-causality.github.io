EMdata <- read.table("EpstMershData.txt",    
                     header=TRUE)
EMdata <- na.omit(EMdata)
attach(EMdata)

## aggregate liberal votes on Civ. Lib. regressed on Segal Cover scores
loess.cl1 <- loess(CLlib~SCscore, data=EMdata, degree=1, span=0.95)
loess.cl2 <- loess(CLlib~SCscore, data=EMdata, degree=1, span=0.65)
loess.cl3 <- loess(CLlib~SCscore, data=EMdata, degree=1, span=0.45)
loess.cl4 <- loess(CLlib~SCscore, data=EMdata, degree=2, span=0.95)
loess.cl5 <- loess(CLlib~SCscore, data=EMdata, degree=2, span=0.65)
loess.cl6 <- loess(CLlib~SCscore, data=EMdata, degree=2, span=0.45)
lm.cl <- lm(CLlib~SCscore, data=EMdata)

## degree = 1
plot(SCscore, CLlib)
lines(0:100/100, predict(loess.cl1, newdata=0:100/100), col="red", lwd=2)
lines(0:100/100, predict(loess.cl2, newdata=0:100/100), col="blue", lwd=2)
lines(0:100/100, predict(loess.cl3, newdata=0:100/100), col="black", lwd=2)
abline(lm.cl, col="orange", lwd=2)

## degree = 2
plot(SCscore, CLlib)
lines(0:100/100, predict(loess.cl4, newdata=0:100/100), col="red", lwd=2)
lines(0:100/100, predict(loess.cl5, newdata=0:100/100), col="blue", lwd=2)
lines(0:100/100, predict(loess.cl6, newdata=0:100/100), col="black", lwd=2)
abline(lm.cl, col="orange", lwd=2)

library(mgcv)
plot(gam(CLlib~s(SCscore), data=EMdata))


## aggregate liberal votes on Federalism regressed on Segal Cover scores
loess.fed1 <- loess(Fedlib~SCscore, data=EMdata, degree=1, span=0.95)
loess.fed2 <- loess(Fedlib~SCscore, data=EMdata, degree=1, span=0.65)
loess.fed3 <- loess(Fedlib~SCscore, data=EMdata, degree=1, span=0.45)
loess.fed4 <- loess(Fedlib~SCscore, data=EMdata, degree=2, span=0.95)
loess.fed5 <- loess(Fedlib~SCscore, data=EMdata, degree=2, span=0.65)
loess.fed6 <- loess(Fedlib~SCscore, data=EMdata, degree=2, span=0.45)
lm.fed <- lm(Fedlib~SCscore, data=EMdata)

## degree = 1
plot(SCscore, Fedlib)
lines(0:100/100, predict(loess.fed1, newdata=0:100/100), col="red", lwd=2)
lines(0:100/100, predict(loess.fed2, newdata=0:100/100), col="blue", lwd=2)
lines(0:100/100, predict(loess.fed3, newdata=0:100/100), col="black", lwd=2)
abline(lm.fed, col="orange", lwd=2)

## degree = 2
plot(SCscore, Fedlib)
lines(0:100/100, predict(loess.fed4, newdata=0:100/100), col="red", lwd=2)
lines(0:100/100, predict(loess.fed5, newdata=0:100/100), col="blue", lwd=2)
lines(0:100/100, predict(loess.fed6, newdata=0:100/100), col="black", lwd=2)
abline(lm.fed, col="orange", lwd=2)

plot(gam(Fedlib~s(SCscore), data=EMdata))



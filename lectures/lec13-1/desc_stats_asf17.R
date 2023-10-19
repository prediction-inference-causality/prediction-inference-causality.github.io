# descriptive statistics with ASF Data

load("asf17.RData")

View(asf17)
plot(asf17$Estimated.Attendance,asf17$Actual.Attendance)

asf17s <- subset(asf17,Actual.Attendance < 5000)

plot(asf17s$Estimated.Attendance,asf17s$Actual.Attendance)
asf.lm <- lm(Actual.Attendance ~ Estimated.Attendance, data=asf17s)
abline(asf.lm)

summary(asf.lm)

plot(asf.lm,which=1)
plot(asf.lm,which=2)

asf.lm2 <- lm(Actual.Attendance ~ Estimated.Attendance + I(Estimated.Attendance^2), data=asf17s)
x <- seq(0,1000,1)
lines(x,-42 + 2.35*x  - .00152*x^2)

asf.lm3 <- lm(Actual.Attendance ~ Estimated.Attendance + I(Estimated.Attendance^2) + I(Estimated.Attendance^3), data=asf17s)
x <- seq(0,1000,1)
lines(x,asf.lm3$coef[1] + asf.lm3$coef[2]*x + asf.lm3$coef[3]*x^2 + asf.lm3$coef[4]*x^3)



# cross validation

n <- dim(asf17s)[1]
dev <- rep(0,n)
for(i in 1:n){
  asf.lm.temp <- lm(Actual.Attendance ~ Estimated.Attendance, data=asf17s[-i,])
  dev[i] <-asf17s[i,]$Actual.Attendance - predict(asf.lm.temp,newdata = asf17s[i,])
}
mean(dev^2)

n <- dim(asf17s)[1]
dev <- rep(0,n)
for(i in 1:n){
  asf.lm.temp <- lm(Actual.Attendance ~ Estimated.Attendance + I(Estimated.Attendance^2), data=asf17s[-i,])
  dev[i] <-asf17s[i,]$Actual.Attendance - predict(asf.lm.temp,newdata = asf17s[i,])
}
mean(dev^2)

n <- dim(asf17s)[1]
dev <- rep(0,n)
for(i in 1:n){
  asf.lm.temp <- lm(Actual.Attendance ~ Estimated.Attendance + I(Estimated.Attendance^2) + I(Estimated.Attendance^3), data=asf17s[-i,])
  dev[i] <-asf17s[i,]$Actual.Attendance - predict(asf.lm.temp,newdata = asf17s[i,])
}
mean(dev^2)


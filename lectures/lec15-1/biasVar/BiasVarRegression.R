
# Population
N <- 10000
x <- rnorm(N,mean=4,sd=1)
y <- -2*x + .5*x^2 + rnorm(N)
pdf("Population.pdf")
plot(x,y,xlim=c(0,8),ylim=c(-5,15),main="Population")
lines(seq(0,8,.1),-2*seq(0,8,.1) + .5*seq(0,8,.1)^2, col="red")
abline(v=4,col="red")
abline(lm(y~x),col="green")
dev.off()

# f(4) = 0
-2*4 + .5*4^2


# Observed Data
set.seed(123)
n <- 3
i <- sample(1:N,size=n,replace = TRUE)
pdf("Sample.pdf")
plot(x[i],y[i],xlim=c(0,8),ylim=c(-5,15))
abline(v=4,col="red")
abline(lm(y[i]~x[i]),col="green")
quad <- lm(y[i]~x[i]+I(x[i]^2))
lines(seq(0,8,.1),quad$coef[1] + quad$coef[2]*seq(0,8,.1) + quad$coef[3]*seq(0,8,.1)^2, col="red")
dev.off()

# Sampling Distributions
S <- 10000
fhat.lin <- rep(0,S)
fhat.quad <- rep(0,S)
n <- 3
for(s in 1:S){
	i <- sample(1:N,size=3,replace = TRUE)
	lin <- lm(y[i]~x[i])
	fhat.lin[s] <- lin$coef[1] + lin$coef[2]*4
	quad <- lm(y[i]~x[i]+I(x[i]^2))
	fhat.quad[s] <- quad$coef[1] + quad$coef[2]*4 + quad$coef[3]*(4^2)	
}
pdf("SamplingDistributions.pdf")
plot(density(fhat.lin[fhat.lin > -10 & fhat.lin < 10]),col="green",main="Sampling Distributions",xlab="fhat(4)")
lines(density(fhat.quad[fhat.quad > -10 & fhat.quad < 10 & !is.na(fhat.quad)]),col="red")
abline(v=0,col="red")
dev.off()


#Bias
mean(fhat.lin[fhat.lin > -10 & fhat.lin < 10])
mean(fhat.quad[fhat.quad > -10 & fhat.quad < 10],na.rm=TRUE)

#Var
var(fhat.lin[fhat.lin > -10 & fhat.lin < 10])
var(fhat.quad[fhat.quad > -10 & fhat.quad < 10],na.rm=TRUE)






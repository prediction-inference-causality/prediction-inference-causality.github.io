## Simulations to Demonstrate Unbiasedness and Variance

# Simulation 1: matches tables in lecture notes using the normal distribution
n <- 625
smeans <- rep(NA, n)
S <- 10000
for (s in 1:S){
	smeans[s] <- mean(rnorm(n=n,mean=45,sd=5))	
}

mean(smeans) # matches the mean of the normal (45)
var(smeans) # matches the derived variance of the sample means 25/625

#Simulation 2: doesn't match table, but shows unbiasedness and variance for a different distribution
n <- 625
smeans <- rep(NA, n)
S <- 10000
for (s in 1:S){
	smeans[s] <- mean(rexp(n=n,rate=1/4)) # mean of 4 and variance of 16
}

mean(smeans) # matches the mean of the exponential distribution (4)
var(smeans) # matches the derived variance of the sample means 16/625



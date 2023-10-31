# Confidence Intervals with Infinite Population
S <- 10000
n <- 625

CIbounds <- matrix(nrow=S,ncol=2)
for(s in 1:S){
	temp.dat <- rnorm(n=n,45,5)
	m <- mean(temp.dat)
	se.hat <- sd(temp.dat)/sqrt(n)
	CIbounds[s,] <- c(m - 1.96*se.hat,m+1.96*se.hat)
}

mean(CIbounds[,1] <= 45 & CIbounds[,2] >= 45) # approximately 95%

# Unbiasedness and Confidence Intervals with Finite Population
N <- 700000 # Approximate population of a 2nd tier US city
pop <- rnorm(n=N,mean=45,sd=5)

mean(pop)

S <- 10000
n <- 625
smeans <- rep(NA,S)
for(s in 1:S){
	smeans[s] <- mean(sample(pop,size=n,replace=T))
}

mean(smeans) # approximately equal to mean(pop) shows unbiasedness

CIbounds <- matrix(nrow=S,ncol=2)
for(s in 1:S){
	temp.dat <- sample(pop,size=n,replace=T)
	m <- mean(temp.dat)
	se.hat <- sd(temp.dat)/sqrt(n)
	CIbounds[s,] <- c(m - 1.96*se.hat,m+1.96*se.hat)	
}

mean(CIbounds[,1] <= mean(pop) & CIbounds[,2] >= mean(pop)) # approximately 95%

# Finite Population CIs w/ bootstrapping (Two Ways) (Larger S will, on average, get closer to 95%, but take longer to run. Larger B will also help for the quantile method, but take longer to run.)
N <- 700000
pop <- rnorm(n=N,mean=45,sd=5)

mean(pop)

S <- 400
n <- 625
B <- 2000
# SE method

CIbounds <- matrix(nrow=S,ncol=2)
for(s in 1:S){
	temp.dat <- sample(pop,size=n,replace=T)
	m <- mean(temp.dat)
	boot.m <- replicate(B,mean(sample(temp.dat,replace=T)))
	boot.se <- sd(boot.m)
	CIbounds[s,] <- c(m - 1.96*boot.se,m+1.96*boot.se)	
}

mean(CIbounds[,1] <= mean(pop) & CIbounds[,2] >= mean(pop)) 

# Quantile method

CIbounds <- matrix(nrow=S,ncol=2)
for(s in 1:S){
	temp.dat <- sample(pop,size=n,replace=T)
	boot.m <- replicate(B,mean(sample(temp.dat,replace=T)))
	CIbounds[s,] <- quantile(boot.m,probs=c(.025,.975))	
}

mean(CIbounds[,1] <= mean(pop) & CIbounds[,2] >= mean(pop))









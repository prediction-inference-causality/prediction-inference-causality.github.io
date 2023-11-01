qog <- read.csv("qog_std_cs_jan22.csv") # read in the data
dim(qog) # check number of observations and variables

qog[1:20,c("wdi_mortinf","who_dwtot","wdi_acel","mad_gdppc")] # check for NAs for selected variables

qogC <- na.omit(qog[,c("wdi_mortinf","who_dwtot","wdi_acel")]) # remove observations with NAs
dim(qogC) # check new number of observations
N <- dim(qogC)[1]

qogC <- na.omit(qog[,c("wdi_mortinf","who_dwtot","wdi_acel","mad_gdppc")]) # remove observations with NAs
dim(qogC) # check new number of observations
N <- dim(qogC)[1]

qogC$per_gdppc <- qogC$mad_gdppc/max(qogC$mad_gdppc)*100

attach(qogC)

lm(wdi_mortinf ~ who_dwtot + wdi_acel + per_gdppc)
lm(wdi_mortinf ~ per_gdppc)

lm(wdi_mortinf ~ who_dwtot )

lm(wdi_mortinf ~ who_dwtot + wdi_acel)

par(mfrow=c(1,2))
plot(wdi_mortinf ~ who_dwtot,pch=19) # plot infant mortality on clean drinking water
abline(lm(wdi_mortinf ~ who_dwtot),col="blue") # add regression line

lm(wdi_mortinf ~ who_dwtot) # check slope of regression line
lm(wdi_mortinf ~ who_dwtot+wdi_acel) # control for electrification and check new slope for water

plot(who_dwtot ~ wdi_acel,pch=19) # check relationship between water and electrification
abline(lm(who_dwtot ~ wdi_acel))# add regression line

r_xz <- residuals(lm(who_dwtot ~ wdi_acel)) # remove electrification from water
lm(qogC$wdi_mortinf ~ r_xz) # confirm that slope for water matches slope for water from multiple regression

plot(r_xz,qogC$wdi_mortinf,pch=19) # create plot with electrification removed
abline(lm(qogC$wdi_mortinf ~r_xz),col="blue") # add line 

n <- 12 
set.seed(1234)
sam.ind <- sample(1:N,size=n,replace=TRUE)

par(mfrow=c(1,2))
plot(wdi_mortinf ~ who_dwtot, data=qogC) # plot infant mortality on clean drinking water
abline(lm(wdi_mortinf ~ who_dwtot, data=qog),col="blue") # add regression line
points(who_dwtot[sam.ind],wdi_mortinf[sam.ind],pch=19,col="red")
abline(lm(wdi_mortinf[sam.ind] ~ who_dwtot[sam.ind], data=qog),col="red") # add regression line

plot(r_xz,wdi_mortinf) # create plot with electrification removed
abline(lm(wdi_mortinf ~r_xz),col="blue") # add line 
points(r_xz[sam.ind],wdi_mortinf[sam.ind],pch=19,col="red")
abline(lm(wdi_mortinf[sam.ind] ~r_xz[sam.ind]),col="red") # add line 

S <- 10000
beta1simple <- rep(NA,S)
beta1multiple <- rep(NA,S)
set.seed(1234)
for(s in 1:S){
	sam.ind <- sample(1:N,size=n,replace=TRUE)
	beta1simple[s] <- lm(wdi_mortinf[sam.ind] ~ who_dwtot[sam.ind])$coef[2]
	beta1multiple[s] <- lm(wdi_mortinf[sam.ind] ~ who_dwtot[sam.ind] + wdi_acel[sam.ind])$coef[2]
}

mean(beta1simple)
mean(beta1multiple)

set.seed(1234)
for(s in 1:3){
	sam.ind <- sample(1:N,size=n,replace=TRUE)
	print(qogC[sam.ind,])
}

beta1simple[1:3]
beta1multiple[1:3]

# omitted variable bias
 
lm(wdi_mortinf ~ who_dwtot)$coef[2]  - lm(wdi_mortinf ~ who_dwtot+wdi_acel)$coef[2] 

lm(wdi_mortinf ~ who_dwtot+wdi_acel)$coef[3]*lm(wdi_acel ~ who_dwtot)$coef[2] 


qog <- read.csv("qog_std_cs_jan22.csv") # read in the data
dim(qog) # check number of observations and variables

qog[1:20,c("wdi_mortinf","who_dwtot","wdi_acel")] # check for NAs for selected variables
summary(qog[,c("wdi_mortinf","who_dwtot","wdi_acel")])

is.na(qog[,c("wdi_mortinf","wdi_acel")]) # where are the NAs for wdi_mortinf wdi_acel

qogC <- qog[-c(38,100),c("wdi_mortinf","who_dwtot","wdi_acel")] # remove observations with NAs for wdi_mortinf and wdi_acel.
dim(qogC) # check new number of observations
N <- dim(qogC)[1]

summary(qogC$who_dwtot) # check missingness in who_dwtot

mean(qogC$who_dwtot,na.rm=T) # mean with NAs removed

qogC$imp_dwtot <- qogC$who_dwtot
qogC$imp_dwtot[is.na(qogC$who_dwtot)] <- 100
mean(qogC$imp_dwtot)

qogC$imp_dwtot[is.na(qogC$who_dwtot)] <- 0
mean(qogC$imp_dwtot)


lm(qogC$wdi_mortinf ~ qogC$who_dwtot) # slope with NAs removed

qogC$imp_dwtot[is.na(qogC$who_dwtot)] <- 0
lm(qogC$wdi_mortinf ~ qogC$imp_dwtot)
qogC$imp_dwtot[is.na(qogC$who_dwtot)] <- 100
lm(qogC$wdi_mortinf ~ qogC$imp_dwtot)



summary(lm(who_dwtot ~ wdi_acel,data=qogC))

plot(who_dwtot ~ wdi_acel,pch=19,ylim=c(0,100)) # check relationship between water and electrification
abline(lm(who_dwtot ~ wdi_acel),col="red",lwd=1.5)# add regression line
points(x=qogC$wdi_acel[is.na(qogC$who_dwtot)],y=rep(0,sum(is.na(qogC$who_dwtot))),pch=2)

mod <- lm(who_dwtot ~ wdi_acel)
predict(mod,newdata = qogC[is.na(qogC$who_dwtot),])
points(x=qogC$wdi_acel[is.na(qogC$who_dwtot)],y=predict(mod,newdata = qogC[is.na(qogC$who_dwtot),]),pch=2,col="red")

library(mgcv)

mod1 <- gam(who_dwtot ~ s(wdi_acel), data=qogC)
wdi_acel.plot.vec <- seq(0,100,.1)
wdi_acel.plot <- data.frame(wdi_acel = wdi_acel.plot.vec)
lines(seq(0,100,.1),predict(mod1,newdata=wdi_acel.plot),col="blue",lwd=1.5)
points(x=qogC$wdi_acel[is.na(qogC$who_dwtot)],y=predict(mod1,newdata = qogC[is.na(qogC$who_dwtot),]),pch=2,col="blue")

# Means of who_dwtot

mean(qogC$who_dwtot,na.rm=T) 

qogC$imp_dwtot[is.na(qogC$who_dwtot)] <- 100
mean(qogC$imp_dwtot)

qogC$imp_dwtot[is.na(qogC$who_dwtot)] <- 0
mean(qogC$imp_dwtot)

qogC$imp_dwtot[is.na(qogC$who_dwtot)] <- predict(mod,newdata = qogC[is.na(qogC$who_dwtot),])
mean(qogC$imp_dwtot)

qogC$imp_dwtot[is.na(qogC$who_dwtot)] <- predict(mod1,newdata = qogC[is.na(qogC$who_dwtot),])
mean(qogC$imp_dwtot)

# Slopes

lm(qogC$wdi_mortinf ~ qogC$who_dwtot) 

qogC$imp_dwtot[is.na(qogC$who_dwtot)] <- 0
lm(qogC$wdi_mortinf ~ qogC$imp_dwtot)

qogC$imp_dwtot[is.na(qogC$who_dwtot)] <- 100
lm(qogC$wdi_mortinf ~ qogC$imp_dwtot)

qogC$imp_dwtot[is.na(qogC$who_dwtot)] <- predict(mod,newdata = qogC[is.na(qogC$who_dwtot),])
lm(qogC$wdi_mortinf ~ qogC$imp_dwtot)
plot(qogC$imp_dwtot,qogC$wdi_mortinf,type="n")
points(qogC[!is.na(qogC$who_dwtot),]$imp_dwtot,qogC[!is.na(qogC$who_dwtot),]$wdi_mortinf,pch=19)
points(qogC[is.na(qogC$who_dwtot),]$imp_dwtot,qogC[is.na(qogC$who_dwtot),]$wdi_mortinf,pch=2,col="red")
abline(lm(qogC$wdi_mortinf ~ qogC$imp_dwtot),col="red")


qogC$imp_dwtot[is.na(qogC$who_dwtot)] <- predict(mod1,newdata = qogC[is.na(qogC$who_dwtot),])
lm(qogC$wdi_mortinf ~ qogC$imp_dwtot)
points(qogC[is.na(qogC$who_dwtot),]$imp_dwtot,qogC[is.na(qogC$who_dwtot),]$wdi_mortinf,pch=2,col="blue")
abline(lm(qogC$wdi_mortinf ~ qogC$imp_dwtot),col="blue")



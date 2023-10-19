qog <- read.csv("qog_std_cs_jan22.csv") # read in the data
dim(qog) # check number of observations and variables

qog[1:20,c("wdi_mortinf","who_dwtot","wdi_acel")] # check for NAs for selected variables

qogC <- na.omit(qog[,c("wdi_mortinf","who_dwtot","wdi_acel")]) # remove observations with NAs
dim(qogC) # check new number of observations

plot(wdi_mortinf ~ who_dwtot, data=qogC,pch=19) # plot infant mortality on clean drinking water
abline(lm(wdi_mortinf ~ who_dwtot, data=qog)) # add regression line

lm(wdi_mortinf ~ who_dwtot, data=qogC) # check slope of regression line
lm(wdi_mortinf ~ who_dwtot+wdi_acel, data=qogC) # control for electrification and check new slope for water

plot(who_dwtot ~ wdi_acel, data=qogC,pch=19) # check relationship between water and electrification
abline(lm(who_dwtot ~ wdi_acel, data=qogC))# add regression line

r_xz <- residuals(lm(who_dwtot ~ wdi_acel, data=qogC)) # remove electrification from water
lm(qogC$wdi_mortinf ~ r_xz) # confirm that slope for water matches slope for water from multiple regression

r_yz <- residuals(lm(wdi_mortinf ~ wdi_acel, data=qogC)) # remove electrification from infant mortality
lm(r_yz ~r_xz) # confirm that slope for water matches slope for water from multiple regression

r_av <- residuals(lm(r_yz~r_xz)) # get residuals from regression with electrification removed
r_yxz <- residuals(lm(wdi_mortinf ~ who_dwtot+wdi_acel, data=qogC)) # get residuals from multiple regression

cbind(r_yxz,r_av) # confirm that they look equal
range(abs(r_yxz-r_av)) # confirm that they are all equal

plot(r_xz,r_yz) # create plot with electrification removed
abline(lm(r_yz ~r_xz)) # add line 



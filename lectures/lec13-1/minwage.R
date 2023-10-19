## ------------------------------------------------------------------------
minwage <- read.csv("minwage.csv") # load the data

dim(minwage) # dimension of data
summary(minwage) # summary of data
head(minwage)

## subsetting the data into two states
minwageNJ <- subset(minwage, subset = (location != "PA"))
minwagePA <- subset(minwage, subset = (location == "PA"))

## proportion of restaurants whose wage is less than $5.05
mean(minwageNJ$wageBefore < 5.05) # NJ before 
mean(minwageNJ$wageAfter < 5.05)  # NJ after 
mean(minwagePA$wageBefore < 5.05) # PA before 
mean(minwagePA$wageAfter < 5.05)  # PA after 

## create a variable for proportion of full-time employees in NJ and PA
minwageNJ$fullPropAfter <- minwageNJ$fullAfter / 
    (minwageNJ$fullAfter + minwageNJ$partAfter)
minwagePA$fullPropAfter <- minwagePA$fullAfter / 
    (minwagePA$fullAfter + minwagePA$partAfter)

## compute the difference in means
mean(minwageNJ$fullPropAfter) - mean(minwagePA$fullPropAfter)

## with regression

minwage$fullPropAfter <- minwage$fullAfter / 
    (minwage$fullAfter + minwage$partAfter)

lm(fullPropAfter ~ I(location != "PA"),data = minwage)

## ------------------------------------------------------------------------
prop.table(table(minwageNJ$chain))
prop.table(table(minwagePA$chain))

## subset Burger King only
minwageNJ.bk <- subset(minwageNJ, subset = (chain == "burgerking"))
minwagePA.bk <- subset(minwagePA, subset = (chain == "burgerking"))

## comparison of full-time employment rates
mean(minwageNJ.bk$fullPropAfter) - mean(minwagePA.bk$fullPropAfter)

## subset Wendys only
minwageNJ.w <- subset(minwageNJ, subset = (chain == "wendys"))
minwagePA.w <- subset(minwagePA, subset = (chain == "wendys"))

## comparison of full-time employment rates
mean(minwageNJ.w$fullPropAfter) - mean(minwagePA.w$fullPropAfter)


## with regression controlling for chain

lm(fullPropAfter ~ I(location != "PA") + chain,data = minwage)


## with interactive regression controlling for chain

lm(fullPropAfter ~ I(location != "PA") * chain,data = minwage)




## ------------------------------------------------------------------------
## full-time employment proportion in the previous period for NJ
minwageNJ$fullPropBefore <- minwageNJ$fullBefore / 
    (minwageNJ$fullBefore + minwageNJ$partBefore)

## mean difference between before and after the minimum wage increase
NJdiff <- mean(minwageNJ$fullPropAfter) - mean(minwageNJ$fullPropBefore)
NJdiff

## full-time employment proportion in the previous period for PA
minwagePA$fullPropBefore <- minwagePA$fullBefore / 
    (minwagePA$fullBefore + minwagePA$partBefore)
## mean difference between before and after for PA
PAdiff <- mean(minwagePA$fullPropAfter) - mean(minwagePA$fullPropBefore)
## difference-in-differences
NJdiff - PAdiff


## regression approach to DiD

minwage$fullPropBefore <- minwage$fullBefore / 
    (minwage$fullBefore + minwage$partBefore)

lm(I(fullPropAfter - fullPropBefore)  ~ I(location != "PA"),data = minwage)


minwageTall <- rbind(minwage,minwage)

n0 <- dim(minwage)[1]
dim(minwageTall)

minwageTall$after <- c(rep(0,n0),rep(1,n0))
minwageTall$fullProp <- minwageTall$after * minwageTall$fullPropAfter + (1-minwageTall$after) * minwageTall$fullPropBefore

lm(fullProp ~ I(location != "PA") * after,data = minwageTall)


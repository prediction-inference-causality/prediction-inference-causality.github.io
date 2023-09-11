#### QTM 220 Lecture 5 R code ####

library(foreign)
library(ggplot2)
setwd("~/Documents") #different for each user

library(foreign)library(ggplot2)theme_update(plot.title = element_text(hjust = 0.5))library(tinytex)library(gridExtra)#students change working directory? #setwd("/Users/acuttne/Documents/GitHub/qtm220/lectures/lec1")# for cps variable interpretation see https://www2.census.gov/programs-surveys/cps/datasets/2022/march/asec2022_ddl_pub_full.pdfcensus.api.key = '8084f81e4f71e4d32638dac15f188b424f72d063'library(cpsR)library(dplyr)library(magrittr)#library(kableExtra)library(scales)#cps.data = cpsR::get_asec(year=2022, vars=c('h_numper', 'htotval', 'a_age', 'a_hga'), key=census.api.key)cps.data = cpsR::get_asec(year=2022, vars=c('h_numper', 'htotval', 'a_age', 'a_hga','gereg','gestfips', 'a_maritl', 'a_sex','peafever','a_wkstat'), key=census.api.key)all.earnings = data.frame(state.code = cps.data$gestfips, age=cps.data$a_age,                         income=cps.data$htotval,                           education=case_match(cps.data$a_hga,                                          0  ~ 0,   # child                                          31 ~ 0,   # < grade 1                                        32 ~ 4,   #  grade 1-4                                         33 ~ 6,   #  grade 5-6                                         34 ~ 8,   #  grade 7-8                                           35 ~ 9,   #  grade 9                                          36 ~ 10,  #  grade 10                                          37 ~ 11,  #  grade 11                                         38 ~ 11,  #  grade 12 no diploma                                          39 ~ 12,  #  high school grad                                         40 ~ 13,  #  some college                                        41 ~ 14,  #  associate degree(vocational)                                         42 ~ 14,  #  associate degree (academic)                                          43 ~ 16,  #  bachelors degree                                           44 ~ 18,  #  masters degree                                          45 ~ 20,  #  professional school degree                                          46 ~ 20)) #  doctorate#in.interval = function(X, interval) { interval[1] <= X & X <= interval[2] }#earnings = all.earnings[all.earnings$age %>% in.interval(c(25,35)) &                         #all.earnings$education >= 11, ]all.earnings$employed<- ifelse(cps.data$a_wkstat >5, 0,ifelse(cps.data$a_wkstat<2,NA,1))earnings <- subset(all.earnings,state.code==6&age>24&age <36&education >8&income<1000000)earnings$raw.income = earnings$incomeearnings$degree = factor(earnings$education >= 16,                     levels=c(FALSE, TRUE),                     labels=c('no 4-year degree','4-year degree')) rownames(earnings)=NULLearnings$fouryrdegree<- ifelse(earnings$degree=="4-year degree", 1,0)
attach(earnings) ggplot(earnings, aes(x=income)) +  geom_histogram(aes(y=..density..), colour="black", fill="blue")+ geom_density(alpha=.2, colour="red") + geom_rug(aes(income, y = NULL)) + ggtitle("Histogram of Income")  

pdf("GitHub/qtm220/lectures/lec5ag/figs/fouryrdegree.pdf")
ggplot(earnings, aes(x=fouryrdegree, y=income)) + geom_point(shape=1) +  geom_point(aes(y=mean(income[fouryrdegree==0]),x=0),colour="red",shape=17,size=3) + geom_point(aes(y=mean(income[fouryrdegree==1]),x=1),colour="red",shape=17,size=3) + geom_smooth(method = "lm", se=FALSE, colour="red", linetype="dashed")
dev.off()

B = 10000
bootsubsamMean = rep(NA,B)
bootdiffsamMean = rep(NA,B)
for( b in 1:B ){
bootind = sample(1:2246,size=2246,replace=T)
dfboot = earnings[bootind,]
bootsubsamMean[b] = mean(dfboot$income[dfboot$degree== "4-year degree"])
bootdiffsamMean[b] = mean(dfboot$income[dfboot$degree== "4-year degree"]) - mean(dfboot$income[dfboot$degree== "no 4-year degree"])
}

pdf("GitHub/qtm220/lectures/lec5ag/figs/bootdistSub.pdf")
hist(bootsubsamMean,main="Bootstrapped Sampling Distribution of Subsample Mean")
dev.off()

quantile(bootsubsamMean,prob=c(.025,.975))
mean(earnings$income[earnings$degree=="4-year degree"]) + c(-1,1)*1.96*sqrt(var(earnings$income[earnings$degree=="4-year degree"])/951)

pdf("GitHub/qtm220/lectures/lec5ag/figs/bootdistDiff.pdf")
hist(bootdiffsamMean,main="Bootstrapped Sampling Distribution of Difference")
dev.off()

quantile(bootdiffsamMean,prob=c(.025,.975))
mean(earnings$income[earnings$degree=="4-year degree"])- mean(earnings$income[earnings$degree=="no 4-year degree"]) + c(-1,1)*1.96*sqrt(var(earnings$income[earnings$degree=="4-year degree"])/951 + var(earnings$income[earnings$degree=="4-year degree"])/1295)



### Turnout Stuff ###

# Generate Population Data
N = 7233584

b0 = floor(.7*N)
b1 = ceiling(.3*N)
y0 = rbinom(n=b0,size=1,prob=.68)
y1 = rbinom(n=b1,size=1,prob=.74)
y = c(y0,y1)
x = c(rep(0,b0),rep(1,b1))
dfpop = data.frame(y,x)
mean(dfpop$y)
mean(dfpop$y[dfpop$x==1])

# Generate Sample Data
set.seed(111)
ind = sample(1:N,size=625,replace=T)
dfsam = dfpop[ind,]
mean(dfsam$y)
mean(dfsam$x)
mean(dfsam$y[dfsam$x==1]) -
mean(dfsam$y[dfsam$x==0])
mean(dfsam$x)

# Generate Sampling Distribution
S = 10000
subsamMean = rep(NA,S)
diffMean = rep(NA,S)
for( s in 1:S ){
	ind = sample(1:N,size=625,replace=T)
	dfind = dfpop[ind,]
	subsamMean[s] = mean(dfind$y[dfind$x==1])
	diffMean[s] = mean(dfind$y[dfind$x==1])-mean(dfind$y[dfind$x==0])	
}
pdf("GitHub/qtm220/lectures/lec4/figs/samdistSub.pdf")
hist(subsamMean,main="Sampling Distribution of Subsample Mean")
dev.off()

pdf("GitHub/qtm220/lectures/lec4/figs/samdistDiff.pdf")
hist(diffMean,main="Sampling Distribution of Difference")
dev.off()


B = 10000
bootsubsamMean = rep(NA,B)
bootdiffsamMean = rep(NA,B)
for( b in 1:B ){
bootind = sample(1:625,size=625,replace=T)
dfboot = dfsam[bootind,]
bootsubsamMean[b] = mean(dfboot$y[dfboot$x==1])
bootdiffsamMean[b] = mean(dfboot$y[dfboot$x==1]) - mean(dfboot$y[dfboot$x==0])
}

pdf("GitHub/qtm220/lectures/lec4/figs/bootdistSub.pdf")
hist(bootsubsamMean,main="Bootstrapped Sampling Distribution of Subsample Mean")
dev.off()

pdf("GitHub/qtm220/lectures/lec4/figs/bootdistDiff.pdf")
hist(bootdiffsamMean,main="Bootstrapped Sampling Distribution of Difference")
dev.off()


pdf("GitHub/qtm220/lectures/lec4/figs/bootdistvssamdistSub.pdf")
par(mfrow=c(2,1))
hist(subsamMean,xlim=c(.60,.85),main="Sampling Distribution of Subsample Mean")
hist(bootsubsamMean,xlim=c(.60,.85),main="Bootstrapped Sampling Distribution of Subsample Mean")
dev.off()

pdf("GitHub/qtm220/lectures/lec4/figs/bootdistvssamdistDiff.pdf")
par(mfrow=c(2,1))
hist(diffMean,xlim=c(-.10,.25),main="Sampling Distribution of Difference")
hist(bootdiffsamMean,xlim=c(-.10,.25),main="Bootstrapped Sampling Distribution of Difference")
dev.off()

quantile(bootsubsamMean,prob =c(.025,.975))

quantile(bootdiffsamMean,prob =c(.05,.95))
quantile(bootdiffsamMean,prob =c(.025,.975))
quantile(bootdiffsamMean,prob =c(.005,.995))
quantile(bootdiffsamMean,prob =c(.0005,.9995))


summary(lm(y~x,data=dfsam))
sd(bootdiffsamMean)

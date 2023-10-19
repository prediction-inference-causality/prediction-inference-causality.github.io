# ASF univariate analysis #


asf17new <- read.csv("2018_2017 ASF Events for Data Analysis - 2017 new events.csv")
asf17repeat <- read.csv("2018_2017 ASF Events for Data Analysis - 2017 repeat events.csv")

View(asf17new)  
View(asf17repeat)

asf17 <- rbind(asf17repeat,asf17new)
asf17 <- na.omit(asf17)
View(asf17)  
dim(asf17)
dim(asf17new)
dim(asf17repeat)


asf17$Act_Est <- asf17$Actual.Attendance - asf17$Estimated.Attendance

summary(asf17$Act_Est)
hist(asf17$Act_Est)
plot(density(asf17$Act_Est))
plot(asf17$Estimated.Attendance,asf17$Actual.Attendance)  

asf17 <- subset(asf17,Actual.Attendance < 5000)


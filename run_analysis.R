mfNames <- read.table("UCI HAR Dataset/features.txt",row.names=1)

dfTest <- read.table("UCI HAR Dataset/test/X_test.txt",col.names=mfNames[,1])

dfTest$stanceNumber <- read.table("UCI HAR Dataset/test/y_test.txt",col.names = c('Stance.Number'))[,1]

stanceMap <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")

dfTest$stanceName <- sapply(dfTest$stanceNumber,function(x) stanceMap[x])

colnames(dfTest)[563] <- 'Stance'

dfTest$subject <- read.table("UCI HAR Dataset/test/subject_test.txt",col.names = c("Subject"))[,1]




dfTrain <- read.table("UCI HAR Dataset/train/X_train.txt",col.names=mfNames[,1])

dfTrain$stanceNumber <- read.table("UCI HAR Dataset/train/y_train.txt",col.names = c('Stance.Number'))[,1]


dfTrain$stanceName <- sapply(dfTrain$stanceNumber,function(x) stanceMap[x])

colnames(dfTrain)[563] <- 'Stance'

dfTrain$subject <- read.table("UCI HAR Dataset/train/subject_train.txt",col.names = c("Subject"))[,1]

dfDataSet <- rbind(dfTest,dfTrain)

dfDataSet <- dfDataSet[c(1:6,41:46,81:86,121:126,161:166,201,202,214,215,227,228,240,241,253,254,266:271,345:350,424:429,503,504,516,517,555:561,563,564)]


#install.packages("reshape2")

#library("reshape2")

melt1 <- melt(dfDataSet,id=c("Stance","subject"))

output <- dcast(melt1,Stance+subject~variable,mean)

write.table(output,"TidyTable.txt")

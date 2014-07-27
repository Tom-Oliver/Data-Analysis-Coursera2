
#Gather names as IDed by Features.txt
mfNames <- read.table("UCI HAR Dataset/features.txt",row.names=1)

#Import first data set and name headings
dfTest <- read.table("UCI HAR Dataset/test/X_test.txt",col.names=mfNames[,1])

#Tag on the stances, in the raw format
dfTest$stanceNumber <- read.table("UCI HAR Dataset/test/y_test.txt",col.names = c('Stance.Number'))[,1]

#set up a vector for naming the stance per observation
stanceMap <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")

#Convert number to name
dfTest$stanceName <- sapply(dfTest$stanceNumber,function(x) stanceMap[x])

#Fix up table heading
colnames(dfTest)[563] <- 'Stance'

#tag on subjects per observation, named in the same row
dfTest$subject <- read.table("UCI HAR Dataset/test/subject_test.txt",col.names = c("Subject"))[,1]



#This stuff is the same as with the previous set but for the second one.
dfTrain <- read.table("UCI HAR Dataset/train/X_train.txt",col.names=mfNames[,1])

dfTrain$stanceNumber <- read.table("UCI HAR Dataset/train/y_train.txt",col.names = c('Stance.Number'))[,1]


dfTrain$stanceName <- sapply(dfTrain$stanceNumber,function(x) stanceMap[x])

colnames(dfTrain)[563] <- 'Stance'

dfTrain$subject <- read.table("UCI HAR Dataset/train/subject_train.txt",col.names = c("Subject"))[,1]


# Combining the two data sets
dfDataSet <- rbind(dfTest,dfTrain)


# Cut down the data set to what is required
dfDataSet <- dfDataSet[c(1:6,41:46,81:86,121:126,161:166,201,202,214,215,227,228,240,241,253,254,266:271,345:350,424:429,503,504,516,517,555:561,563,564)]

#Uncomment these if you dont have the packages
#install.packages("reshape2")

#library("reshape2")


#Using some specific commands to get the kind of figures required by the spec, like sorting by Stance and Subject and averaging each variable over them
melt1 <- melt(dfDataSet,id=c("Stance","subject"))

output <- dcast(melt1,Stance+subject~variable,mean)

# Creating the output table
write.table(output,"TidyTable.txt")

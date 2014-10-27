## This script will do the following:
## merge the training and the test sets to create one data set
## extract the measurements on the mean and standard deviation for each measurement
## use descriptive activity names to name the activities in the data set
## appropriately label the data set with descriptive variable names 
## creates a second, independent tidy data set with the average of each variable 
## for each activity and each subject from that data set

## The desired text files have already been put into the current working directory
## using Bash in Terminal

features <- read.table("features.txt", header=FALSE)
## reads in a 2x561 table with all variable names

xtest <- read.table("X_test.txt", header=FALSE, sep="")
## reads in the test (approx 30% of) data
## its dimensions are 2947x561

xtrain <- read.table("X_train.txt", header=FALSE, sep="")
## reads in the training (approx 70% of) data
## its dimensions are 7352x561

ytest <- read.table("Y_test.txt", header=FALSE)
## reads in the activity names (numbers for now) for the test data
## its dimensions are 2947x1

ytrain <- read.table("Y_train.txt", header=FALSE)
## reads in the activity names (numbers for now) for the training data
## its dimensions are 7352x1

featuresColnames<-t(features)
## creates a new table using the transpose command to make it 561x2
## now all of the names are going across in a row to better match up with the data

colnames(xtest) <- featuresColnames[2,]
## puts all names across the top of the xtest data
## only row 2 has the names
## these are the descriptive variable names
## required in #4 of the assignment

colnames(xtrain) <- featuresColnames[2,]
## puts all names across the top of the xtrain data
## only row 2 has the names
## this step isn't really necessary since this will
## be merged with xtest which already has the appropriate column names



## These next 6 lines will change the numbers 1-6
## to the activity names 'Walking' through 'Laying'
## in the test data
ytest[[1]]<-gsub(1, "Walking", ytest[[1]])
ytest[[1]]<-gsub(2, "Walking_Upstairs", ytest[[1]])
ytest[[1]]<-gsub(3, "Walking_Downstairs", ytest[[1]])
ytest[[1]]<-gsub(4, "Sitting", ytest[[1]])
ytest[[1]]<-gsub(5, "Standing", ytest[[1]])
ytest[[1]]<-gsub(6, "Laying", ytest[[1]])

## These next 6 lines will change the numbers 1-6
## to the activity names 'Walking' through 'Laying'
## in the training data
ytrain[[1]]<-gsub(1, "Walking", ytrain[[1]])
ytrain[[1]]<-gsub(2, "Walking_Upstairs", ytrain[[1]])
ytrain[[1]]<-gsub(3, "Walking_Downstairs", ytrain[[1]])
ytrain[[1]]<-gsub(4, "Sitting", ytrain[[1]])
ytrain[[1]]<-gsub(5, "Standing", ytrain[[1]])
ytrain[[1]]<-gsub(6, "Laying", ytrain[[1]])

xtest<-cbind(ytest,xtest)
colnames(xtest)[1] <- "Activity.Type"
## this adds the activity types, previously the ytest data of 1-6
## as the first column of the data frame
## and names the column Activity.Type

xtrain<-cbind(ytrain,xtrain)
colnames(xtrain)[1] <- "Activity.Type"
## this adds the activity types, previously the ytest data of 1-6
## as the first column of the data frame
## and names the column Activity.Type
## again...this column name is not necessary since in the next part,
## the two data frames will be put together 

allmerged <- rbind(xtest,xtrain)
## this merges both files together
## its dimensions are 10299 x 562
## (the extra column came from the activity type)
## this was the correct number of observations as reported on the phone data website
## given at the beginning of the program assignment description 
## so...it is tidy data :)

for (i in 2:562) {
        meansAndSds <- ddply(allmerged, .(Activity.Type), mean_data = mean(allmerged[,i]))
}

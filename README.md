cellphoneData
=============

Week 3 of Getting and Cleaning Data course project

This is my run_analysis.R file

If you have the following files in your working directory, and you execute my code,
you will end up with tidy data that has both the test and training data, all of the column names,
and row names corresponding to the six activities that were tracked.

I am hoping to get time to resubmit after I debug my ddply problem which is preventing me from finishing number 5 from the assignment.


I am at my wit's end.
Here is my latest batch of error messages:
Michelles-MacBook-Pro-2:pleasework mhapich$ ls
run_analysis.R
Michelles-MacBook-Pro-2:pleasework mhapich$ git clone https://github.com/mhapich/cellphoneData.git
Cloning into 'cellphoneData'...
remote: Counting objects: 6, done.
remote: Compressing objects: 100% (4/4), done.
Unpacking objects: 100% (6/6), done.
remote: Total 6 (delta 1), reused 0 (delta 0)
Checking connectivity... done.
Michelles-MacBook-Pro-2:pleasework mhapich$ git add run_analysis.R
Michelles-MacBook-Pro-2:pleasework mhapich$ git commit -m "my best course project code"
[master (root-commit) 51f921b] my best course project code
 1 file changed, 93 insertions(+)
 create mode 100644 run_analysis.R
Michelles-MacBook-Pro-2:pleasework mhapich$ git push origin master
fatal: 'origin' does not appear to be a git repository
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
Michelles-MacBook-Pro-2:pleasework mhapich$ git push
fatal: No configured push destination.
Either specify the URL from the command-line or configure a remote repository using

    git remote add <name> <url>

and then push using the remote name

    git push <name>

Michelles-MacBook-Pro-2:pleasework mhapich$ git status
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	cellphoneData/

nothing added to commit but untracked files present (use "git add" to track)
Michelles-MacBook-Pro-2:pleasework mhapich$ git remote add run_analysis.R https://github.com/mhapich/cellphoneData.git
Michelles-MacBook-Pro-2:pleasework mhapich$

AFTER ALL OF THIS, my code is STILL NOT HERE.

Here is the program I couldn't get added:

----------------------------------------------------------------------------------------------------------------
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

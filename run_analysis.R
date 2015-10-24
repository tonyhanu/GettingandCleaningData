# Getting and Cleaning Data - Course Project
# Author: Tony Hanusiak
# Date: 2015-21-10

# The following lines define the path to the datafiles.
# The path strings are written for Windows and they are written for
# the directory structure that I have used on my computer.

testFilePath <- "C:\\GetCleanData\\Course Project\\UCI HAR Dataset\\test\\"
trainFilePath <- "C:\\GetCleanData\\Course Project\\UCI HAR Dataset\\train\\"
testfiles <- c("subject_test.txt", "y_test.txt", "X_test.txt")
trainfiles <- c("subject_train.txt", "y_train.txt", "X_train.txt")
writeFilePath <- "C:\\GetCleanData\\Course Project\\UCI HAR Dataset\\"

# various useful variables to help transform the data
activities <- factor(c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
features <- read.table("C:\\GetCleanData\\Course Project\\UCI HAR Dataset\\features.txt", stringsAsFactors = FALSE)
#create logical vector where mean or std appears in features
meanstd <- grepl("(mean|std)", features[,2], ignore.case = TRUE)

#   ********************Test Data Set *********************

#Read the three files that make up the test data set
subjects_test <- read.table(paste(testFilePath, testfiles[1], sep=""))
activity_test <- read.table(paste(testFilePath, testfiles[2], sep = ""))
data_test <- read.table(paste(testFilePath, testfiles[3], sep = ""))

# Tidy the test data

# convert activities from integers to words
actFact <- as.factor(activity_test$V1)
levels(actFact) <- activities
activity_test <- as.data.frame(actFact)

# Give column names descriptive headings
colnames(subjects_test) <- "Subject"
colnames(activity_test) <- "Activity"
colnames(data_test) <- features[,2]

#select only the columns that have mean or standard deviation data
data_test <-data_test[,meanstd]
# Bind columns from the test data set
testdf <- cbind(subjects_test, activity_test, data_test, stringsAsFactors = FALSE)

#   ******************* Training Data Set *******************

# Read the three files that make up the training data
subjects_train <- read.table(paste(trainFilePath, trainfiles[1], sep=""))
activity_train <- read.table(paste(trainFilePath, trainfiles[2], sep = "")) 
data_train <- read.table(paste(trainFilePath, trainfiles[3], sep = ""))

# convert activities from integers to words
actFact <- as.factor(activity_train$V1)
levels(actFact) <- activities
activity_train <- as.data.frame(actFact)

# Give column names descriptive headings
colnames(subjects_train) <- "Subject"
colnames(activity_train) <- "Activity"
colnames(data_train) <- features[,2]

#select only the columns that have mean or standard deviation data
data_train <-data_train[,meanstd]
# Bind columns from the training data set
traindf <- cbind(subjects_train, activity_train, data_train, stringsAsFactors = FALSE)

# Join the training and test data sets together and write the tidied data to a csv file
tidy_data <- rbind(traindf, testdf)
write.csv(tidy_data, paste(writeFilePath,"tidy_data.csv"), row.names = FALSE, fileEncoding = "utf8")

# Calculate the mean of values in each column grouped by Subect and Activity
# Create a column vector that includes the name of each column to be used in the aggregate function.
colvect <- features[,2][meanstd]
# create the aggregated data and write it out to a csv file
mean_summary_by_Subject_and_Activity <- aggregate(tidydata[colvect],list(Subject=tidydata$Subject,Activity=tidydata$Activity), mean)
write.csv(mean_summary_by_Subject_and_Activity, paste(writeFilePath, "mean_summary_by_Subject_and_Activity.csv"), row.names = FALSE, fileEncoding = "utf8")
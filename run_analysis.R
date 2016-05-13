library(reshape2)

filename <- "getdata.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
    unzip(filename) 
}

# Load activity labels and the features
# THis information is present in the unzipped file (activity_labels.txt and features.txt)
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Information is needed for mean and standard deviation
# Hence Extract only the data on mean and standard deviation
featuresActual <- grep(".*mean.*|.*std.*", features[,2])
featuresActual.names <- features[featuresActual,2]

# Just to make the features more readable, substitute mean and std
featuresActual.names = gsub('-mean', 'Mean', featuresActual.names)
featuresActual.names = gsub('-std', 'Std', featuresActual.names)
featuresActual.names <- gsub('[-()]', '', featuresActual.names)


# Load the datasets
# First load the training data sets and next load the test datasets
TrainDS <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresActual]
TrainDSActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
TrainDSSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
TrainDS <- cbind(TrainDSSubjects, TrainDSActivities, TrainDS)
TestDS <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresActual]
TestDSActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
TestDSSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
TestDS <- cbind(TestDSSubjects, TestDSActivities, TestDS)

# Merge datasets and add labels based on the feature names
MergedDS <- rbind(TrainDS, TestDS)
colnames(MergedDS) <- c("subject", "activity", featuresActual.names)

# Turn the activities and subjects as factors
MergedDS$activity <- factor(MergedDS$activity, levels = activityLabels[,1], labels = activityLabels[,2])
MergedDS$subject <- as.factor(MergedDS$subject)
MergedDS.melted <- melt(MergedDS, id = c("subject", "activity"))
MergedDS.mean <- dcast(MergedDS.melted, subject + activity ~ variable, mean)

# Finally write the Merged Dataset into a tidy text file
write.table(MergedDS.mean, "tidy.txt", row.names = FALSE, quote = FALSE)

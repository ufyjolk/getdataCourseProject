# Getting and Cleaning Data MOOC by JHU @ coursera
# (Peer-assesed) Course Project.
# This is the script to be assessed.
# BM (ufyjolk) -- June 21th 2015.

library(reshape2)

## Reading the relevant data
subject_test <-
        as.data.frame(read.table("UCI HAR Dataset/test/subject_test.txt"))
X_test <-
        as.data.frame(read.table("UCI HAR Dataset/test/X_test.txt"))
y_test <-
        as.data.frame(read.table("UCI HAR Dataset/test/y_test.txt"))

subject_train <-
        as.data.frame(read.table("UCI HAR Dataset/train/subject_train.txt"))
X_train <-
        as.data.frame(read.table("UCI HAR Dataset/train/X_train.txt"))
y_train <-
        as.data.frame(read.table("UCI HAR Dataset/train/y_train.txt"))

features <- read.table("UCI HAR Dataset/features.txt")
label <- read.table("UCI HAR Dataset/activity_labels.txt")

## Adding descriptive colnames (STEP 4)

colnames(X_test) <- features$V2
colnames(X_train) <- features$V2
colnames(y_test) <- "label"
colnames(y_train) <- "label"
colnames(subject_test) <- "subject"
colnames(subject_train) <- "subject"

## Merging relevant columns for "test" and "train" data

testAll <- cbind(y_test, subject_test, X_test)
trainAll <- cbind(y_train, subject_train, X_train)

## Merging "test" and "train" data (STEP 1)

allData <- rbind(testAll, trainAll)

## Extracting only mean and std measurements (STEP 2)

allMeanSD <-
        allData[, intersect(
                grep('mean()|std()|label|subject', colnames(allData), value = TRUE), grep(
                        'meanFreq()', colnames(allData), value = TRUE, invert = TRUE
                )
        )]

## Adding descriptive activity names (STEP 3)

allMeanSD$label <- as.factor(allMeanSD$label)

levels(allMeanSD$label) <- label$V2

allMeanSD$subject <- as.factor(allMeanSD$subject)

## Creating the tidy dataset (STEP 5)

allMelt <- melt(allMeanSD, id = c("label", "subject"))

final <- dcast(allMelt, label + subject ~ variable,mean)

write.table(final, file = "analysis_data_final.txt", row.names = FALSE)

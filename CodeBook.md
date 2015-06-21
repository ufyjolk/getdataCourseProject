# Getting and Cleaning Data MOOC by JHU @ coursera
### (Peer-assesed) Course Project.
### Codebook.

##### BM (ufyjolk) -- June 21th 2015.

---

#### General information

This is the "Codebook" for the `run_analysis.R` script, containing information about the environment of the script, as well as its input and output data.
Additional details and credits can be found in the `README.md` file contained in this github repository.

#### Input and Output Data

The script takes as **_input_** the processed data from both **test** and **train** groups from the experiment. This data is contained in `train\X_train.txt` and `test\X_test.txt` files from the original data set. The script also takes as input the supporting data from `train\y_train.txt`, `test\y_test.txt`, `train\subject_train.txt`, `test\subject_test.txt`, `features.txt` and `activity_labels.txt`.
The contents of these files are as follows:

* `train\X_train.txt` - full set of processed data in variables defined in `features.txt` for the **train** group,
* `test\X_test.txt` - full set of processed data in variables defined in `features.txt` for the **test** group,
* `train\y_train.txt` - labels (IDs of the *activities*) for the corresponding observations of the full data set for the **train** group,
* `test\y_test.txt` - labels (IDs of the *activities*) for the corresponding observations of the full data set for the **test** group,
* `train\subject_train.txt` - subject IDs for the corresponding observations of the full dataset for the **train** group,
* `test\subject_test.txt` - subject IDs for the corresponding observations of the full dataset for the **test** group,
* `features.txt` - a set of descriptive variable names (`colnames`) for every column of either of the full sets of data (`train\X_train.txt` and `test\X_test.txt`), ie. for both the **train** and **test** groups,
* `activity_labels.txt` - a table connecting *labels* with their corresponding descriptive *activity* names.

Any additional information about the source files can be found in the `README.txt` file provided in the Human Activity Recognition Using Smartphones Dataset v. 1.0 by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto from Smartlab - Non Linear Complex Systems Laboratory, DITEN - Universita degli Studi di Genova.


The **_output_** file of this script, `analysis_data_final.txt`, is a two-dimensional table with the re-processed, calculated and cleaned data in accordance with [the description of this exercise](https://class.coursera.org/getdata-015/human_grading/view/courses/973502/assessments/3/submissions).

The file has been saved using `write.table()` R function using `row.name=FALSE` argument.
It contains 180 observations (6 *activities* performed by 30 *subjects*) of 68 variables.
Variables of this output file have been described in the **Variables of the Output File** section of this document.

Additional information about the processing of the data can be found in the **Transformations and Script Structure** section of this file and in the `README.md` file contained in this github repository.

#### Transformations and Script Structure

This script is structured linearly and does not contain new functions written by its author.
It does, however, use the `reshape2` R package available from the `CRAN` repository.

The data structures created by and used in the script are:

* `subject_test` - a data frame containing the records from the `test\subject_test.txt` file of the original data set,
* `X_test` - a data frame containing the records from the `test\X_test.txt` file of the original data set,
* `y_test` - a data frame containing the records from the `test\y_test.txt` file of the original data set,
* `subject_train` - a data frame containing the records from the `train\subject_train.txt` file of the original data set,
* `X_train` - a data frame containing the records from the `train\X_train.txt` file of the original data set,
* `y_train` - a data frame containing the records from the `train\y_train.txt` file of the original data set,
* `features` - a data frame containing the records from the `features.txt` file of the original data set,
* `label` - a data frame containing the records from the `activity_labels.txt` file of the original data set,
* `testAll` - a column-bound data frame of the `y_test`, `subject_test` and `X_test` data frames,
* `trainAll` - a column-bound data frame of the `y_train`, `subject_train` and `X_train` data frames,
* `allData` - a row-bound data frame of the `testAll` and `trainAll` data frames,
* `allMeanSD` - a data frame containing a subset of the `allData` data frame with only `*-mean()-*` and `*-sd()-*` variables (ie. containing only the *mean* and *standard deviation* variables) defined as an intersection of `grep('mean()|std()|label|subject')` and `grep('meanFreq()', invert = TRUE)` (both using the `colnames(allData)` argument),
* `allMelt` - a melted `allMeanSD` data frame with `label` and `subject` variables defined as *ID variables*,
* `final` - a data frame with the calculated mean values of appropriate variables for each *ID variable* of the melted data frame created using the `dcast` function with the following command: `dcast(allMelt, label + subject ~ variable,mean)`; this is also the data frame contained in the output, `analysis_data_final.txt`, file.

Please note that the output file is an independent data set containing averages of the `*-mean()-*` and `*-std()-*` variables from the source data set calculated for each *activity* and each *subject*.

Additional information about the script structure is contained in the `README.md` file, which can be found in this repository.

#### Variables of the Output File

A list containing descriptions of all variables of the output file can be found below.

All variables except `label` and `subject` are normalized and bound within [-1,1].

Any additional information about the original (source) variables can be found in the `features_info.txt` and `README.txt` files provided in the Human Activity Recognition Using Smartphones Dataset v. 1.0 by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto from Smartlab - Non Linear Complex Systems Laboratory, DITEN - Universita degli Studi di Genova.

* `label` - a descriptive name of the activity performed by the subject. Can be one of six: `WALKING`, `WALKING_UPSTAIRS`, `WALKING_DOWNSTAIRS`, `SITTING`, `STANDING`, `LAYING`.
* `subject` - A numeric indicator of the subject who is performing a given task. Values range from 1 to 30, as 30 subjects took part in the experiment. Subjects 2, 4, 9, 10, 12, 13, 18, 20 and 24 were in the **test** group, while subjects 1, 3, 5, 6, 7, 8, 11, 14, 15, 16, 17, 19, 21, 22, 23, 25, 26, 27, 28, 29 and 30 were in the **train** group.
* `tBodyAcc-mean()-X` - the mean of the time-domain body acceleration signal from the accelerometer in the X direction.
* `tBodyAcc-mean()-Y` - the mean of the time-domain body acceleration signal from the accelerometer in the Y direction.
* `tBodyAcc-mean()-Z` - the mean of the time-domain body acceleration signal from the accelerometer in the Z direction.
* `tBodyAcc-std()-X` - the standard deviation of the time-domain body acceleration signal from the accelerometer in the X direction.
* `tBodyAcc-std()-Y` - the standard deviation of the time-domain body acceleration signal from the accelerometer in the Y direction.
* `tBodyAcc-std()-Z` - the standard deviation of the time-domain body acceleration signal from the accelerometer in the Z direction.
* `tGravityAcc-mean()-X` - the mean of the time-domain gravity acceleration signal from the accelerometer in the X direction.
* `tGravityAcc-mean()-Y` - the mean of the time-domain gravity acceleration signal from the accelerometer in the Y direction.
* `tGravityAcc-mean()-Z` - the mean of the time-domain gravity acceleration signal from the accelerometer in the Z direction.
* `tGravityAcc-std()-X` - the standard deviation of the time-domain gravity acceleration signal from the accelerometer in the X direction.
* `tGravityAcc-std()-Y` - the standard deviation of the time-domain gravity acceleration signal from the accelerometer in the Y direction.
* `tGravityAcc-std()-Z` - the standard deviation of the time-domain gravity acceleration signal from the accelerometer in the Z direction.
* `tBodyAccJerk-mean()-X` - the mean of the time-domain body derived jerk signal from the accelerometer in the X direction.
* `tBodyAccJerk-mean()-Y` - the mean of the time-domain body derived jerk signal from the accelerometer in the Y direction.
* `tBodyAccJerk-mean()-Z` - the mean of the time-domain body derived jerk signal from the accelerometer in the Z direction.
* `tBodyAccJerk-std()-X` - the standard deviation of the time-domain body derived jerk signal from the accelerometer in the X direction.
* `tBodyAccJerk-std()-Y` - the standard deviation of the time-domain body derived jerk signal from the accelerometer in the Y direction.
* `tBodyAccJerk-std()-Z` - the standard deviation of the time-domain body derived jerk signal from the accelerometer in the Z direction.
* `tBodyGyro-mean()-X` - the mean of the time-domain body acceleration signal from the gyroscope in the X direction.
* `tBodyGyro-mean()-Y` - the mean of the time-domain body acceleration signal from the gyroscope in the Y direction.
* `tBodyGyro-mean()-Z` - the mean of the time-domain body acceleration signal from the gyroscope in the Z direction.
* `tBodyGyro-std()-X` - the standard deviation of the time-domain body acceleration signal from the gyroscope in the X direction.
* `tBodyGyro-std()-Y` - the standard deviation of the time-domain body acceleration signal from the gyroscope in the Y direction.
* `tBodyGyro-std()-Z` - the standard deviation of the time-domain body acceleration signal from the gyroscope in the Z direction.
* `tBodyGyroJerk-mean()-X` - the mean of the time-domain body derived jerk signal from the gyroscope in the X direction.
* `tBodyGyroJerk-mean()-Y` - the mean of the time-domain body derived jerk signal from the gyroscope in the Y direction.
* `tBodyGyroJerk-mean()-Z` - the mean of the time-domain body derived jerk signal from the gyroscope in the Z direction.
* `tBodyGyroJerk-std()-X` - the standard deviation of the time-domain body derived jerk signal from the gyroscope in the X direction.
* `tBodyGyroJerk-std()-Y` - the standard deviation of the time-domain body derived jerk signal from the gyroscope in the Y direction.
* `tBodyGyroJerk-std()-Z` - the standard deviation of the time-domain body derived jerk signal from the gyroscope in the Z direction.
* `tBodyAccMag-mean()` - the mean of the time-domain body acceleration signal from the accelerometer magnitude.
* `tBodyAccMag-std()` - the standard deviation of the time-domain body acceleration signal from the accelerometer magnitude.
* `tGravityAccMag-mean()` - the mean of the time-domain gravity acceleration signal from the accelerometer magnitude.
* `tGravityAccMag-std()` - the standard deviation of the time-domain gravity acceleration signal from the accelerometer magnitude.
* `tBodyAccJerkMag-mean()` - the mean of the time-domain body derived jerk signal from the accelerometer magnitude.
* `tBodyAccJerkMag-std()` - the standard deviation of the time-domain body derived jerk signal from the accelerometer magnitude.
* `tBodyGyroMag-mean()` - the mean of the time-domain body acceleration signal from the gyroscope magnitude.
* `tBodyGyroMag-std()` - the standard deviation of the time-domain body acceleration signal from the gyroscope magnitude.
* `tBodyGyroJerkMag-mean()` - the mean of the time-domain body derived jerk signal from the gyroscope magnitude.
* `tBodyGyroJerkMag-std()` - the standard deviation of the time-domain body derived jerk signal from the gyroscope magnitude.
* `fBodyAcc-mean()-X` - the mean of the Fourier-domain body acceleration signal from the accelerometer in the X direction.
* `fBodyAcc-mean()-Y` - the mean of the Fourier-domain body acceleration signal from the accelerometer in the Y direction.
* `fBodyAcc-mean()-Z` - the mean of the Fourier-domain body acceleration signal from the accelerometer in the Z direction.
* `fBodyAcc-std()-X` - the standard deviation of the Fourier-domain body acceleration signal from the accelerometer in the X direction.
* `fBodyAcc-std()-Y` - the standard deviation of the Fourier-domain body acceleration signal from the accelerometer in the Y direction.
* `fBodyAcc-std()-Z` - the standard deviation of the Fourier-domain body acceleration signal from the accelerometer in the Z direction.
* `fBodyAccJerk-mean()-X` - the mean of the Fourier-domain body derived jerk signal from the accelerometer in the X direction.
* `fBodyAccJerk-mean()-Y` - the mean of the Fourier-domain body derived jerk signal from the accelerometer in the Y direction.
* `fBodyAccJerk-mean()-Z` - the mean of the Fourier-domain body derived jerk signal from the accelerometer in the Z direction.
* `fBodyAccJerk-std()-X` - the standard deviation of the Fourier-domain body derived jerk signal from the accelerometer in the X direction.
* `fBodyAccJerk-std()-Y` - the standard deviation of the Fourier-domain body derived jerk signal from the accelerometer in the Y direction.
* `fBodyAccJerk-std()-Z` - the standard deviation of the Fourier-domain body derived jerk signal from the accelerometer in the Z direction.
* `fBodyGyro-mean()-X` - the mean of the Fourier-domain body acceleration signal from the gyroscope in the X direction.
* `fBodyGyro-mean()-Y` - the mean of the Fourier-domain body acceleration signal from the gyroscope in the Y direction.
* `fBodyGyro-mean()-Z` - the mean of the Fourier-domain body acceleration signal from the gyroscope in the Z direction.
* `fBodyGyro-std()-X` - the standard deviation of the Fourier-domain body acceleration signal from the gyroscope in the X direction.
* `fBodyGyro-std()-Y` - the standard deviation of the Fourier-domain body acceleration signal from the gyroscope in the Y direction.
* `fBodyGyro-std()-Z` - the standard deviation of the Fourier-domain body acceleration signal from the gyroscope in the Z direction.
* `fBodyAccMag-mean()` - the mean of the Fourier-domain body acceleration signal from the accelerometer magnitude.
* `fBodyAccMag-std()` - the standard deviation of the Fourier-domain body acceleration signal from the accelerometer magnitude.
* `fBodyBodyAccJerkMag-mean()` - the mean of the Fourier-domain body derived jerk signal from the accelerometer magnitude.
* `fBodyBodyAccJerkMag-std()` - the standard deviation of the Fourier-domain body derived jerk signal from the accelerometer magnitude.
* `fBodyBodyGyroMag-mean()` - the mean of the Fourier-domain body acceleration signal from the gyroscope magnitude.
* `fBodyBodyGyroMag-std()` - the standard deviation of the Fourier-domain body acceleration signal from the gyroscope magnitude.
* `fBodyBodyGyroJerkMag-mean()` - the mean of the Fourier-domain body derived jerk signal from the gyroscope magnitude.
* `fBodyBodyGyroJerkMag-std()` - the standard deviation of the Fourier-domain body derived jerk signal from the gyroscope magnitude.
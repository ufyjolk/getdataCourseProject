# Getting and Cleaning Data MOOC by JHU @ coursera
### (Peer-assesed) Course Project.
### README.

##### BM (ufyjolk) -- June 21th 2015.

---

#### General information

This is the main "README" file for the `run_analysis.R` script created as a Course Project for the *Getting and Cleaning Data* MOOC provided by the John Hopkins University on the *coursera* platform.

In this document the assumptions, structure and mechanisms of the script will be briefly explained and the reasoning behind the used analytic cleaning methods will be stated. This file also contains a brief summary of other files from this repository and gives appropriate credits.

#### Additional Information about this Repository

In this github repository there are the following files:

* `analysis_data_final.txt` - the output file of the script,
* `CodeBook.md` - a "Codebook" for the `run_analysis.R` script containing brief information about the source and output files, the environment and data structures of the script and a description of the variables of the output file,
* `README.md` - this file,
* `run_analysis.R` - the main script.

Any questions or suggestions should be directed to the original author of these files, @ufyjolk.

#### Goal

The main goal of the script, as stated in [the description of this exercise](https://class.coursera.org/getdata-015/human_grading/view/courses/973502/assessments/3/submissions) is to provide a clean data set with the calculated means of all the mean and standard deviation variables from the provided original data set: [the Human Activity Recognition Using Smartphones Dataset v. 1.0](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto from Smartlab - Non Linear Complex Systems Laboratory, DITEN - Universita degli Studi di Genova, and to save the output in a `txt` file (in this case it is the `analysis_data_final.txt` file to be found in this repository and also uploaded to the *coursera* server as required by the exercise description).

#### Source Data Set and its Relevant Files

The source data set contains the results of

> [t]he experiments (...) carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (`WALKING`, `WALKING_UPSTAIRS`, `WALKING_DOWNSTAIRS`, `SITTING`, `STANDING`, `LAYING`) [while] wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. (...) The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data,

as stated in the `README.txt` file of the original data set.

On the basis of additional information contained in that file it can be concluded that for the purposes of this exercise the files contained in the `train\Inertial Signals` and `test\Inertial Signals` directories of the original data set can be disregarded, as they contain

> [t]he acceleration signal from the smartphone accelerometer (...) in standard gravity units *g*, (...) [the] acceleration signal obtained by subtracting the gravity from the total acceleration (...) [and] [t]he angular velocity vector measured by the gyroscope for each window sample (...) [in] radians/second,

while the data in other files is processed,

> normalized and bounded within [-1,1].

Descriptions of the used (and relevant) files can be found in the `CodeBook.md` file in this repository.

#### Assumptions

1. There are no `NA` values in the source files and no numeric column contains `NaN` values.
2. The `zip` file has been already downloaded and unpacked by the user in the directory of the script (this cloned repository), so that the file structure is as follows:
  * `[path]\analysis_data_final.txt`
  * `[path]\CodeBook.md`
  * `[path]\README.md`
  * `[path]\run_analysis.R`
  * `[path]\UCI HAR Dataset\activity_labels.txt`
  * `[path]\UCI HAR Dataset\features.txt`
  * `[path]\UCI HAR Dataset\features_info.txt`
  * `[path]\UCI HAR Dataset\README.txt`
  * `[path]\UCI HAR Dataset\activity_labels.txt`
  * `[path]\UCI HAR Dataset\test\subject_test.txt`
  * `[path]\UCI HAR Dataset\test\X_test.txt`
  * `[path]\UCI HAR Dataset\test\y_test.txt`
  * `[path]\UCI HAR Dataset\test\Inertial Signals\body_acc_x_test.txt`
  * `[path]\UCI HAR Dataset\test\Inertial Signals\body_acc_y_test.txt`
  * `[path]\UCI HAR Dataset\test\Inertial Signals\body_acc_z_test.txt`
  * `[path]\UCI HAR Dataset\test\Inertial Signals\body_gyro_x_test.txt`
  * `[path]\UCI HAR Dataset\test\Inertial Signals\body_gyro_y_test.txt`
  * `[path]\UCI HAR Dataset\test\Inertial Signals\body_gyro_z_test.txt`
  * `[path]\UCI HAR Dataset\test\Inertial Signals\total_acc_x_test.txt`
  * `[path]\UCI HAR Dataset\test\Inertial Signals\total_acc_y_test.txt`
  * `[path]\UCI HAR Dataset\test\Inertial Signals\total_acc_z_test.txt`
  * `[path]\UCI HAR Dataset\train\subject_train.txt`
  * `[path]\UCI HAR Dataset\train\X_train.txt`
  * `[path]\UCI HAR Dataset\train\y_train.txt`
  * `[path]\UCI HAR Dataset\train\Inertial Signals\body_acc_x_train.txt`
  * `[path]\UCI HAR Dataset\train\Inertial Signals\body_acc_y_train.txt`
  * `[path]\UCI HAR Dataset\train\Inertial Signals\body_acc_z_train.txt`
  * `[path]\UCI HAR Dataset\train\Inertial Signals\body_gyro_x_train.txt`
  * `[path]\UCI HAR Dataset\train\Inertial Signals\body_gyro_y_train.txt`
  * `[path]\UCI HAR Dataset\train\Inertial Signals\body_gyro_z_train.txt`
  * `[path]\UCI HAR Dataset\train\Inertial Signals\total_acc_x_train.txt`
  * `[path]\UCI HAR Dataset\train\Inertial Signals\total_acc_y_train.txt`
  * `[path]\UCI HAR Dataset\train\Inertial Signals\total_acc_z_train.txt`

#### Script Structure

This script has a linear structure.

1. First, the script load the relevant data sets to its data structures.

2. Then, it applies the *feature* descriptive names to the variables of the **test** and **train** groups. This corresponds to *Step 4* of the exercise instruction and the reason to do it earlier is that having descriptive variable names makes the manipulation of the data sets and subsetting much easier that using `V1`, `V2`, ..., `Vn` default `colnames`. The script also applies descriptive variable names to the appropriate *activity*- and *subject*-related data sets.

3. The main data sets are column-bound with the vectors containing *activity*- and *subject*-related IDs.

4. Next, the script merges the data from **test** and **train** groups. As it was explained in the **Source Data Set and its Relevant Files** section of this document, this partitioning was artificial, random and based on the *subject ID*, so those groups can be safely merged as the data from both groups is structured in the same way. The information about which subjects correspond to which group can be found in the `CodeBook.md` file in this repository. This corresponds to *Step 1* of the exercise instruction.

5. The variables containing means and standard deviations are extracted. Further information can be found in the `CodeBook.md` file. This corresponds to *Step 2* of the exercise instruction.

6. The script then adds descriptive *activity* names using level-manipulation and the `activity_labels.txt` file from the original data set. This corresponds to *Step 3* of the exercise instruction.

7. The script then calculates the means of all the subsetted variables from each *activity* and each *subject* and creates a clean data set using the`dcast` function. Further explanation can be found in the `CodeBook.md` file. This corresponds to *Step 5* of the exercise instruction, although please note that *Step 4* has been done at the beginning of the script and that the clean data set is created from the data created in *Step 3* -- however **in this situation those are equivalent**.

8. The script saves the clean data set to the output `txt` file.

Additional information about the script's structure and environment can be found in the `CodeBook.md` file and in the comments inside the script itself.

#### Additional Credits

I would like to thank @David Hood, the Community TA in this course, for the information he provided in his [FAQ](https://class.coursera.org/getdata-015/forum/thread?thread_id=26#post-48).
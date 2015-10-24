# README file for Getting and Cleaning Data – October 2015

### Overview of the Original Data

The original data for this project can be found at this link. 

http://archive.ics.uci.edu/ml/machine-learning-databases/00240/

An overview and general discussion of the data can be found at this link:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

A more complete description of the data is included with the data and is contained in the following files that accompany the data:
* README.txt
* features.txt
* features_info.txt
* activity_labels.txt

The original data had been randomly divided into two data sets named training and test. The data for each set was contained in three files; one each containing the “Subjects” - the volunteers who took part in the experiments (subject_test.txt, subject_train.txt). These files consisted of a single column of integers each representing an individual subject.

A second file in each set (y_test.txt, y_train.txt) contained a single column of integers ranging from 1-6. These integers represented the 6 activities in which the subjects took part - WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING and LAYING.

The third file in each set (X_test.txt, X_train.txt) contains the measured data values after they have been processed with filters and fast Fourier transforms. See the README.txt that accompanies the original data. Each file contained 561 columns of data of equal length within the data set.

The raw data was also included in the original data set but was not utilized in this project.

### Treatment of the Data – Obtaining a Tidy Data Set

In tidying the data, the test data set and training data set were treated separately but identically and then bound together after each set data set was massaged. 

The first thing that was done on each data set was to read the three files for a given set into the R environment. This was done with with a read.table() function. 

Once the files had been read the “y” file which contained integers representing the activities were processed to change the integers into the actual word descriptions of the activites.

The next changes to be made were to give the columns meaningful names instead of V1, V2....etc. Names “Subject” and “Activity” were chosen for the two sets representing the subjects and activities respectively. For the measured/processed data values (ie. the 561 columns) the actual column headings were obtained from the file “features.txt” file in the original data.

Of the 561 columns of data, only those that included mean and standard deviation information were of interest for this project. A regular expression was used to select those columns that included the strings mean or std (case insensitive) and produce a logical vector. The logical vector was then applied to the dataframe of measured/processed values to reduce the set from 561 to 86 columns.

The 3 files for each data set were then bound together (using cbind()) within their respective sets in order such that Subjects was the first column, Activities was the second column and the 561 columns of measured/processed data followed. 

Once there were two tidy data sets from the test and training data, the two were bound together using the rbind() function with the training data on top and the test data below.

The data set was written to a csv file as _**tidy_data.csv**_. 

### Summarizing the Data (Step 5 in the course project description)

It was required to calculate the mean of the values from each column grouped by subject and activity. Since there were many columns a vector of the column names was created to use in the aggregate() function. This function was used to calculate the mean grouped by subject and activity. The data was then written to a csv file as _**mean_summary_by_Subject_and_Activity.csv**_.

### Running the run_analysis.R Script

The run_analysis.R script included in the repo is well commented and reasonably self-explanatory. It must be run from withing the top-level of the original unzipped data driectory structure. The data unzips like this:
* **UCI HAR Dataset**  
  + **test (folder)**
  + **train (folder)**
  + _README.txt (file)_
  + _features.txt (file)_
  + _features_info.txt (file)_
  + _activity_labels.txt (file)_  

The run_analysis.R script must be placed in the **UCI HAR Dataset** with the two folders and the other files. Like so:
* **UCI HAR Dataset**  
  + **test (folder)**
  + **train (folder)**
  + _README.txt (file)_
  + _features.txt (file)_
  + _features_info.txt (file)_
  + _activity_labels.txt (file)_
  + _run_analysis.R_

It will write three output files to the current directory:
* tidy_data.csv (the tidied data before summarization)
* mean_summary_by_Subject_and_Activity.csv (summarized data as csv)
* mean_summary_by_Subject_and_Activity.txt (summarized data as txt)
 

### Reading the output data files

Both the tidy_data.csv and the  mean_summary_by_Subject_and_Activity.csv were written with the write.csv() function using default values. The data can be read using read.csv(filename-including-path) and using defaults for all options. The required mean_summary_by_Subject_and_Activity.txt can be read using read.table().

==================================================================
Peer Graded Assignment: Getting and Cleaning Data Course Project
==================================================================
Author: Matt Kane
------------------------------------------------------------------

The project contains only a single R file 'run_analysis.R' as it is required to be a 
single r script.  The r script is to take the data from the origin data set (defined below)
and perform 5 actions/requirements.  The r script will create 2 data sets.  The
first data set (full_set) is a tidy data set that contains all of the mean and standard
deviation data values (excluding meanFrequency, gravityMean, and angle(mean) data values)
from both the test and train original data sets.  The second data set (avg_set) is written
to disk as the output.txt file (read instructions below) and contains the average values
for each of the full_set data grouped by subject_id and activity.

### Original Data Set ###
Can be downloaded here
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

For it to interact with the R script, you must unzip the data set and set your working
directory to the 'UCI HAR Dataset' directory, which contains the file features.txt.

### First Data Set ###
The first data set is stored in the variable 'full_set'.  It is tidy because each variable
forms a column, each observation forms a row, and each observational unit forms a table.

Each row in 'full_set' represents an observation for a subject/activity combination that was
observed over time by the study.  The subject_id is a unique identifier meant to hide the 
identity of the person, and the activity is the activity the subject was performing.  The 
rest of the columns are mean or standard deviation calculations of variables related to 
that subject/activity combination.  The code book 'codebook.md' defines all of the variables.

### Second Data Set ###
The second data set is stored in the variable 'avg_set' and is also written to disk as 
'output.txt'.  It is also a tidy dataset representing the the average values of each variable
in full_set grouped by each unique subject/activity combination.  The code book 'codebook.md'
defines all of the variables.

### Reading the Output File
To read the output file back into R, the data is written with column headers but no row headers.
The following code will read the data back into a R.

read.table("output.txt", header = TRUE)
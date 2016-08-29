==================================================================
Code Book for...
Peer Graded Assignment: Getting and Cleaning Data Course Project
==================================================================
Author: Matt Kane
==================================================================


*** First Data Set ***
The first data set is stored in the variable 'full_set'.  The following
columns are contained in the data set.  The first 2 columns are defined 
in full.  The other 66 columns are defined by the descriptive terms in
the column names.  I will define the descriptive terms so that you can
piece together what each value is.  All columns are in lower case and
descriptive terms are seperated by the underscore '_' to make the columns
easy to work with.

subject_id (numeric) - a unique identifier for each person in the study.

activity (factor) - the activity the subject was performing at the time
of the observations that were made  from their accelerometer on their 
Samsung Galaxy S phone.  The valid activities that were recorded were
WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, 
and LAYING.  

Other columns - all other columns are calculations on different variables
from the original dataset. Their names are concatentations of the different
variables they represent.  The original dataset was capturing a 3 axial
accelerametor and gyroscope from a Samsung Galaxy S smartphone.  Below is 
a key for the concatenated parts...

time - This indicates the variable is a time domain signal.  The time domain
signal was taken at a constant rate of 50Hz. Then they were filtered using a 
median filter and a 3rd order low pass Butterworth filter with a corner 
frequency of 20 Hz to remove noise.

freq - This indicates the variable is a frequency domain signal.  To get a
frequency domain signal, a Fast Fourier Transform (FFT) was applied to earlier
signals.

body_accel and gravity_accel - The time acceleration signal was separated into 
body and gravity acceleration signals using another low pass Butterworth filter 
with a corner frequency of 0.3 Hz.

body_gyro - The gryroscope readings from the phone's gyroscope.

jerk - the body linear acceleration and angular velocity were derived in time 
to obtain the jerk signals.  

magnitude - The magnitude of these three-dimensional signals were 
calculated using the Euclidean norm.

mean - Mean or average.  This indicates it is the mean calculation of the
variable.

std - Standard Deviation.  This indicates it is the standard deviation of 
the variable.

x, y, z - This represents the three different axis of the variable as it
was measured.

*** All Variables

subject_id
activity
time_body_accel_mean_x
time_body_accel_mean_y
time_body_accel_mean_z
time_body_accel_std_x
time_body_accel_std_y
time_body_accel_std_z
time_gravity_accel_mean_x
time_gravity_accel_mean_y
time_gravity_accel_mean_z
time_gravity_accel_std_x
time_gravity_accel_std_y
time_gravity_accel_std_z
time_body_accel_jerk_mean_x
time_body_accel_jerk_mean_y
time_body_accel_jerk_mean_z
time_body_accel_jerk_std_x
time_body_accel_jerk_std_y
time_body_accel_jerk_std_z
time_body_gyro_mean_x
time_body_gyro_mean_y
time_body_gyro_mean_z
time_body_gyro_std_x
time_body_gyro_std_y
time_body_gyro_std_z
time_body_gyro_jerk_mean_x
time_body_gyro_jerk_mean_y
time_body_gyro_jerk_mean_z
time_body_gyro_jerk_std_x
time_body_gyro_jerk_std_y
time_body_gyro_jerk_std_z
time_body_accel_magnitude_mean
time_body_accel_magnitude_std
time_gravity_accel_magnitude_mean
time_gravity_accel_magnitude_std
time_body_accel_jerk_magnitude_mean
time_body_accel_jerk_magnitude_std
time_body_gyro_magnitude_mean
time_body_gyro_magnitude_std
time_body_gyro_jerk_magnitude_mean
time_body_gyro_jerk_magnitude_std
freq_body_accel_mean_x
freq_body_accel_mean_y
freq_body_accel_mean_z
freq_body_accel_std_x
freq_body_accel_std_y
freq_body_accel_std_z
freq_body_accel_jerk_mean_x
freq_body_accel_jerk_mean_y
freq_body_accel_jerk_mean_z
freq_body_accel_jerk_std_x
freq_body_accel_jerk_std_y
freq_body_accel_jerk_std_z
freq_body_gyro_mean_x
freq_body_gyro_mean_y
freq_body_gyro_mean_z
freq_body_gyro_std_x
freq_body_gyro_std_y
freq_body_gyro_std_z
freq_body_accel_magnitude_mean
freq_body_accel_magnitude_std
freq_body_body_accel_jerk_magnitude_mean
freq_body_body_accel_jerk_magnitude_std
freq_body_body_gyro_magnitude_mean
freq_body_body_gyro_magnitude_std
freq_body_body_gyro_jerk_magnitude_mean
freq_body_body_gyro_jerk_magnitude_std


*** Second Data Set ***
The second data set is stored in the variable 'avg_set'.  The same columns
defined above in the first dataset, are repeated in the second data set, except
that the calculation variables have a 'avg_' appended to the beginning of the 
column name.  These variables represent the average (or mean) of the first
data set's values when grouped by subject and activity.
Cleaning Data Project 1
======================

Author: Moses McCall
Date: 6/27/2014
Description:
This repository is the 


run_analysis.r: The script serves two purposes. It merges the training and test smart phone activity data collected from experiment of 30 subjects between the ages of 19-48.
The source data can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Secondly, the script outputs the calculated averages of each variable for each activity and subject. 

smartphone_activity.csv: This is the generated file containing the merged data including all of the mean and standard deviation measurements
avg_smartphone_activity.csv: This file includes the outputed calulated averages of each acivity and subject.

The generated data files are using the tidy format with the following features:
* Each measured variable is in one column
* Each observiation of that variable is in a different row
* The first row has a variable name that is human readable which refers to the decription of the measurement col collected

Explaination of Feature Nomenclature:
-------------------------------------
Use the following combination of propertiesas an guide for the explaination of the variables. 

x, y, z: coordinates of data collected 
Time: time domain measurement
Frequency: Frequency domain measurement calculated using the Fast Fourier Transform
Magnitude: magnitude of the signal
accelerometer: measurement collected using accelerometer
gyroscope: measurement collected using gyroscope
jerk: jerk signal as a combination of the body linear acceleration and angular velocity
body: body accelleration
mean: mean value
std: standard deviation value
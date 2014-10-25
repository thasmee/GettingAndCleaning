Getting And Cleaning Data Course Project
==================

The course project of coursera course of Getting and Cleaning data

In this code the two libraries are used

1. library(data.table)
2. library(stringr)


#Assuming the dataset is uploaded into the working directory, the script in the run_analysis perform:

Read training and test datasets:

trainx<-read.table("./UCI/train/X_train.txt", header=FALSE, na.strings="NA",stringsAsFactors=FALSE)

trainy<-read.table("./UCI/train/y_train.txt", header=FALSE, na.strings="NA",stringsAsFactors=FALSE)

trainsub<-read.table("./UCI/train/subject_train.txt", header=FALSE, na.strings="NA",stringsAsFactors=FALSE)

train<-cbind(trainx,trainy,trainsub)

testx<-read.table("./UCI/test/X_test.txt", header=FALSE, na.strings="NA",stringsAsFactors=FALSE)

testy<-read.table("./UCI/test/y_test.txt", header=FALSE, na.strings="NA",stringsAsFactors=FALSE)

testsub<-read.table("./UCI/test/subject_test.txt", header=FALSE, na.strings="NA",stringsAsFactors=FALSE)

test<-cbind(testx,testy,testsub)

#Merge the train and test tests to create one dataset of 10299 obs. of  563 variables, where the last two variables are activity and subject

data<-rbind(train,test)

#Extracting the mean and standard deviation reated variables.

Here all the varaibles that represents any average (mean) or standard deviation is extrcted. Thereby 86 variables are identified and extracted from the features.txt including their indexes

#Feature set
dat2<-read.table("./UCI/features.txt", header=FALSE, na.strings="NA",stringsAsFactors=FALSE)
colnames(dat2)=c("Index", "Features")

#Extracting features related to mean 
feat1<-dat2[grep("mean", as.character(dat2$Features), ignore.case = TRUE, fixed=FALSE), ]

#and std
feat2<-dat2[grep("std", as.character(dat2$Features), ignore.case = TRUE, fixed=FALSE), ]
#combine
feat<-rbind(feat1,feat2)

f<-feat[with(feat,order(feat$Index)), ] #Order accoring to the apperence of the variables in the dataset

#Column numbers of the features containing mean and std
featIndex<-f[,1]


#2. Extract only the measurements on the mean and standard deviation for each measurement. 
This was done using the index created for the featureset (featIndex). 

#3. Uses descriptive activity names to name the activities in the data set

Here the original names are used as it is to keep the track of which, just removed non alpha characters that limits R usage of them as column variables

featNames<-gsub("\\(|\\)|-|\\,","",f[,2])

These featres are mapped to the mean and std data frame column names

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Didnt use any extra package sine the dataframe is not that big, just used double for loop over the number of activites and the subjects. 

The final data frame (subact) contains the averages over the 86 variables for each subject and activity. the subjects and activities are in the final two columns. 

head(subact[, c(1,2,86,87,88)])

  tBodyAccmeanX tBodyAccmeanY angleZgravityMean activity Subjects
  
1     0.2773308   -0.01738382       0.068858912        1        1

2     0.2764266   -0.01859492      -0.036889283        1        2

3     0.2755675   -0.01717678       0.117403280        1        3

4     0.2785820   -0.01483995      -0.067517986        1        4

5     0.2778423   -0.01728503       0.020033815        1        5

6     0.2836589   -0.01689542      -0.001303643        1        6




The data frame is written to a file out.txt



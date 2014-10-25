##Course project

##libraries
library(data.table)
library(stringr)


##Read training and test datasets 

trainx<-read.table("./UCI/train/X_train.txt", header=FALSE, na.strings="NA",stringsAsFactors=FALSE)
trainy<-read.table("./UCI/train/y_train.txt", header=FALSE, na.strings="NA",stringsAsFactors=FALSE)
trainsub<-read.table("./UCI/train/subject_train.txt", header=FALSE, na.strings="NA",stringsAsFactors=FALSE)

train<-cbind(trainx,trainy,trainsub)

testx<-read.table("./UCI/test/X_test.txt", header=FALSE, na.strings="NA",stringsAsFactors=FALSE)
testy<-read.table("./UCI/test/y_test.txt", header=FALSE, na.strings="NA",stringsAsFactors=FALSE)
testsub<-read.table("./UCI/test/subject_test.txt", header=FALSE, na.strings="NA",stringsAsFactors=FALSE)
test<-cbind(testx,testy,testsub)

#1. Merges the training and the test sets to create one data set.
data<-rbind(train,test)

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

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
meanstd<-data[ , c(featIndex,562:563)]

#3. Uses descriptive activity names to name the activities in the data set
#Used original names, just removed non alpha characters that makes illegal names
featNames<-gsub("\\(|\\)|-|\\,","",f[,2])

#4. Appropriately labels the data set with descriptive variable names. 
colnames(meanstd)=c(featNames,"activity","Subjects")

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

subact=data.frame()

for(i in 1:6){
  for(j in 1:30){
    sub<-subset(meanstd, (meanstd$activity == i & meanstd$Subjects == j))
    x=nrow(sub)
    if (x != 0){
      submean<-colMeans(sub)
    subact<-rbind(subact,submean)
    }
    
  }
}
colnames(subact)=c(featNames,"activity","Subjects")

write.table(subact, row.name=FALSE,file = "out.txt")

#This scripts implements functions for getting and cleaning data

read_dataset_xy <- function(f_x, names_x, f_y, names_y, labels) {
	#read sensor data
    x <- read.table(f_x, col.names = names_x)
    
    #store only columns containing mean and std data
    x <- subset(x, select=grep("mean()|std()", colnames(x)))
	
    #read activity data
    y <- read.table(f_y, col.names = names_y)
    
	#convert y vals to human-readable chars	
    lc <- as.character(labels$V2)
	y$activity <- as.character(y$activity)
	for(i in 1:nrow(labels)) y$activity[which((y$activity == labels$V1[i]))] <- lc[i]
	
    #combine x and y data
	x <- cbind(x, y)
	return(x)
}

merge_test_train <- function(data_test, data_train) {
    #derive combined dataset
	data_merged <- rbind(data_test, data_train)
	return(data_merged)
}

avg_by_activity <- function(dataset, labels) {
    #create empty dataframe for storing tidy data
    avg <- NULL
    
    for(i in 1:length(labels$V2)) {
        a <- subset(dataset, dataset$activity == labels$V2[i])
        
        #calculate averages for columns of ith activity
        c <- colMeans(Filter(is.numeric, a))
    
        #merge new and old tidy data 
        avg <- rbind(avg, c)
    }
    activity <- as.character(labels$V2)
    
    #return full tidy data
    return(cbind(avg, activity))
}

main <- function() {
	#get working directory path
	wd <- getwd()
    
	#derive file names for test and training data sets (X and Y files for each)
	f_x_test <- paste(wd, "/X_test.txt", sep="")
	f_y_test <- paste(wd, "/Y_test.txt", sep="")
	f_x_train <- paste(wd, "/X_train.txt", sep="")
	f_y_train <- paste(wd, "/Y_train.txt", sep="")
	f_labels <- paste(wd, "/activity_labels.txt", sep="")
	f_features <- paste(wd, "/features.txt", sep="")
	f_tidy <- paste(wd, "/tidy_dataset.txt", sep="")

	#prepare column names
	features <- read.table(f_features)
    names_x <- features$V2
	names_y <- c("activity")
	
	#get activity labels
	labels <- read.table(f_labels)
    
    #read datasets
	x_test <- read_dataset_xy(f_x_test, names_x, f_y_test, names_y, labels)
	x_train <- read_dataset_xy(f_x_train, names_x, f_y_train, names_y, labels)
	
    #merge datasets
    x_merged <- merge_test_train(x_test, x_train)
	
    #generate tidy dataset of averages by feature and activity type
    tidy_data <- avg_by_activity(x_merged, labels)
    
    #write tidy dataset to txt file (optional)
	write.table(tidy_data, f_tidy, row.names=F)
    
    #return tidy dataset as a dataframe
	return(tidy_data)
}

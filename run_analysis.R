#getting and cleaning data

read_dataset_xy <- function(f_x, names_x, f_y, names_y, f_labels) {
	#read x and y data
	#only relevant columns 1:6 contain avg and std data
	#give relevant columns readable names
	#ensure remaining columns are skipped (set colClass to "NULL")
	mycolclass <- c(rep("numeric", 6), rep("NULL", 555))
	x <- read.table(f_x, colClasses = mycolclass)
	colnames(x) <- names_x
	y <- read.table(f_y, col.names = names_y)
	labels <- read.table(f_labels)
	
	#convert y vals to human-readable chars
	lc <- as.character(labels$V2)
	y$activity <- as.character(y$activity)
	for(i in 1:nrow(labels)) y$activity[which((y$activity == labels$V1[i]))] <- lc[i]
	#combine x and y data
	x <- cbind(x, y)
	return(x)
}

merge_test_train <- function(data_test, data_train) {
	data_merged <- rbind(data_test, data_train)
	return(data_merged)
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
	f_tidy <- paste(wd, "/tidy_dataset.txt", sep="")

	#prepare column names
	names_x <- c("tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", "tBodyAcc-mean()-Z", "tBodyAcc-std()-X", "tBodyAcc-std()-Y", "tBodyAcc-std()-Z")
	names_y <- c("activity")
	
	x_test <- read_dataset_xy(f_x_test, names_x, f_y_test, names_y, f_labels)
	x_train <- read_dataset_xy(f_x_train, names_x, f_y_train, names_y, f_labels)
	x_merged <- merge_test_train(x_test, x_train)
	
    #write tidy dataset to txt file (optional)
	write.table(x_merged, f_tidy, row.names=F)
    
    #return tidy dataset
	return(x_merged)
}

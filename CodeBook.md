getcleandata
============

## Variables:
- The variables (column names) specify the type of features captured by the smartphone sensors.
- Please see features_info.txt for more details.

## Data
- The sensor data was provided in a txt file for the test and training datasets (X_test.txt and X_train.txt, respectively). The data was given in exponential form (e.g. "2.5717778e-001").
- Feature names were provided in a separate file for the test and training datasets (Y_test.txt and Y_train.txt, respectively).

## Data Cleaning Transformations
The data cleaning steps are encapsulated in functions in the script "run_analysis.R".

*read_dataset_xy()*
- Combines sensor data and the corresponding feature names.
- Dataset is cropped to retain only the mean and std data, to give clean dataset.
- The activity numbers in the raw data are replaced with more descriptive activity names.

*merge_test_train()*
- A clean training dataset is appended below a clean test dataset.
- Assumes that datasets passed to this function are in fact clean.

*main()*
- Encapsulates the high-level data cleaning function sequence, and returns the tidy dataset.
- To keep the call to main() simple, file names of input data are hardcoded inside the function body instead of passing them as arguments to main().
- It is assumed that all necessary input files are at the root of the working directory.
- For convenience, the tidy dataset is written out to txt file ("tidy_dataset.txt").

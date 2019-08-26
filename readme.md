# Stata Data Management Functions

A series of commands to help ease the data management process in STATA.

These commands generally help to make checking for data consistency easier in STATA, especially for the purposes of academic research.

The current commands in this repository:

1. checkid
checkid helps to check for the number of unique IDs in the data, and also asserts for the number of unique IDs if there is suppose to be a fixed number of unique IDs in the dataset.

2. checkrange
checkrange is a simple function that helps to check if the varlist provided has values within a specified min and max range. Do include the missing option to provide the function with a list of valid missing values.

3. checkobs
A relatively less useful function that serves to assert the amount of observations available in the dataset. It can also help to assert the amount of variables in the dataset.

Please use the command
```
help checkid
```
for any of the commands to above.

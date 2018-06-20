# Pollutant Data
The folder specdata contains 332 csv files with nitrate and sulfate concentrations 
gathered from monitors accross the US.  Each csv file represents the data gathered 
from one montior over a period of time.  

There are three functions in pollutantmean.R, each designed to assist with evaluating 
the data gathered by the monitors.  

pollutantmean - Takes three arguments, directory, pollutant, and id
- 'directory' is a character vector of length 1 indicating the location of the CSV files
- 'pollutant' is a character vector of length 1 indicating the name of the pollutant for 
which the mean is calculated, either "sulfate" or "nitrate"
- 'id' is an integer vector indicating the monitor ID numbers to be used
- The function returns the mean of the pollutant across all montiors listed in the 'id' 
vector (ignoring NA values)

complete - Takes two arguements, directory and id
- 'directory' is a character vector of length 1 indicating the location of the CSV files
- 'id' is an integer vector indicating the monitor ID numbers to be used
- The function returns a dataframe containing the monitor ID number and the number of 
complete cases recorded by the monitor

corr - Takes two argumetns, directory and threshold
- 'directory' is a character vector of length 1 indicating the location of the CSV files
- 'threshold' is a character vector of length 1 indicating the number of completely observed 
observations (on all variables) required to compute the correlation
- The function returns a vector with the correlation calculated between sulfate and nitrate 
for each monitor that meets the threshold.

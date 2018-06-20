pollutantmean <- function(directory, pollutant, id = 1:332){
  ## 'directory' is a character vector of length 1 indicating the location of the CSV files
  
  ## 'pollutant' is a character vecotr of length 1 indicating the name of the pollutant 
  ## for which we will calculate the mean, either "sulfate" or "nitrate."
  
  ## 'id' is an integer vector indicating the monitor ID numbers to be used.
  
  ## Return the mean of the pollutant across all montiors list in the 'id' vector (ignoring NA values)
  
  ## First make a list of files in directory
  monitorfiles <- list.files(directory, full.names = TRUE)
  
  ## Make an empty data frame to store these files
  monitordata <- data.frame()
  
  ## Put the requested monitor files into the data frame
  for (i in id) {
    monitordata <- rbind(monitordata, read.csv(monitorfiles[i]))
  }
  
  ## Calculate mean for poluntant
  mean(monitordata[ , pollutant], na.rm = TRUE)
}

complete <- function(directory, id=1:332) {
  ##'directory' is a character vector of length 1 indicating the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## where 'id' is the monitor number and 'nobs' is the number of complete cases
  
  ## First make a list of files in directory
  monitorfiles <- list.files(directory, full.names = TRUE)
  
  ## Make an empty data frame to store these files
  monitordata <- data.frame()
  
  ## Put the requested monitor files into the data frame
  for (i in id) {
    tempdataframe <- data.frame()
    tempdataframe <- read.csv(monitorfiles[i])
    
    ## Evaluate complete cases and add the sum to monitordata
    monitordata <- rbind(monitordata, data.frame(i, nrow(tempdataframe[complete.cases(tempdataframe), ])))
   
  }
  ## Label result
  names(monitordata) <- c("id", "nobs")
  monitordata
  
}

corr <- function(directory, threshold = 0){
  ## 'directory is a character vector of length 1 indicating the location of the CSV files
  
  ## 'threshold' is a character vector of length 1 indicating the number of completely observed 
  ## observations (on all variables) required to compute the correlation between nitrate and sulfate, 
  ## the default is 0
  
  ## Return a numeric vector of correlations
  
  ## First make a list of files in directory
  monitorfiles <- list.files(directory, full.names = TRUE)
  
  ## Make an empty vector to store these files
  corrdata <- c()
  
  id <- length(monitorfiles)
  
  ## Put the requested monitor files into the data frame
  for (i in 1:id) {
    
    ## Calculate the number of complete observations
    nobscomplete <- complete(directory, i)
    
    ## If the number of complete observations is greater than the threshold, 
    ## Add the correlation to the data frame
    if (nobscomplete[2] > threshold){
      tempdataframe <- data.frame()
      tempdataframe <- read.csv(monitorfiles[i])
      
      x <- cor(tempdataframe$sulfate, tempdataframe$nitrate, use = "pairwise.complete.obs")
      corrdata <- c(corrdata, x)
    }
    
    
   
    
  }
  
  corrdata
}
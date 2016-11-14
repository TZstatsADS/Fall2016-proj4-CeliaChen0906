###Music Mining

source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")
library(rhdf5)
library(dplyr)

load("lyr.RData")
sound1<-h5read("/Users/zc2320/Downloads/Project4_data/data/A/A/A/TRAAABD128F429CF47.h5", "/analysis")
sound2<-h5read("/Users/zc2320/Downloads/Project4_data/data/A/A/A/TRAAAFD128F92F423A.h5", "/analysis")
names(sound)

sound$songs
dir.h5 <- './data/'
files.list <- as.matrix(list.files(dir.h5, recursive = TRUE))
song.features.df <- get.features(files.list, dir.h5)

####Extract feature function
get.features <- function(files.list, directory){
  
  # counters to see progress
  num <- 0  
  total <- length(files.list)
  
  # Loop through all the data files, collect results as a list.
  library(pbapply)
  features <- pblapply(files.list, function(x, dir){
    
    file <- paste0(dir,x)
    h5f <- h5dump(file, load = TRUE)
    analysis <- h5f$analysis
    var <- analysis$songs
    H5close()
    
    return(var)
  },
  dir = directory
  )
  

  
  # Transform list into a data frame
  
  song.features.df <- data.frame()
  
  
  return(song.features.df)
}



###Music Mining

source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")
library(rhdf5)
install.packages("dplyr")
library(dplyr)
install.packages("pbapply")
library(pbapply)

load("lyr.RData")
#load("song_feature_5.RData")
sound1<-h5read("./data/A/A/A/TRAAABD128F429CF47.h5", "/analysis")
sound2<-h5read("./data/A/A/A/TRAAAFD128F92F423A.h5", "/analysis")
test1 <- h5dump("/Users/zc2320/Downloads/TestSongFile100/testsong1.h5", load = T)

dir.h5 <- './data/'
files.list <- as.matrix(list.files(dir.h5, recursive = TRUE))
song.features.df <- get.features(files.list, dir.h5)

####Extract feature function
get.features <- function(files.list, directory){
  
  # counters to see progress
  num <- 0  
  total <- length(files.list)
  
  # Loop through all the data files, collect results as a list.
  
  features <- pblapply(files.list, function(x, dir){
    
    file <- paste0(dir,x)
    h5f <- h5dump(file, load = TRUE)
 
    #bars feature
    bars <- diff(h5f$analysis$bars_start)
    bars <- mean(bars, na.rm = TRUE)
   
    
    #beats feature
    beats <- diff(h5f$analysis$beats_start)
    beats <- mean(beats, na.rm = TRUE)
    
    #sections feature
    if (length(h5f$analysis$sections_start) > 5) {
      sections <- diff(h5f$analysis$sections_start)
      sections <- kmeans(sections, centers = 3, iter.max = 5, algorithm="Lloyd")
      sections <- sections$centers
    }else{
      sections <- mean(diff(h5f$analysis$sections_start), na.rm = TRUE)
      sections <- as.list(rep.int(sections, times = 3)) 
    }
    
    #loud max
    if (length(h5f$analysis$segments_loudness_max) > 5 ) {
      loud <- h5f$analysis$segments_loudness_max
      loud <- kmeans(loud, centers = 5, iter.max = 5, algorithm="Lloyd")
      loud <- loud$centers
      
    }else{
      loud <- mean(h5f$analysis$segments_loudness_max, na.rm = TRUE)
      loud <- as.list(rep.int(loud, times = 5))
    }
    
    #MCFF Segment
    mcff <- t(h5f$analysis$segments_timbre)
    mcff <- as.list(colMeans(mcff, na.rm = TRUE))
    
    #Tatums feature
    tatums <- diff(h5f$analysis$tatums_start)
    tatums <- mean(tatums, na.rm = TRUE)
   
    song <- substr(x, start = 7, stop = nchar(x)-3)
    H5close()
    
    return(c(song, bars, beats, sections, loud, mcff, tatums))
  },
  dir = directory
  )
  
  # Transform list into a data frame
  
  df1 <- unlist(features)
  df1 <- matrix(df1, byrow = TRUE, ncol = 24) 
  df1 <- data.frame(df1)
 
  names(df1) <- c('song',
                  'bars',
                  'beats', 
                  "m1","m2","m3","m4","m5","m6","m7","m8","m9","m10","m11","m12",
                  'segments1', 'segments2', 'segments3', 'segments4', 'segments5',
                  'sections1', 'sections2','sections3',
                  'tatums')

  df1$song <- as.character(df1$song)
  
  df1$bars <- df1$bars
  
  df1$beats <- df1$beats
  
  df1$m1 <- df1$mcff[[1]]
  df1$m2 <- df1$mcff[[2]]
  df1$m3 <- df1$mcff[[3]]
  df1$m4 <- df1$mcff[[4]]
  df1$m5 <- df1$mcff[[5]]
  df1$m6 <- df1$mcff[[6]]
  df1$m7 <- df1$mcff[[7]]
  df1$m8 <- df1$mcff[[8]]
  df1$m9 <- df1$mcff[[9]]
  df1$m10 <- df1$mcff[[10]]
  df1$m11 <- df1$mcff[[11]]
  df1$m12 <- df1$mcff[[12]]

  
  df1$sections1 <- df1$sections[[1]]
  df1$sections2 <- df1$sections[[2]]
  df1$sections3 <- df1$sections[[3]]
  
  
  df1$segments1 <- as.numeric(df1$loud[[1]])
  df1$segments2 <- as.numeric(df1$loud[[2]])
  df1$segments3 <- as.numeric(df1$loud[[3]])
  df1$segments4 <- as.numeric(df1$loud[[4]])
  df1$segments5 <- as.numeric(df1$loud[[5]])
  
  df1$tatums <- df1$tatums
  
  return(df1)
}

save(song.features.df, file = "song_feature_5.RData")











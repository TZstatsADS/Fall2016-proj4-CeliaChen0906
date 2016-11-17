###Music Mining

source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")
library(rhdf5)
install.packages("dplyr")
library(dplyr)

load("lyr.RData")
lyc <- lyr[, -c(2,3,6:30)]
sound1<-h5read("./data/A/A/A/TRAAABD128F429CF47.h5", "/analysis")
sound2<-h5read("./data/A/A/A/TRAAAFD128F92F423A.h5", "/analysis")
sound1$segments_timbre

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

####### H2O Install
# The following two commands remove any previously installed H2O packages for R.
if ("package:h2o" %in% search()) { detach("package:h2o", unload=TRUE) }
if ("h2o" %in% rownames(installed.packages())) { remove.packages("h2o") }

# Next, we download packages that H2O depends on.
if (! ("methods" %in% rownames(installed.packages()))) { install.packages("methods") }
if (! ("statmod" %in% rownames(installed.packages()))) { install.packages("statmod") }
if (! ("stats" %in% rownames(installed.packages()))) { install.packages("stats") }
if (! ("graphics" %in% rownames(installed.packages()))) { install.packages("graphics") }
if (! ("RCurl" %in% rownames(installed.packages()))) { install.packages("RCurl") }
if (! ("jsonlite" %in% rownames(installed.packages()))) { install.packages("jsonlite") }
if (! ("tools" %in% rownames(installed.packages()))) { install.packages("tools") }
if (! ("utils" %in% rownames(installed.packages()))) { install.packages("utils") }

# Now we download, install and initialize the H2O package for R.
install.packages("h2o", type="source", repos=(c("http://h2o-release.s3.amazonaws.com/h2o/rel-tibshirani/8/R")))
library(h2o)
localH2O = h2o.init(nthreads=-1)

###Predicting Model

model <- list()
for(p in 2:5001){
  model[p] <- lm(lyr[,p] ~ song.features.df$bars + song.features.df$beats + song.features.df$sections1 + song.features.df$tatums)
}


pre <- list()
for(n in 1:100){
  for(i in 2:5001){
    dir.h5 <- './TestSongFile100/'
    files.list <- as.matrix(list.files(dir.h5, recursive = TRUE))
    test.df <- get.features(files.list, dir.h5)
   
     pre[n,i] <-predict(model[i], newdata = test.df)
  }
}
  
 
write.csv(pre, "predict.csv")
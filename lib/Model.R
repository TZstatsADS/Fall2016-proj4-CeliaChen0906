###Predicting Model

##read data
load("/Users/zc2320/Downloads/Fall2016-proj4-CeliaChen0906-master/data/song_feature_5.RData")
model <- list()
lyt <- lyr[, 2:5001]

##Prepare training and testing set
set.seed(123)
n <- nrow(lyr)
index <- c(1:n)
testindex <- sample(index, round(n/3))

train_data <- song.features.df[-testindex, ]
train_lab <- lyt[-testindex, ]

test_data <- song.features.df[testindex, ]
test_lab <- lyt[-testindex, ] 


##training Linear Probability Model for each topic
for(i in 1:5000) {
  model[i] <- lm(train_lab[, i] ~ train_data$bars + train_data$beats + train_data$sections1 + train_data$tatums)
  } 

##Examine prediction results in testing dataset
prr <- list()
sd <- list()
for(i in 1:5000){
  prr[i] <- predict(model[i], newdata = test_data[, -1])
  sd[i] <- squr((prr[i] - test_lab[,i]) ^ 2 / 5000)
  sd <- mean(sd)
}

##Make predictions
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

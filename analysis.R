# Analysis of data for Coursera MOOC Practical Machine Learning
# Peer Assessment 4
library(doMC)
library(caret)

# register multiple computational cores
registerDoMC(cores = 7)

# load training and testing data
data <- read.csv("../pml-training.csv")
measurements <- read.csv("../pml-testing.csv")

# partition the data into training and testing set
inTrain <- createDataPartition(y=data$classe, p=0.7, list=FALSE)
training <- data[inTrain,]
testing <- data[-inTrain,]

# extract testable part of the training set
predictables <- !is.na(testing[1,])

# clean the data
training <- training[, predictables]
testing <- testing[, predictables]
measurements <- measurements[, predictables]

# train using random forest training
rfFit <- train(classe ~ . - X - user_name - raw_timestamp_part_1 - raw_timestamp_part_2 - new_window - num_window, data = training, method = "rf", importance = T, PROX=TRUE)

# prediction
answers <- predict(rfFit, measurements)
# Analysis of data for Coursera MOOC Practical Machine Learning
# Peer Assessment 4
library(doMC)
library(caret)

# register multiple computational cores
registerDoMC(cores = 7)

# load training and testing data
training <- read.csv("../pml-training.csv")
testing <- read.csv("../pml-testing.csv")

# extract testable part of the training set
predictables <- !is.na(testing[1,])

# clean the data
training <- training[, predictables]
testing <- testing[, predictables]

# train using random forest training
rfFit <- train(classe ~ . - X - user_name - raw_timestamp_part_1 - raw_timestamp_part_2 - new_window - num_window, data = training, method = "rf", importance = T)

# prediction
answers <- predict(rfFit, testing)
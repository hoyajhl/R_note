install.packages("kknn", dependencies = TRUE)
install.packages("nnet") 


# k-Nearest Neigbor Learning (Classification) -----------------------------
# Performance Evaluation Function -----------------------------------------
perf_eval2 <- function(cm){
  
  # True positive rate: TPR (Recall)
  TPR <- cm[2,2]/sum(cm[2,])
  # Precision
  PRE <- cm[2,2]/sum(cm[,2])
  # True negative rate: TNR
  TNR <- cm[1,1]/sum(cm[1,])
  # Simple Accuracy
  ACC <- (cm[1,1]+cm[2,2])/sum(cm)
  # Balanced Correction Rate
  BCR <- sqrt(TPR*TNR)
  # F1-Measure
  F1 <- 2*TPR*PRE/(TPR+PRE)
  
  return(c(TPR, PRE, TNR, ACC, BCR, F1))
}

# Initialize the performance matrix
perf_mat <- matrix(0, 2, 6) #matrix(0,2,6): 0을 2*6의 matrix 형태로
colnames(perf_mat) <- c("TPR (Recall)", "Precision", "TNR", "ACC", "BCR", "F1")
rownames(perf_mat) <- c("Logistic Regression", "k-NN")
perf_mat

# kknn package install & call
install.packages("kknn", dependencies = TRUE)
library(kknn)
# install.packages("igraph", type="binary")
# Load the wdbc data
getwd() ##"C:/Users/Jaeho/Documents"


RawData <- read.csv("C:/Hoya/test/wdbc.csv", header = FALSE)

# Normalize the input data
head(RawData)
str(RawData)#569 obs. of  31 variables:
Class <- as.factor(RawData[,31])
InputData <- RawData[,1:30]
ScaledInputData <- scale(InputData, center = TRUE, scale = TRUE)
ScaledData <- data.frame(ScaledInputData, Class)


# Divide the dataset into the training (70%) and Validation (30%) datasets
set.seed(123)
trn_idx <- sample(1:length(Class), round(0.7*length(Class)))
wdbc_trn <- ScaledData[trn_idx,]
wdbc_tst <- ScaledData[-trn_idx,]

# Classification model 1: Logistic Regression
full_lr <- glm(Class ~ ., family=binomial, wdbc_trn)
summary(full_lr)

lr_response <- predict(full_lr, type = "response", newdata = wdbc_tst) # type="response" : 예측할 확률

lr_target <- wdbc_tst$Class  #test의 class 
lr_predicted <- rep(0, length(lr_target)) #0을 length의 크기 만큼 맞춰줌 
lr_predicted
lr_predicted[which(lr_response >= 0.5)] <- 1 #해당하는 위치에 1 넣어줌
lr_predicted

cm_logreg <- table(lr_target, lr_predicted)
cm_logreg

perf_mat[1,] <- perf_eval2(cm_logreg) #앞에 생성된 perf_mat 1행에 값 넣어 즘
perf_mat

# Perform k-nn classification with k=3, Distance = Euclidean, and weighted scheme = majority voting
kknn <- kknn(Class ~ ., wdbc_trn, wdbc_tst, k=3, distance=2, kernel = "rectangular")

# View the k-nn results
summary(kknn)
kknn$CL
kknn$W
kknn$D

table(wdbc_tst$Class, kknn$fitted.values)

# Visualize the classification results
knnfit <- fitted(kknn)
table(wdbc_tst$Class, knnfit)
pcol <- as.character(as.numeric(wdbc_tst$Class))
pairs(wdbc_tst[c(1,2,5,6)], pch = pcol, col = c("blue", "red")[(wdbc_tst$Class != knnfit)+1])

# 최적의 k값 찾기 (best parameter 찾기) using cross validation
# Leave-one-out validation for finding the best k
knntr <- train.kknn(Class ~ ., wdbc_trn, kmax=10, distance=2, kernel="rectangular")

knntr$MISCLASS
knntr$best.parameters #8

# Perform k-nn classification with the best k, Distance = Euclidean, and weighted scheme = majority voting
kknn_opt <- kknn(Class ~ ., wdbc_trn, wdbc_tst, k=knntr$best.parameters$k, 
                 distance=2, kernel = "rectangular")
fit_opt <- fitted(kknn_opt)
cm_knn <- table(wdbc_tst$Class, fit_opt)
cm_knn

perf_mat[2,] <- perf_eval2(cm_knn)
perf_mat


##Artificial Neural Net###
# Part 1: Multi-class classification with ANN & Multinomial logistic regression
# Performance evaluation function for multi-class classification ----------

##multi classification을 위한 함수 생성
perf_eval_multi <- function(cm){
  
  # Simple Accuracy
  ACC = sum(diag(cm))/sum(cm)
  
  # Balanced Correction Rate
  BCR = 1
  for (i in 1:dim(cm)[1]){
    BCR = BCR*(cm[i,i]/sum(cm[i,])) 
  }
  
  BCR = BCR^(1/dim(cm)[1])
  
  return(c(ACC, BCR))
}
library(nnet)

# Multi-class classification
ctgs_data <- read.csv("C:/Hoya/test/ctgs.csv")
dim(ctgs_data) #2126   22
n_instance <- dim(ctgs_data)[1]
n_var <- dim(ctgs_data)[2]

# Conduct normalization
ctgs_input <- ctgs_data[,-n_var]
ctgs_target <- ctgs_data[,n_var]

ctgs_input <- scale(ctgs_input, center = TRUE, scale = TRUE)
ctgs_target <- as.factor(ctgs_target)

ctgs_data_normalized <- data.frame(ctgs_input, Class = ctgs_target)

# Initialize performance matrix
perf_summary <- matrix(0, nrow = 2, ncol = 2)
colnames(perf_summary) <- c("ACC", "BCR")
rownames(perf_summary) <- c("Multi_Logit", "ANN")
perf_summary

# Split the data into the training/validation sets
set.seed(123)
trn_idx <- sample(1:n_instance, round(0.8*n_instance))
ctgs_trn <- ctgs_data_normalized[trn_idx,]
ctgs_tst <- ctgs_data_normalized[-trn_idx,]

# Multinomial logistic regression -----------------------------------------
# Train multinomial logistic regression 
#<다항 로지스틱 회귀분석>

ml_logit <- multinom(Class ~ ., data = ctgs_trn)

# Check the coefficients
summary(ml_logit)
t(summary(ml_logit)$coefficients)

# Predict the class label
ml_logit_prey <- predict(ml_logit, newdata = ctgs_tst)

cfmatrix <- table(ctgs_tst$Class, ml_logit_prey)
cfmatrix
perf_summary[1,] <- perf_eval_multi(cfmatrix)
perf_summary

# Artificial Neural Network -----------------------------------------------
# Train ANN
ann_trn_input <- ctgs_trn[,-n_var]
ann_trn_target <- class.ind(ctgs_trn[,n_var])

# Find the best number of hidden nodes in terms of BCR
# Candidate hidden nodes
nH <- seq(from=5, to=30, by=5)
nH ##은닉 노드의 수 5 10 15 20 25 30
# 5-fold cross validation index
val_idx <- sample(c(1:5), dim(ann_trn_input)[1], replace = TRUE, prob = rep(0.2,5))
val_idx
val_perf <- matrix(0, length(nH), 3)

ptm <- proc.time()

for (i in 1:length(nH)) {
  
  cat("Training ANN: the number of hidden nodes:", nH[i], "\n")
  eval_fold <- c()
  
  for (j in c(1:5)) {
    
    # Training with the data in (k-1) folds
    tmp_trn_input <- ann_trn_input[which(val_idx != j),]
    tmp_trn_target <- ann_trn_target[which(val_idx != j),]    
    tmp_nnet <- nnet(tmp_trn_input, tmp_trn_target, size = nH[i], decay = 5e-4, maxit = 500)
    
    # Evaluate the model withe the remaining 1 fold
    tmp_val_input <- ann_trn_input[which(val_idx == j),]
    tmp_val_target <- ann_trn_target[which(val_idx == j),]    
    
    eval_fold <- rbind(eval_fold, cbind(max.col(tmp_val_target), 
                                        max.col(predict(tmp_nnet, tmp_val_input))))
    
  }
  
  # Confusion matrix
  cfm <- table(eval_fold[,1], eval_fold[,2])
  
  # nH
  val_perf[i,1] <-nH[i]
  
  # Record the validation performance
  val_perf[i,2:3] <- perf_eval_multi(cfm)
}

proc.time() - ptm


##순서대로 order 정렬하는 함수:) 
order(val_perf[,3], decreasing = TRUE) #5 6 4 2 1 3
val_perf

ordered_val_perf <- val_perf[order(val_perf[,3], decreasing = TRUE),]
ordered_val_perf
colnames(ordered_val_perf) <- c("nH", "ACC", "BCR")
ordered_val_perf

# Find the best number of hidden node
best_nH <- ordered_val_perf[1,1]
best_nH
# Test the ANN
ann_tst_input = ctgs_tst[,-n_var]
ann_tst_target = class.ind(ctgs_tst[,n_var])

##using best number of hidden node 다시 학습
ctgs_nnet <- nnet(ann_trn_input, ann_trn_target, size = best_nH, decay = 5e-4, maxit = 500)

# Performance evaluation
prey <- predict(ctgs_nnet, ann_tst_input)
tst_cm <- table(max.col(ann_tst_target), max.col(prey))
tst_cm

perf_summary[2,] <- perf_eval_multi(tst_cm)
perf_summary
# bagging

library(mlbench)
data(PimaIndiansDiabetes2)
str(PimaIndiansDiabetes2)
head(PimaIndiansDiabetes2)
summary(PimaIndiansDiabetes2)

# 데이터 전처리

PimaIndiansDiabetes2 = na.omit(PimaIndiansDiabetes2)
summary(PimaIndiansDiabetes2)
#     pregnant         glucose         pressure         triceps     
#  Min.   : 0.000   Min.   : 56.0   Min.   : 24.00   Min.   : 7.00
#  1st Qu.: 1.000   1st Qu.: 99.0   1st Qu.: 62.00   1st Qu.:21.00
#  Median : 2.000   Median :119.0   Median : 70.00   Median :29.00
#  Mean   : 3.301   Mean   :122.6   Mean   : 70.66   Mean   :29.15  
#  3rd Qu.: 5.000   3rd Qu.:143.0   3rd Qu.: 78.00   3rd Qu.:37.00  
#  Max.   :17.000   Max.   :198.0   Max.   :110.00   Max.   :63.00
#     insulin            mass          pedigree           age        diabetes
#  Min.   : 14.00   Min.   :18.20   Min.   :0.0850   Min.   :21.00   neg:262  
#  1st Qu.: 76.75   1st Qu.:28.40   1st Qu.:0.2697   1st Qu.:23.00   pos:130
#  Median :125.50   Median :33.20   Median :0.4495   Median :27.00
#  Mean   :156.06   Mean   :33.09   Mean   :0.5230   Mean   :30.86
#  3rd Qu.:190.00   3rd Qu.:37.10   3rd Qu.:0.6870   3rd Qu.:36.00
#  Max.   :846.00   Max.   :67.10   Max.   :2.4200   Max.   :81.00

# 분석 모형 구축
train.idx = sample(
    1:nrow(PimaIndiansDiabetes2),
    size=nrow(PimaIndiansDiabetes2)*2/3
)
train = PimaIndiansDiabetes2[train.idx,]
test = PimaIndiansDiabetes2[-train.idx, ]

# 배깅 함수 사용
# install.packages('ipred')
library(ipred)
md.bagging = bagging(
    diabetes~.,
    data=train, nbagg = 25
)
# md.bagging
# Bagging classification trees with 25 bootstrap replications

# Call: bagging.data.frame(formula = diabetes ~ ., data = train, nbagg = 25)

# 분석 모형 평가 
pred = predict(md.bagging, test)
library(caret)
confusionMatrix(
    as.factor(pred),
    test$diabetes,
    positive='pos'
)

# Confusion Matrix and Statistics

#           Reference
# Prediction neg pos
#        neg  80  21
#        pos   6  24

#                Accuracy : 0.7939
#                  95% CI : (0.7145, 0.8596)
#     No Information Rate : 0.6565
#     P-Value [Acc > NIR] : 0.0004151

#                   Kappa : 0.5036

#  Mcnemar's Test P-Value : 0.0070536

#             Sensitivity : 0.5333
#             Specificity : 0.9302
#          Pos Pred Value : 0.8000
#          Neg Pred Value : 0.7921
#              Prevalence : 0.3435
#          Detection Rate : 0.1832
#    Detection Prevalence : 0.2290
#       Balanced Accuracy : 0.7318

#        'Positive' Class : pos

# 부스팅

# 분석 모형 구축
# install.packages('xgboost')
library(xgboost)
train.label=as.integer(train$diabetes)-1
mat_train.data=as.matrix(train[, -9])
mat_test.data=as.matrix(test[, -9])

xgb.train = xgb.DMatrix(
    data = mat_train.data,
    label = train.label
)
xgb.test = xgb.DMatrix(
    data = mat_test.data
)
param_list = list(
    booster = 'gbtree',
    eta = 0.001,
    max_depth = 10,
    gamma = 5,
    subsample = 0.8,
    colsample_bytree = 0.8,
    objective = 'binary:logistic',
    eval_metric = 'auc'
)
md.xgb = xgb.train(
    params = param_list,
    data = xgb.train,
    nrounds = 200,
    early_stopping_rounds = 10,
    watchlist = list(val1 = xgb.train),
    verbose=1
)

# [1]     val1-auc:0.792313 
# Will train until val1_auc hasn't improved in 10 rounds.

# [2]     val1-auc:0.859459 
# [3]     val1-auc:0.859459
# [4]     val1-auc:0.878610 
# [5]     val1-auc:0.882152 
# [6]     val1-auc:0.881150 
# [7]     val1-auc:0.890742
# [8]     val1-auc:0.891009 
# [9]     val1-auc:0.890909 
# [10]    val1-auc:0.892914
# [11]    val1-auc:0.894318 
# [12]    val1-auc:0.893082 
# [13]    val1-auc:0.892413 
# [14]    val1-auc:0.893783
# [15]    val1-auc:0.893048 
# [16]    val1-auc:0.891377 
# [17]    val1-auc:0.892112
# [18]    val1-auc:0.892513 
# [19]    val1-auc:0.889472
# [20]    val1-auc:0.889873 
# [21]    val1-auc:0.890241 
# Stopping. Best iteration:
# [11]    val1-auc:0.894318

# 분석 모형 평가
library(dplyr)
xgb.pred = predict(
    md.xgb,
    newdata = xgb.test
)
xgb.pred2 = ifelse(
    xgb.pred >= 0.5,
    xgb.pred <- 'pos',
    xgb.pred <- 'neg'
)
# ifelse 안에서는 = 로 하면 에러가 난다. 반드시 <-로 해줘야 함.
xgb.pred2 = as.factor(xgb.pred2)
library(caret)
confusionMatrix(
    xgb.pred2,
    test$diabetes,
    positive= 'pos'
)

# Confusion Matrix and Statistics

#           Reference
# Prediction neg pos
#        neg  78  23
#        pos   8  22

#                Accuracy : 0.7634
#                  95% CI : (0.6812, 0.8332)
#     No Information Rate : 0.6565
#     P-Value [Acc > NIR] : 0.005436

#                   Kappa : 0.43

#  Mcnemar's Test P-Value : 0.011921

#             Sensitivity : 0.4889
#             Specificity : 0.9070
#          Pos Pred Value : 0.7333
#          Neg Pred Value : 0.7723
#              Prevalence : 0.3435
#          Detection Rate : 0.1679
#    Detection Prevalence : 0.2290
#       Balanced Accuracy : 0.6979

#        'Positive' Class : pos



# 랜덤 포레스트
# install.packages('randomForest')
library(randomForest)
md.rf = randomForest(
    diabetes ~.,
    data = train,
    ntree=100,
    proximity=TRUE
)
print(md.rf)

# Call:
#  randomForest(formula = diabetes ~ ., data = train, ntree = 100,      proximity = TRUE) 
#                Type of random forest: classification
#                      Number of trees: 100
# No. of variables tried at each split: 2

#         OOB estimate of  error rate: 24.52%
# Confusion matrix:
#     neg pos class.error
# neg 154  22   0.1250000
# pos  42  43   0.4941176

importance(md.rf)
#          MeanDecreaseGini
# pregnant        10.760140
# glucose         25.962516
# pressure         8.373628
# triceps         10.613116
# insulin         18.244292
# mass            13.511800
# pedigree        10.673620
# age             15.948628


library(caret)
pred = predict(md.rf, test)
confusionMatrix(
    as.factor(pred),
    test$diabetes,
    positive= 'pos'
)

# Confusion Matrix and Statistics

#           Reference
# Prediction neg pos
#        neg  81  24
#        pos   5  21

#                Accuracy : 0.7786
#                  95% CI : (0.6978, 0.8465)
#     No Information Rate : 0.6565
#     P-Value [Acc > NIR] : 0.0016311

#                   Kappa : 0.4542

#  Mcnemar's Test P-Value : 0.0008302

#             Sensitivity : 0.4667
#             Specificity : 0.9419
#          Pos Pred Value : 0.8077
#          Neg Pred Value : 0.7714
#              Prevalence : 0.3435
#          Detection Rate : 0.1603
#    Detection Prevalence : 0.1985
#       Balanced Accuracy : 0.7043

#        'Positive' Class : pos
# bagging

library(mlbench)
data(PimaIndiansDiabetes2)
str(PimaIndiansDiabetes2)
head(PimaIndiansDiabetes2)
summary(PimaIndiansDiabetes2)

# 데이터 전처리

PimaIndiansDiabetes2 = na.omit(PimaIndiansDiabetes2)
summary(PimaIndiansDiabetes2)

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
md.bagging

# 분석 모형 평가 
pred = predict(md.bagging, test)
library(caret)
confusionMatrix(
    as.factor(pred),
    reference=test$diabetes,
    positive='pos'
)


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

# 분석 모형 평가
library(dplyr)
xgb.pred = predict(
    md.xgb,
    newdata = xgb.test
)
xgb.pred2 = ifelse(
    xgb.pred >= 0.5,
    xgb.pred = 'pos',
    xgb.pred = 'neg'
)
xgb.pred2 = as.factor(xgb.pred2)
library(caret)
confusionMatrix(
    xgb.pred2,
    test$diabetes,
    positive= 'pos'
)


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

importance(md.rf)

library(caret)
pred = predict(md.rf, test)
confusionMatrix(
    as.factor(pred),
    test$diabetes,
    positive= 'pos'
)
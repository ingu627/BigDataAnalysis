# 1. 백화점 고객의 1년 데이터 (dataq.or.kr 예시 문제)

X_train=read.csv('example_data/X_train.csv', stringsAsFactors=TRUE)
y_train=read.csv('example_data/y_train.csv', stringsAsFactors=TRUE)
X_test=read.csv('example_data/X_test.csv', stringsAsFactors=TRUE)

str(X_train)
head(X_train)
summary(X_train)
dim(X_train)

class(X_train$주구매지점)

str(y_train)
head(y_train) # cust_id gender

str(X_test)
head(X_test)
summary(X_test)
dim(X_test)

library(caret)

X_train$환불금액[is.na(X_train$환불금액)] <- 0
X_test$환불금액[is.na(X_test$환불금액)] <- 0

pre_X_train = preProcess(X_train, method="range")
pre_X_test = preProcess(X_test, method="range")

scaled_X_train = predict(pre_X_train, X_train)
scaled_X_test = predict(pre_X_test, X_test)

summary(scaled_X_train)
summary(scaled_X_test)
str(scaled_X_train)
str(scaled_X_test)

y_train$gender = as.factor(y_train$gender)

model_glm=glm(
    y_train$gender ~ .-cust_id, data=scaled_X_train,
    family='binomial')
summary(model_glm)

step_model = step(model_glm, direction = 'both')
summary(step_model)

library(ModelMetrics)
auc(y_train$gender, pred) # 0.6839781

pred_step_glm = predict(step_model, scaled_X_test, type='response')

summary(pred_step_glm)
head(pred_step_glm)

result = as.data.frame(cbind(X_test$cust_id, pred_step_glm))
names(result) <- c('cust_id', 'gender') 
head(result)

write.csv(result, '0000.csv', row.names=FALSE)





# 2. WA_Fn-UseC_-Telco-Customer-Churn

churn = read.csv(
    'sujebi_data/WA_Fn-UseC_-Telco-Customer-Churn.csv',
     stringsAsFactors =TRUE)

head(churn)
str(churn)
summary(churn)
dim(churn)

library(caret)
churn = na.omit(churn)
dim(churn)
idx=createDataPartition(churn$Churn, p=0.7)
str(idx)
x_train=churn[idx$Resample1,]
y_train=churn[idx$Resample1,]
x_test=churn[-idx$Resample1,]
y_test=churn[-idx$Resample1,]

dim(x_train)
dim(x_test)

model_x_train=preProcess(x_train, method="range")
model_x_test=preProcess(x_test, method="range")

scaled_x_train = predict(model_x_train, x_train)
scaled_x_test = predict(model_x_test, x_test)

library(e1071)

model_svm=svm(y_train$Churn ~.-customerID, scaled_x_train)
summary(model_svm)

pred = predict(model_svm, scaled_x_test)

confusionMatrix(pred, y_test$Churn) #  Accuracy : 0.7927

library(ModelMetrics)
auc(y_test$Churn, pred) # 0.6759252

# install.packages('randomForest')
library(randomForest)
model_random=randomForest(
    y_train$Churn ~.-customerID,
    data=scaled_x_train,
    ntree=300, do.trac=TRUE)
summary(model_random)

pred1 = predict(model_random, scaled_x_test)

confusionMatrix(pred1, y_test$Churn)
auc(y_test$Churn, pred1) # 0.6890504

write.csv(pred, 'y_test.csv', row.names=FALSE)


# 3. mtcars

data(mtcars)
head(mtcars)
str(mtcars)
summary(mtcars)
dim(mtcars)

library(caret)
idx=createDataPartition(mtcars$mpg, p=0.7)
str(idx)
x_train = mtcars[idx$Resample1, ]
x_test = mtcars[-idx$Resample1, ]

prePro_x_train = preProcess(x_train, method='range')
prePro_x_test = preProcess(x_test, method='range')

scaled_x_train = predict(prePro_x_train, x_train)
scaled_x_test = predict(prePro_x_test, x_test)

full_model = lm(mpg ~ ., data=scaled_x_train)
summary(full_model)

step_model = step(full_model, direction='both')
summary(step_model)

md_model = lm(mpg ~ disp+am+carb, data=scaled_x_train)
summary(md_model)

pred_lm=predict(md_model, newdata=scaled_x_test[, -1])

library(ModelMetrics)
rmse_lm = rmse(scaled_x_test$mpg, pred_lm)
print(rmse_lm) # 0.189796
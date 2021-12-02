# 11. BostonHousing

library(mlbench)
data(BostonHousing)
boston = BostonHousing
str(boston)

library(dplyr)
top_crim = head(sort(boston$crim, decreasing = TRUE), 10)
ten = top_crim[10]

boston$crim <- ifelse(boston$crim>=ten, ten, boston$crim)

boston = boston %>% filter(age>=80)
result = mean(boston$crim)
print(result)



# 12. housing

housing = read.csv('./2021_2nd_data/housing.csv', header=TRUE)
head(housing)
str(housing)
nrow(housing)

train = housing[1:(nrow(housing)*0.8),]
nrow(train)
before_sd = sd(train$total_bedrooms, na.rm = TRUE)

train$total_bedrooms = ifelse(is.na(train$total_bedrooms), median(train$total_bedrooms, na.rm = TRUE), train$total_bedrooms) 
after_sd = sd(train$total_bedrooms)
print(abs(before_sd - after_sd))
# [1] 1.975147

# 13. insurance

insurance=read.csv('./2021_2nd_data/insurance.csv')
head(insurance)
str(insurance)
summary(insurance)

sum(is.na(insurance$charges))

avg = mean(insurance$charges)  # 13270.42
sd1 =  sd(insurance$charges) # [1] 12110.01

library(dplyr)

insurance %>% 
    select(charges) %>% 
    filter(charges >= avg + 1.5*sd1 | charges <= avg - 1.5*sd1) %>% 
    sum()
# [1] 6421430


# 14. Train.csv

Train=read.csv('2021_2nd_data/Train.csv', stringsAsFactors=TRUE)
head(Train)
str(Train)
summary(Train)
dim(Train)
length(Train)

sum(is.na(Train))

names(Train)[1] <- c("ID")

Train$Reached.on.Time_Y.N = as.factor(Train$Reached.on.Time_Y.N)
str(Train$Reached.on.Time_Y.N)

library(caret)
idx=createDataPartition(Train$Reached.on.Time_Y.N, 0.7)
str(idx)
x_train = Train[idx$Resample1,]
x_test = Train[-idx$Resample1,]

prePro_xtrain = preProcess(x_train, method='range')
prePro_xtest = preProcess(x_test, method='range')

scaled_x_train = predict(prePro_xtrain, x_train)
scaled_x_test = predict(prePro_xtest, x_test)

# 로지스틱 회귀분석
model_glm = glm(Reached.on.Time_Y.N ~ .-ID, data=scaled_x_train, family='binomial')
summary(model_glm)

model_step = step(model_glm, direction='both')
summary(model_step)

pred_glm = predict(model_step, newdata=scaled_x_test[, -12], type='response')

pred_glm = ifelse(pred_glm >= 0.5, 1, 0)

confusionMatrix(pred_glm, x_test$Reached.on.Time_Y.N)

library(ModelMetrics)
auc(x_test$Reached.on.Time_Y.N, pred_glm) # 0.6187506

# 랜덤포레스트
library(randomForest)
model_rf=randomForest(Reached.on.Time_Y.N ~ .-ID, data=scaled_x_train, ntree=300)
summary(model_rf)

library(caret)
pred_rf = predict(model_rf, newdata=scaled_x_test[, -12], type='response')

confusionMatrix(pred_rf, x_test$Reached.on.Time_Y.N) # Accuracy : 0.6599

library(ModelMetrics)
auc(x_test$Reached.on.Time_Y.N, pred_rf) # 0.662148


total=as.data.frame(cbind(x_test$ID, pred_rf))
names(total) <- c('ID', 'Reached.on.Time_Y.N')
head(total)
summary(total)
write.csv(total, 'Train_result.csv', row.names=FALSE)





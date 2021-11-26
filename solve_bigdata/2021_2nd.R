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

housing = read.csv('./data/housing.csv', header=TRUE)
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

insurance=read.csv('./data/insurance.csv')
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

Train=read.csv('./data/Train.csv', encoding='utf-8')
head(Train)
str(Train)
summary(Train)
nrow(Train)
length(Train)

idx=sample(1:nrow(Train), 0.7*nrow(Train))

x_train = Train[idx, c(-1,-12)]
y_train = Train[idx, 12] 
x_test = Train[-idx, c(-1,-12)]
y_test = Train[-idx, 12]

sum(is.na(Train))

y_train = data.frame(Reached.on.Time_Y.N=as.factor(y_train))
y_test = data.frame(Reached.on.Time_Y.N=as.factor(y_test))

for (i in c(1,2,7,8)){
    x_train[,i] = as.factor(x_train[,i])
    x_test[,i] = as.factor(x_test[,i])
}
str(x_train)
str(y_train)

model=glm(y_train$Reached.on.Time_Y.N ~ ., data=x_train, family=binomial)
summary(model)

library(caret)
step_model = step(model, direction='both')
summary(step_model)

library(car)
vif(step_model)

pred = predict(
    step_model,
    newdata = x_test
)
df_pred = data.frame(pred)

head(df_pred)
df_pred$pred = ifelse(
    df_pred$pred >= 0.5,
    df_pred$pred <- 0,
    df_pred$pred <- 1)

df_pred$pred = as.factor(df_pred$pred)

library(caret)
confusionMatrix(df_pred,y_test)

library(ModelMetrics)
auc(y_test$Reached.on.Time_Y.N, df_pred$pred)

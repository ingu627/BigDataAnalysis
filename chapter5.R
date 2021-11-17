# 데이터 탐색
str(iris)
head(iris)
summary(iris)

# 분석 모형 구축
library(rpart)
md = rpart(Species ~. , data=iris)
md

plot(md, compress=TRUE, margin=0.5)
text(md, cex=1)

# 분석 모형 평가 
ls(md)
md$cptable

# 혼동 행렬
# install.packages('caret')
library(caret)
tree_pred = predict(
    md, newdata = iris, type = "class"
)
confusionMatrix(iris$Species, tree_pred)


# SVM
install.packages('e1071')
library(e1071)

model = svm(Species ~., data=iris)
model

pred = predict(model, iris)
library(caret)
confusionMatrix(iris$Species, pred)

# KNN
# install.packages('class')
library(class)

# 데이터 세트
data = iris[, c('Sepal.Length', 'Sepal.Width', 'Species')]
set.seed(1234)

# 변수 할당
idx = sample(
    x=c('train', 'valid', 'test'),
    size=nrow(data),
    replace=TRUE, prob=c(3,1,1))
train = data[idx == 'train',]
valid = data[idx == 'valid',]
test = data[idx == 'test',]

train_x = train[, -3]
valid_x = valid[, -3]
test_x = test[, -3]

train_y = train[, 3]
valid_y = valid[, 3]
test_y = test[, 3]

# 변수 선택
accuracy_k = NULL
for(i in c(1:nrow(train_x))){

    set.seed(1234)
    knn_k = knn(
        train = train_x,
        test = valid_x,
        cl = train_y, k = i
    )
    accuracy_k = c(
        accuracy_k, 
        sum(knn_k==valid_y) / length(valid_y))
}
valid_k = data.frame(
    k = c(1:nrow(train_x)),
    accuracy = accuracy_k)

plot(
    formula = accuracy ~ k,
    data = valid_k,
    type = 'o',
    pch = 20,
    main = 'validation - optimal k'
)

# 분류 정확도 최적화

min(valid_k[
    valid_k$accuracy %in% 
    max(accuracy_k), 'k'])
max(accuracy_k)

# 모형 평가
library(caret)
library(e1071)
knn_13 = knn(
    train = train_x,
    test= test_x,
    cl = train_y, k = 13 
)
confusionMatrix(knn_13, test_y)

# ANN

# 전처리
install.packages('nnet')
library(nnet)

data(iris)
iris.scaled = cbind(
    scale(iris[-5]),
    iris[5])

set.seed(1234)

index = c(
    sample(1:50, size=35),
    sample(51:100, size=35),
    sample(101:150, size=35)
)
train = iris.scaled[index,]
test = iris.scaled[-index,]

# 분석 모형 구축
set.seed(1234)
model.nnet = nnet(
    Species~.,
    data=train,
    size=2,
    maxit=200,
    decay=5e-04
)

summary(model.nnet)


# 나이브 베이즈 기법

library(e1071)
train_data = sample(1:150, size=100)

naive_model = naiveBayes(
    Species ~., data = iris,
    subset=train_data
)
naive_model

# 분석 모형 평가
library(caret)
pred= predict(naive_model, newdata=iris)
confusionMatrix(
    pred, iris$Species
)
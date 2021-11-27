# 데이터 탐색
str(iris)

# 'data.frame':   150 obs. of  5 variables:
#  $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
#  $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
#  $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
#  $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
#  $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...  
head(iris)
#   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
# 1          5.1         3.5          1.4         0.2  setosa
# 2          4.9         3.0          1.4         0.2  setosa
# 3          4.7         3.2          1.3         0.2  setosa
# 4          4.6         3.1          1.5         0.2  setosa
# 5          5.0         3.6          1.4         0.2  setosa
# 6          5.4         3.9          1.7         0.4  setosa
summary(iris)
#  Sepal.Length    Sepal.Width     Petal.Length    Petal.Width
#  Min.   :4.300   Min.   :2.000   Min.   :1.000   Min.   :0.100
#  1st Qu.:5.100   1st Qu.:2.800   1st Qu.:1.600   1st Qu.:0.300  
#  Median :5.800   Median :3.000   Median :4.350   Median :1.300
#  Mean   :5.843   Mean   :3.057   Mean   :3.758   Mean   :1.199
#  3rd Qu.:6.400   3rd Qu.:3.300   3rd Qu.:5.100   3rd Qu.:1.800  
#  Max.   :7.900   Max.   :4.400   Max.   :6.900   Max.   :2.500
#        Species
#  setosa    :50
#  versicolor:50
#  virginica :50


# 분석 모형 구축
library(rpart)
md = rpart(Species ~. , data=iris)
md
# n= 150

# node), split, n, loss, yval, (yprob)
#       * denotes terminal node

# 1) root 150 100 setosa (0.33333333 0.33333333 0.33333333)
#   2) Petal.Length< 2.45 50   0 setosa (1.00000000 0.00000000 0.00000000) *
#   3) Petal.Length>=2.45 100  50 versicolor (0.00000000 0.50000000 0.50000000)  
#     6) Petal.Width< 1.75 54   5 versicolor (0.00000000 0.90740741 0.09259259) *
#     7) Petal.Width>=1.75 46   1 virginica (0.00000000 0.02173913 0.97826087) *

plot(md, compress=TRUE, margin=0.5)
text(md, cex=1)

library(rpart.plot)
prp(md, type=2, extra=2)

# 분석 모형 평가 
ls(md)
#  [1] "call"                "control"             "cptable"
#  [4] "frame"               "functions"           "method"
#  [7] "numresp"             "ordered"             "parms"
# [10] "splits"              "terms"               "variable.importance"
# [13] "where"               "y"
md$cptable
#     CP nsplit rel error xerror       xstd
# 1 0.50      0      1.00   1.16 0.05127703
# 2 0.44      1      0.50   0.61 0.06016090
# 3 0.01      2      0.06   0.07 0.02583280


# 혼동 행렬
# install.packages('caret')
library(caret)
tree_pred = predict(
    md, newdata = iris, type = "class"
)
confusionMatrix(tree_pred, iris$Species)


# SVM
# install.packages('e1071')
library(e1071)

model = svm(Species ~., data=iris)
model

# Call:
# svm(formula = Species ~ ., data = iris)


# Parameters:
#    SVM-Type:  C-classification
#  SVM-Kernel:  radial 
#        cost:  1

# Number of Support Vectors:  51

pred = predict(model, iris)
library(caret)
confusionMatrix(pred, iris$Species)

# Confusion Matrix and Statistics

#             Reference
# Prediction   setosa versicolor virginica
#   setosa         50          0         0
#   versicolor      0         48         2
#   virginica       0          2        48

# Overall Statistics
                                          
#                Accuracy : 0.9733          
#                  95% CI : (0.9331, 0.9927)
#     No Information Rate : 0.3333          
#     P-Value [Acc > NIR] : < 2.2e-16       
                                          
#                   Kappa : 0.96            
                                          
#  Mcnemar's Test P-Value : NA              

# Statistics by Class:

#                      Class: setosa Class: versicolor
# Sensitivity                 1.0000            0.9600
# Specificity                 1.0000            0.9800
# Pos Pred Value              1.0000            0.9600
# Neg Pred Value              1.0000            0.9800
# Prevalence                  0.3333            0.3333
# Detection Rate              0.3333            0.3200
# Detection Prevalence        0.3333            0.3333
# Balanced Accuracy           1.0000            0.9700
#                      Class: virginica
# Sensitivity                    0.9600
# Specificity                    0.9800
# Pos Pred Value                 0.9600
# Neg Pred Value                 0.9800
# Prevalence                     0.3333
# Detection Rate                 0.3200
# Detection Prevalence           0.3333
# Balanced Accuracy              0.9700


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
# [1] 13
max(accuracy_k)
# [1] 0.8888889

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
# install.packages('nnet')
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
# # weights:  19
# initial  value 132.666396 
# iter  10 value 8.209251
# iter  20 value 1.364185
# iter  30 value 0.942394
# iter  40 value 0.730223
# iter  50 value 0.606575
# iter  60 value 0.519214
# iter  70 value 0.426922
# iter  80 value 0.405672
# iter  90 value 0.400552
# iter 100 value 0.394381
# iter 110 value 0.392941
# iter 120 value 0.392316
# iter 130 value 0.392108
# iter 140 value 0.392070
# iter 150 value 0.392048
# iter 160 value 0.392045
# iter 170 value 0.392043
# iter 180 value 0.392042
# iter 190 value 0.392041
# final  value 0.392041
# converged

summary(model.nnet)
# a 4-2-3 network with 19 weights
# options were - softmax modelling  decay=5e-04
#  b->h1 i1->h1 i2->h1 i3->h1 i4->h1
#  -8.61  -1.91  -0.78   7.81   7.06
#  b->h2 i1->h2 i2->h2 i3->h2 i4->h2
#   2.29   0.74  -1.51   2.55   2.39 
#  b->o1 h1->o1 h2->o1
#   5.83  -1.57  -8.56
#  b->o2 h1->o2 h2->o2
#  -2.30  -9.83   8.86
#  b->o3 h1->o3 h2->o3
#  -3.53  11.40  -0.30

# 나이브 베이즈 기법

library(e1071)
train_data = sample(1:150, size=100)

naive_model = naiveBayes(
    Species ~., data = iris,
    subset=train_data
)
naive_model

# Naive Bayes Classifier for Discrete Predictors

# Call:
# naiveBayes.default(x = X, y = Y, laplace = laplace)

# A-priori probabilities:
# Y
#     setosa versicolor  virginica
#       0.31       0.34       0.35 

# Conditional probabilities:
#             Sepal.Length
# Y                [,1]      [,2]
#   setosa     4.993548 0.3641753
#   versicolor 5.964706 0.5376054
#   virginica  6.594286 0.7012354

#             Sepal.Width
# Y                [,1]      [,2]
#   setosa     3.377419 0.3896235
#   versicolor 2.811765 0.3328160
#   virginica  2.985714 0.3431196

#             Petal.Length
# Y                [,1]      [,2]
#   setosa     1.470968 0.1616448
#   versicolor 4.247059 0.4301059
#   virginica  5.600000 0.5341293

#             Petal.Width
# Y                 [,1]       [,2]
#   setosa     0.2419355 0.09228288
#   versicolor 1.3411765 0.20466920
#   virginica  2.0285714 0.28239671

# 분석 모형 평가
library(caret)
pred= predict(naive_model, newdata=iris)
confusionMatrix(
    pred, iris$Species
)
# Confusion Matrix and Statistics

#             Reference
# Prediction   setosa versicolor virginica
#   setosa         50          0         0
#   versicolor      0         46         3
#   virginica       0          4        47

# Overall Statistics
                                         
#                Accuracy : 0.9533         
#                  95% CI : (0.9062, 0.981)
#     No Information Rate : 0.3333         
#     P-Value [Acc > NIR] : < 2.2e-16      
                                         
#                   Kappa : 0.93           
                                         
#  Mcnemar's Test P-Value : NA             

# Statistics by Class:

#                      Class: setosa Class: versicolor
# Sensitivity                 1.0000            0.9200
# Specificity                 1.0000            0.9700
# Pos Pred Value              1.0000            0.9388
# Neg Pred Value              1.0000            0.9604
# Prevalence                  0.3333            0.3333
# Detection Rate              0.3333            0.3067
# Detection Prevalence        0.3333            0.3267
# Balanced Accuracy           1.0000            0.9450
#                      Class: virginica
# Sensitivity                    0.9400
# Specificity                    0.9600
# Pos Pred Value                 0.9216
# Neg Pred Value                 0.9697
# Prevalence                     0.3333
# Detection Rate                 0.3133
# Detection Prevalence           0.3400
# Balanced Accuracy              0.9500
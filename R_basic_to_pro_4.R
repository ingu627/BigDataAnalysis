# 주성분 분석 예제
iris_pca = princomp(
    iris[,-5], cor = FALSE, scores=TRUE)
summary(iris_pca)

# 스크리 산점도 이용
plot(iris_pca, type='l', main='iris 스크리 산점도')

# 주성분 적재 값 분석
iris_pca$loadings
iris_pca$scores
biplot(iris_pca, scale=0, main='iris biplot')

# 다중 선형 회귀 분석 예제 
# install.packages("ISLR") 
library(ISLR)
str(Hitters)
head(Hitters)
summary(Hitters)

# 전처리 - 결측값 처리
hitters = na.omit(Hitters)
summary(hitters)

# 분석 모형 구축 - 유의하지 않은 변수 제거
full_model = lm(Salary ~., data = hitters)
summary(full_model)

# - 분석 모형 구축 - 자동화된 변수 선택
first_model = lm(
    Salary ~ AtBat + Hits + Walks + CWalks + Division + PutOuts,
    data = hitters
)
fit_model = step(first_model, direction='backward')

# 분석 모형 구축 - 다중공선성 확인 및 문제 해결
# install.packages('car')
library(car)
vif(fit_model)

second_model = lm(
    Salary ~ Hits + Walks + CWalks + Division + PutOuts,
    data= hitters)
vif(second_model)

# 분석 모형 평가
summary(second_model)



# auc 함수 사용하기
# install.packages('ModelMetrics')
library(ModelMetrics)

# 로지스틱 회귀 분석 예제

# Default 데이터 세트 사용하기 
# install.packages('ISLR')
library(ISLR)
str(Default)
head(Default)
summary(Default)

# 분석 모형 구축 - 유의성 검정

bankruptcy = Default

set.seed(202012)
train_idx = sample(
    1:nrow(bankruptcy),
    size=0.8*nrow(bankruptcy),
    replace=FALSE
)
test_idx=(-train_idx)
bankruptcy_train = bankruptcy[train_idx, ]
bankruptcy_test = bankruptcy[test_idx, ]
full_model = glm(
    default ~ .,
    family = binomial,
    data = bankruptcy)

# 분석 모형 구축 - step 함수 이용
step_model = step(full_model, direction = 'both')

# 분석 모형 구축 - 변수의 유의성 검정
summary(step_model)

# 분석 모형 구축 - 다중공선성 확인
library(car)
vif(step_model)

pred = predict(
    step_model,
    newdata = bankruptcy_test[, -1], 
    type = 'response',
)
df_pred = as.data.frame(pred)

df_pred$default = ifelse(
    df_pred_pred >= 0.5, 
    df_pred$default = "Yes",
    df_pred$default = "No"
)
df_pred$default = as.factor(df_pred$default)

# 분석 모형 평가 - 혼동 행렬
library(caret)
confusionMatrix(
    data=df_pred$default,
    reference = bankruptcy_test[,1])

library(ModelMetrics)
auc(actual=bankruptcy_test[,1], predicted=df_pred$default)
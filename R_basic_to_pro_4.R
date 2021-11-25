# 주성분 분석 예제
iris_pca = princomp(iris[,-5])
summary(iris_pca)
# Importance of components:
#                           Comp.1     Comp.2     Comp.3      Comp.4
# Standard deviation     2.0494032 0.49097143 0.27872586 0.153870700
# Proportion of Variance 0.9246187 0.05306648 0.01710261 0.005212184
# Cumulative Proportion  0.9246187 0.97768521 0.99478782 1.000000000

# => 제 1성분만을 이용하여 전체 데이터의 92.5%를 설명할 수 있다.

# 스크리 산점도 이용
plot(iris_pca, type='l', main='iris 스크리 산점도')

# 주성분 적재 값 분석
iris_pca$loadings
# Loadings:
#              Comp.1 Comp.2 Comp.3 Comp.4
# Sepal.Length  0.361  0.657  0.582  0.315
# Sepal.Width          0.730 -0.598 -0.320
# Petal.Length  0.857 -0.173        -0.480
# Petal.Width   0.358        -0.546  0.754

#                Comp.1 Comp.2 Comp.3 Comp.4
# SS loadings      1.00   1.00   1.00   1.00
# Proportion Var   0.25   0.25   0.25   0.25
# Cumulative Var   0.25   0.50   0.75   1.00

iris_pca$scores
#            Comp.1       Comp.2       Comp.3        Comp.4
#   [1,] -2.684125626  0.319397247  0.027914828  0.0022624371
#   [2,] -2.714141687 -0.177001225  0.210464272  0.0990265503
#   [3,] -2.888990569 -0.144949426 -0.017900256  0.0199683897
#   [4,] -2.745342856 -0.318298979 -0.031559374 -0.0755758166
#   ...
#   [147,]  1.527166615 -0.375316983  0.121898172  0.2543674420
# [148,]  1.764345717  0.078858855 -0.130481631  0.1370012739
# [149,]  1.900941614  0.116627959 -0.723251563  0.0445953047
# [150,]  1.390188862 -0.282660938 -0.362909648 -0.1550386282

biplot(iris_pca, scale=0, main='iris biplot')

# 단순 
library(ISLR)
data(Hitters)
summary(lm(Salary~PutOuts, data=Hitters))
# Call:
# lm(formula = Salary ~ PutOuts, data = Hitters)

# Residuals:
#     Min      1Q  Median      3Q     Max
# -893.66 -314.08  -71.43  204.19 1857.55

# Coefficients:
#              Estimate Std. Error t value Pr(>|t|)    
# (Intercept) 395.15532   38.36164   10.30  < 2e-16 ***
# PutOuts       0.48423    0.09514    5.09 6.87e-07 ***
# ---
# Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

# Residual standard error: 431.1 on 261 degrees of freedom
#   ()
# Multiple R-squared:  0.09029,   Adjusted R-squared:  0.0868
# F-statistic:  25.9 on 1 and 261 DF,  p-value: 6.871e-07


# 다중 선형 회귀 분석 예제 
# install.packages("ISLR") 
library(ISLR)
# 데이터 탐색 
str(Hitters)
# 'data.frame':   322 obs. of  20 variables:
#  $ AtBat    : int  293 315 479 496 321 594 185 298 323 401 ...
#  $ Hits     : int  66 81 130 141 87 169 37 73 81 92 ...
#  $ HmRun    : int  1 7 18 20 10 4 1 0 6 17 ...
#  $ Runs     : int  30 24 66 65 39 74 23 24 26 49 ...
#  $ RBI      : int  29 38 72 78 42 51 8 24 32 66 ...
#  $ Walks    : int  14 39 76 37 30 35 21 7 8 65 ...
#  $ Years    : int  1 14 3 11 2 11 2 3 2 13 ...
#  $ CAtBat   : int  293 3449 1624 5628 396 4408 214 509 341 5206 ...
#  $ CHits    : int  66 835 457 1575 101 1133 42 108 86 1332 ...
#  $ CHmRun   : int  1 69 63 225 12 19 1 0 6 253 ...
#  $ CRuns    : int  30 321 224 828 48 501 30 41 32 784 ...
#  $ CRBI     : int  29 414 266 838 46 336 9 37 34 890 ...
#  $ CWalks   : int  14 375 263 354 33 194 24 12 8 866 ...
#  $ League   : Factor w/ 2 levels "A","N": 1 2 1 2 2 1 2 1 2 1 ...
#  $ Division : Factor w/ 2 levels "E","W": 1 2 2 1 1 2 1 2 2 1 ...
#  $ PutOuts  : int  446 632 880 200 805 282 76 121 143 0 ...
#  $ Assists  : int  33 43 82 11 40 421 127 283 290 0 ...
#  $ Errors   : int  20 10 14 3 4 25 7 9 19 0 ...
#  $ Salary   : num  NA 475 480 500 91.5 750 70 100 75 1100 ...
#  $ NewLeague: Factor w/ 2 levels "A","N": 1 2 1 2 2 1 1 1 2 1 ...
head(Hitters)
#                   AtBat Hits HmRun Runs RBI Walks Years CAtBat CHits CHmRun
# -Andy Allanson      293   66     1   30  29    14     1    293    66      1
# -Alan Ashby         315   81     7   24  38    39    14   3449   835     69
# -Alvin Davis        479  130    18   66  72    76     3   1624   457     63
# -Andre Dawson       496  141    20   65  78    37    11   5628  1575    225
# -Andres Galarraga   321   87    10   39  42    30     2    396   101     12
# -Alfredo Griffin    594  169     4   74  51    35    11   4408  1133     19
#                   CRuns CRBI CWalks League Division PutOuts Assists Errors
# -Andy Allanson       30   29     14      A        E     446      33     20
# -Alan Ashby         321  414    375      N        W     632      43     10
# -Alvin Davis        224  266    263      A        W     880      82     14
# -Andre Dawson       828  838    354      N        E     200      11      3
# -Andres Galarraga    48   46     33      N        E     805      40      4
# -Alfredo Griffin    501  336    194      A        W     282     421     25
#                   Salary NewLeague
# -Andy Allanson        NA         A
# -Alan Ashby        475.0         N
# -Alvin Davis       480.0         A
# -Andre Dawson      500.0         N
# -Andres Galarraga   91.5         N
# -Alfredo Griffin   750.0         A
summary(Hitters)
#      AtBat            Hits         HmRun            Runs       
#  Min.   : 16.0   Min.   :  1   Min.   : 0.00   Min.   :  0.00  
#  1st Qu.:255.2   1st Qu.: 64   1st Qu.: 4.00   1st Qu.: 30.25
#  Median :379.5   Median : 96   Median : 8.00   Median : 48.00
#  Mean   :380.9   Mean   :101   Mean   :10.77   Mean   : 50.91
#  3rd Qu.:512.0   3rd Qu.:137   3rd Qu.:16.00   3rd Qu.: 69.00  
#  Max.   :687.0   Max.   :238   Max.   :40.00   Max.   :130.00

#       RBI             Walks            Years            CAtBat
#  Min.   :  0.00   Min.   :  0.00   Min.   : 1.000   Min.   :   19.0  
#  1st Qu.: 28.00   1st Qu.: 22.00   1st Qu.: 4.000   1st Qu.:  816.8
#  Median : 44.00   Median : 35.00   Median : 6.000   Median : 1928.0
#  Mean   : 48.03   Mean   : 38.74   Mean   : 7.444   Mean   : 2648.7  
#  3rd Qu.: 64.75   3rd Qu.: 53.00   3rd Qu.:11.000   3rd Qu.: 3924.2
#  Max.   :121.00   Max.   :105.00   Max.   :24.000   Max.   :14053.0

#      CHits            CHmRun           CRuns             CRBI
#  Min.   :   4.0   Min.   :  0.00   Min.   :   1.0   Min.   :   0.00
#  1st Qu.: 209.0   1st Qu.: 14.00   1st Qu.: 100.2   1st Qu.:  88.75
#  Median : 508.0   Median : 37.50   Median : 247.0   Median : 220.50  
#  Mean   : 717.6   Mean   : 69.49   Mean   : 358.8   Mean   : 330.12
#  3rd Qu.:1059.2   3rd Qu.: 90.00   3rd Qu.: 526.2   3rd Qu.: 426.25
#  Max.   :4256.0   Max.   :548.00   Max.   :2165.0   Max.   :1659.00  

#      CWalks        League  Division    PutOuts          Assists
#  Min.   :   0.00   A:175   E:157    Min.   :   0.0   Min.   :  0.0  
#  1st Qu.:  67.25   N:147   W:165    1st Qu.: 109.2   1st Qu.:  7.0
#  Median : 170.50                    Median : 212.0   Median : 39.5
#  Mean   : 260.24                    Mean   : 288.9   Mean   :106.9  
#  3rd Qu.: 339.25                    3rd Qu.: 325.0   3rd Qu.:166.0
#  Max.   :1566.00                    Max.   :1378.0   Max.   :492.0  

#      Errors          Salary       NewLeague
#  Min.   : 0.00   Min.   :  67.5   A:176
#  1st Qu.: 3.00   1st Qu.: 190.0   N:146    
#  Median : 6.00   Median : 425.0
#  Mean   : 8.04   Mean   : 535.9
#  3rd Qu.:11.00   3rd Qu.: 750.0
#  Max.   :32.00   Max.   :2460.0
#                  NA's   :59


# 전처리 - 결측값 처리
hitters = na.omit(Hitters)
summary(hitters)
#      AtBat            Hits           HmRun            Runs       
#  Min.   : 19.0   Min.   :  1.0   Min.   : 0.00   Min.   :  0.00  
#  1st Qu.:282.5   1st Qu.: 71.5   1st Qu.: 5.00   1st Qu.: 33.50
#  Median :413.0   Median :103.0   Median : 9.00   Median : 52.00
#  Mean   :403.6   Mean   :107.8   Mean   :11.62   Mean   : 54.75
#  3rd Qu.:526.0   3rd Qu.:141.5   3rd Qu.:18.00   3rd Qu.: 73.00  
#  Max.   :687.0   Max.   :238.0   Max.   :40.00   Max.   :130.00
#       RBI             Walks            Years            CAtBat
#  Min.   :  0.00   Min.   :  0.00   Min.   : 1.000   Min.   :   19.0
#  1st Qu.: 30.00   1st Qu.: 23.00   1st Qu.: 4.000   1st Qu.:  842.5  
#  Median : 47.00   Median : 37.00   Median : 6.000   Median : 1931.0
#  Mean   : 51.49   Mean   : 41.11   Mean   : 7.312   Mean   : 2657.5
#  3rd Qu.: 71.00   3rd Qu.: 57.00   3rd Qu.:10.000   3rd Qu.: 3890.5
#  Max.   :121.00   Max.   :105.00   Max.   :24.000   Max.   :14053.0
#      CHits            CHmRun           CRuns             CRBI       
#  Min.   :   4.0   Min.   :  0.00   Min.   :   2.0   Min.   :   3.0
#  1st Qu.: 212.0   1st Qu.: 15.00   1st Qu.: 105.5   1st Qu.:  95.0
#  Median : 516.0   Median : 40.00   Median : 250.0   Median : 230.0
#  Mean   : 722.2   Mean   : 69.24   Mean   : 361.2   Mean   : 330.4  
#  3rd Qu.:1054.0   3rd Qu.: 92.50   3rd Qu.: 497.5   3rd Qu.: 424.5
#  Max.   :4256.0   Max.   :548.00   Max.   :2165.0   Max.   :1659.0
#      CWalks       League  Division    PutOuts          Assists     
#  Min.   :   1.0   A:139   E:129    Min.   :   0.0   Min.   :  0.0
#  1st Qu.:  71.0   N:124   W:134    1st Qu.: 113.5   1st Qu.:  8.0
#  Median : 174.0                    Median : 224.0   Median : 45.0  
#  Mean   : 260.3                    Mean   : 290.7   Mean   :118.8
#  3rd Qu.: 328.5                    3rd Qu.: 322.5   3rd Qu.:192.0
#  Max.   :1566.0                    Max.   :1377.0   Max.   :492.0  
#      Errors           Salary       NewLeague
#  Min.   : 0.000   Min.   :  67.5   A:141
#  1st Qu.: 3.000   1st Qu.: 190.0   N:122
#  Median : 7.000   Median : 425.0
#  Mean   : 8.593   Mean   : 535.9            
#  3rd Qu.:13.000   3rd Qu.: 750.0
#  Max.   :32.000   Max.   :2460.0


# 분석 모형 구축 - 유의하지 않은 변수 제거
full_model = lm(Salary ~., data = hitters)
summary(full_model)

# Call:
# lm(formula = Salary ~ ., data = hitters)

# Residuals:
#     Min      1Q  Median      3Q     Max
# -907.62 -178.35  -31.11  139.09 1877.04

# Coefficients:
#               Estimate Std. Error t value Pr(>|t|)
# (Intercept)  163.10359   90.77854   1.797 0.073622 .
# AtBat         -1.97987    0.63398  -3.123 0.002008 ** 
# Hits           7.50077    2.37753   3.155 0.001808 **
# HmRun          4.33088    6.20145   0.698 0.485616
# Runs          -2.37621    2.98076  -0.797 0.426122
# RBI           -1.04496    2.60088  -0.402 0.688204
# Walks          6.23129    1.82850   3.408 0.000766 ***
# Years         -3.48905   12.41219  -0.281 0.778874
# CAtBat        -0.17134    0.13524  -1.267 0.206380
# CHits          0.13399    0.67455   0.199 0.842713
# CHmRun        -0.17286    1.61724  -0.107 0.914967    
# CRuns          1.45430    0.75046   1.938 0.053795 .
# CRBI           0.80771    0.69262   1.166 0.244691
# CWalks        -0.81157    0.32808  -2.474 0.014057 *
# LeagueN       62.59942   79.26140   0.790 0.430424    
# DivisionW   -116.84925   40.36695  -2.895 0.004141 **
# PutOuts        0.28189    0.07744   3.640 0.000333 ***
# Assists        0.37107    0.22120   1.678 0.094723 .
# Errors        -3.36076    4.39163  -0.765 0.444857
# NewLeagueN   -24.76233   79.00263  -0.313 0.754218    
# ---
# Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

# Residual standard error: 315.6 on 243 degrees of freedom
# Multiple R-squared:  0.5461,    Adjusted R-squared:  0.5106 
# F-statistic: 15.39 on 19 and 243 DF,  p-value: < 2.2e-16


# - 분석 모형 구축 - 자동화된 변수 선택
first_model = lm(
    Salary ~ AtBat + Hits + Walks + CWalks + Division + PutOuts,
    data = hitters
)
fit_model = step(first_model, direction='backward')
# Start:  AIC=3069.34
# Salary ~ AtBat + Hits + Walks + CWalks + Division + PutOuts

#            Df Sum of Sq      RSS    AIC
# - Walks     1    140021 29332351 3068.6
# <none>                  29192331 3069.3
# - Division  1    818761 30011092 3074.6
# - AtBat     1   1049839 30242170 3076.6
# - PutOuts   1   1537120 30729451 3080.8
# - Hits      1   2447512 31639842 3088.5
# - CWalks    1   7192906 36385237 3125.3

# Step:  AIC=3068.6
# Salary ~ AtBat + Hits + CWalks + Division + PutOuts

#            Df Sum of Sq      RSS    AIC
# <none>                  29332351 3068.6
# - Division  1    847051 30179403 3074.1
# - AtBat     1    920031 30252382 3074.7
# - PutOuts   1   1679078 31011429 3081.2
# - Hits      1   2374559 31706911 3087.1
# - CWalks    1  10140003 39472354 3144.7


# 분석 모형 구축 - 다중공선성 확인 및 문제 해결
# install.packages('car')
library(car)
vif(fit_model)
# 다음의 패키지를 부착합니다: 'car'

# The following object is masked from 'package:dplyr':

#     recode

# > vif(fit_model)
#     AtBat      Hits    CWalks  Division   PutOuts 
# 14.390545 14.310431  1.020849  1.017443  1.106465

second_model = lm(
    Salary ~ Hits + CWalks + Division + PutOuts,
    data= hitters)
vif(second_model)
#     Hits   CWalks Division  PutOuts
# 1.118533 1.017554 1.008653 1.099232

# 분석 모형 평가
summary(second_model)
# Call:
# lm(formula = Salary ~ Hits + CWalks + Division + PutOuts, data = hitters)

# Residuals:
#     Min      1Q  Median      3Q     Max
# -1085.2  -182.2   -40.2   131.1  2120.2

# Coefficients:
#               Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  -21.11806   62.96224  -0.335 0.737590
# Hits           3.21119    0.49582   6.477 4.72e-10 ***
# CWalks         0.73987    0.08082   9.155  < 2e-16 ***
# DivisionW   -125.60153   42.42008  -2.961 0.003353 ** 
# PutOuts        0.28281    0.07923   3.569 0.000427 ***
# ---
# Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

# Residual standard error: 342.4 on 258 degrees of freedom
# Multiple R-squared:  0.4326,    Adjusted R-squared:  0.4238 
# F-statistic: 49.18 on 4 and 258 DF,  p-value: < 2.2e-16


# auc 함수 사용하기
# install.packages('ModelMetrics')
library(ModelMetrics)

# 로지스틱 회귀 분석 예제

# Default 데이터 세트 사용하기 
# install.packages('ISLR')
library(ISLR)
str(Default)

# 'data.frame':   10000 obs. of  4 variables:
#  $ default: Factor w/ 2 levels "No","Yes": 1 1 1 1 1 1 1 1 1 1 ...
#  $ student: Factor w/ 2 levels "No","Yes": 1 2 1 1 1 2 1 2 1 1 ...
#  $ balance: num  730 817 1074 529 786 ...
#  $ income : num  44362 12106 31767 35704 38463 ...

head(Default)

#   default student   balance    income
# 1      No      No  729.5265 44361.625
# 2      No     Yes  817.1804 12106.135
# 3      No      No 1073.5492 31767.139
# 4      No      No  529.2506 35704.494
# 5      No      No  785.6559 38463.496
# 6      No     Yes  919.5885  7491.559

summary(Default)

#  default    student       balance           income     
#  No :9667   No :7056   Min.   :   0.0   Min.   :  772
#  Yes: 333   Yes:2944   1st Qu.: 481.7   1st Qu.:21340
#                        Median : 823.6   Median :34553
#                        Mean   : 835.4   Mean   :33517  
#                        3rd Qu.:1166.3   3rd Qu.:43808
#                        Max.   :2654.3   Max.   :73554

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

# Start:  AIC=1579.54
# default ~ student + balance + income

#           Df Deviance    AIC
# - income   1   1571.7 1577.7
# <none>         1571.5 1579.5
# - student  1   1579.0 1585.0
# - balance  1   2907.5 2913.5

# Step:  AIC=1577.68
# default ~ student + balance

#           Df Deviance    AIC
# <none>         1571.7 1577.7
# + income   1   1571.5 1579.5
# - student  1   1596.5 1600.5
# - balance  1   2908.7 2912.7


# 분석 모형 구축 - 변수의 유의성 검정
summary(step_model)

# Call:
# glm(formula = default ~ student + balance, family = binomial, 
#     data = bankruptcy)

# Deviance Residuals:
#     Min       1Q   Median       3Q      Max
# -2.4578  -0.1422  -0.0559  -0.0203   3.7435  

# Coefficients:
#               Estimate Std. Error z value Pr(>|z|)
# (Intercept) -1.075e+01  3.692e-01 -29.116  < 2e-16 ***
# studentYes  -7.149e-01  1.475e-01  -4.846 1.26e-06 ***
# balance      5.738e-03  2.318e-04  24.750  < 2e-16 ***
# ---
# Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

# (Dispersion parameter for binomial family taken to be 1)

#     Null deviance: 2920.6  on 9999  degrees of freedom
# Residual deviance: 1571.7  on 9997  degrees of freedom
# AIC: 1577.7

# Number of Fisher Scoring iterations: 8


# 분석 모형 구축 - 다중공선성 확인
library(car)
vif(step_model)
#  student  balance
# 1.076697 1.076697

# 평가용 데이터를 이용한 분류
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
    df_pred$default,
    bankruptcy_test[,1])


library(ModelMetrics)
auc(actual=bankruptcy_test[,1], predicted=df_pred$default)
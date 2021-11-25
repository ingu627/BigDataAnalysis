airquality %>% 
head(5)
#   Ozone Solar.R Wind Temp Month Day
# 1    41     190  7.4   67     5   1
# 2    36     118  8.0   72     5   2
# 3    12     149 12.6   74     5   3
# 4    18     313 11.5   62     5   4
# 5    NA      NA 14.3   56     5   5

library(dplyr)
data(airquality)
ds_NA = airquality %>% 
head(5) %>% is.na()
ds_NA
#   Ozone Solar.R  Wind  Temp Month   Day
# 1 FALSE   FALSE FALSE FALSE FALSE FALSE
# 2 FALSE   FALSE FALSE FALSE FALSE FALSE
# 3 FALSE   FALSE FALSE FALSE FALSE FALSE
# 4 FALSE   FALSE FALSE FALSE FALSE FALSE
# 5  TRUE    TRUE FALSE FALSE FALSE FALSE

# 결측값 인식 함수 예제 (위와 같음)
ds_na = is.na(head(airquality, 5))
ds_na

# complete.cases(x)
complete.cases(ds_NA)
# [1] TRUE TRUE TRUE TRUE FALSE
sum(!complete.cases(ds_NA))

# colSums()
library(mlbench)
data(PimaIndiansDiabetes2)
pima2 = PimaIndiansDiabetes2
colSums(is.na(pima2))
# pregnant  glucose pressure  triceps  insulin     mass pedigree      age
#        0        5       35      227      374       11        0        0
# diabetes
#        0


# 완전 분석법
library(mlbench)
data(PimaIndiansDiabetes2)
pima2 = PimaIndiansDiabetes2
pima3 = pima2 %>% filter(!is.na(glucose) & !is.na(mass))
colSums(is.na(pima3))
# pregnant  glucose pressure  triceps  insulin     mass pedigree      age 
#        0        0       28      218      360        0        0        0
# diabetes
#        0

dim(pima3)
# 752개의 데이터 수 x 각 9개의 특성
# [1] 752   9

pima4=na.omit(pima3)
colSums(is.na(pima4))
# pregnant  glucose pressure  triceps  insulin     mass pedigree      age
#        0        0        0        0        0        0        0        0
# diabetes
#        0

dim(pima4)
# [1] 392   9


# 평균대치법
library(mlbench)
data(PimaIndiansDiabetes2)
pima2 = PimaIndiansDiabetes2
head(pima2$pressure)
# [1] 72 66 64 66 40 74
pima2$pressure = ifelse(
    is.na(pima2$pressure),
    mean(pima2$pressure, na.rm = TRUE),
    pima2$pressure
)
table(is.na(pima2$pressure))

# FALSE
#   768


# 데이터의 범위 변환
data=c(1,3,5,7,9)
data_minmax = scale(data)
data_minmax
#            [,1]
# [1,] -1.2649111
# [2,] -0.6324555
# [3,]  0.0000000
# [4,]  0.6324555
# [5,]  1.2649111
# attr(,"scaled:center")
# [1] 5
# attr(,"scaled:scale")
# [1] 3.162278

data=c(1,3,5,7,9)
data_minmax = scale(data, 
    center=1, scale=8)
data_minmax
#      [,1]
# [1,] 0.00
# [2,] 0.25
# [3,] 0.50
# [4,] 0.75
# [5,] 1.00
# attr(,"scaled:center")
# [1] 1
# attr(,"scaled:scale")
# [1] 8

# sample(x, size, replace, prob)
sample(x=1:10, size=5, replace=FALSE)
# [1] 5 2 4 1 7

# createDataPartition
library(caret)
ds = createDataPartition(
    iris$Species, times=1, p=0.7
)
ds
# $Resample1
#   [1]   1   2   3   4   5   8   9  11  12  13  16  17  18  19  20  21  26  27
#  [19]  28  29  30  31  33  34  35  36  39  40  43  44  45  46  47  48  49  51
#  [37]  52  53  54  56  58  60  61  62  64  66  67  68  70  72  73  74  75  76
#  [55]  78  81  82  83  84  86  87  88  90  91  92  93  95  96  97 100 101 102
#  [73] 103 105 106 107 108 109 110 111 113 115 117 119 121 122 123 124 125 126
#  [91] 130 131 132 133 135 136 137 138 140 141 144 145 146 147 148
idx = as.vector(ds$Resample1)
ds_train = iris[idx,]
ds_test = iris[-idx,]

# createFolds
library(caret)
ds_k_fold = createFolds(
    iris$Species,
    k=3
)
ds_k_fold
$Fold1
#  [1]   1   5   6   8  14  16  18  19  20  24  29  36  37  38  47  49  50  54  56
# [20]  59  63  64  67  70  71  73  74  76  79  88  91  95  97 100 102 103 105 107
# [39] 117 123 124 127 131 135 136 140 144 145 146 149 150

# $Fold2
#  [1]   4   7   9  10  13  15  22  26  27  31  35  42  43  44  45  46  48  52  53
# [20]  57  60  62  65  68  69  72  78  82  83  86  87  89  98  99 101 106 109 112
# [39] 114 115 118 122 125 128 132 134 138 141 143 148

# $Fold3
#  [1]   2   3  11  12  17  21  23  25  28  30  32  33  34  39  40  41  51  55  58
# [20]  61  66  75  77  80  81  84  85  90  92  93  94  96 104 108 110 111 113 116
# [39] 119 120 121 126 129 130 133 137 139 142 147

# 빈도수 시각화 예시

cnt = table(mtcars$cyl)
barplot(
    cnt,
    xlab = "기통",
    ylab = "수량",
    main = "기통별 수량")

pie(
    cnt, main = "기통별 비율"
)

summary(mtcars$wt)
#    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#   1.513   2.581   3.325   3.217   3.610   5.424
head(mtcars$wt)
# [1] 2.620 2.875 2.320 3.215 3.440 3.460
str(mtcars)
# 'data.frame':   32 obs. of  11 variables:
#  $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
#  $ cyl : num  6 6 4 6 8 6 8 4 4 6 ...
#  $ disp: num  160 160 108 258 360 ...
#  $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
#  $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
#  $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
#  $ qsec: num  16.5 17 18.6 19.4 17 ...
#  $ vs  : num  0 0 1 1 0 1 0 1 1 1 ...
#  $ am  : num  1 1 1 0 0 0 0 0 0 0 ...
#  $ gear: num  4 4 4 3 3 3 3 4 4 4 ...
#  $ carb: num  4 4 1 1 2 1 4 2 2 4 ...

# 변수 선택 기법 예시
data(mtcars)
m1 = lm(hp~., data=mtcars)
m2 = step(m1, direction="both")
# Start:  AIC=216.97
# hp ~ mpg + cyl + disp + drat + wt + qsec + vs + am + gear + carb

#        Df Sum of Sq   RSS    AIC
# - qsec  1      39.6 14204 215.06
# - drat  1      55.6 14220 215.09
# - am    1     140.8 14306 215.28
# - gear  1     164.4 14329 215.34
# - cyl   1     446.2 14611 215.96
# - mpg   1     656.9 14822 216.42
# <none>              14165 216.97
# - vs    1    1140.5 15305 217.45
# - wt    1    1389.7 15554 217.96
# - carb  1    4799.2 18964 224.31
# - disp  1    5839.6 20004 226.01

# Step:  AIC=215.06
# hp ~ mpg + cyl + disp + drat + wt + vs + am + gear + carb

#        Df Sum of Sq   RSS    AIC
# - drat  1      50.6 14255 213.17
# - gear  1     184.3 14389 213.47
# - am    1     216.7 14421 213.54
# - cyl   1     565.0 14769 214.31
# - mpg   1     793.5 14998 214.80
# <none>              14204 215.06
# - vs    1    1133.8 15338 215.52
# + qsec  1      39.6 14165 216.97
# - wt    1    2577.3 16782 218.39
# - carb  1    5653.2 19858 223.78
# - disp  1    7460.7 21665 226.57

# Step:  AIC=213.17
# hp ~ mpg + cyl + disp + wt + vs + am + gear + carb

#        Df Sum of Sq   RSS    AIC
# - gear  1     172.8 14428 211.56
# - am    1     191.5 14446 211.60
# - cyl   1     722.9 14978 212.75
# - mpg   1     848.4 15103 213.02
# <none>              14255 213.17
# - vs    1    1139.2 15394 213.63
# + drat  1      50.6 14204 215.06
# + qsec  1      34.6 14220 215.09
# - wt    1    2528.3 16783 216.40
# - carb  1    5726.5 19981 221.98
# - disp  1    7415.0 21670 224.57

# Step:  AIC=211.56
# hp ~ mpg + cyl + disp + wt + vs + am + carb

#        Df Sum of Sq   RSS    AIC
# - am    1     396.7 14824 210.43
# - cyl   1     564.9 14993 210.79
# - mpg   1     808.0 15236 211.30
# <none>              14428 211.56
# - vs    1    1174.3 15602 212.06
# + gear  1     172.8 14255 213.17
# + qsec  1      53.3 14374 213.44
# + drat  1      39.0 14389 213.47
# - wt    1    3249.9 17678 216.06
# - disp  1    8286.4 22714 224.08
# - carb  1   12801.2 27229 229.88

# Step:  AIC=210.43
# hp ~ mpg + cyl + disp + wt + vs + carb

#        Df Sum of Sq   RSS    AIC
# - cyl   1     303.2 15128 209.07
# - mpg   1     599.2 15424 209.69
# - vs    1     843.7 15668 210.20
# <none>              14824 210.43
# + am    1     396.7 14428 211.56
# + gear  1     378.0 14446 211.60
# + qsec  1     209.5 14615 211.97
# + drat  1       6.7 14818 212.41
# - wt    1    5557.0 20381 218.61
# - disp  1    9845.0 24669 224.72
# - carb  1   23251.5 38076 238.61

# Step:  AIC=209.07
# hp ~ mpg + disp + wt + vs + carb

#        Df Sum of Sq   RSS    AIC
# - vs    1     580.3 15708 208.28
# <none>              15128 209.07
# - mpg   1    1048.7 16176 209.22
# + cyl   1     303.2 14824 210.43
# + qsec  1     256.7 14871 210.53
# + am    1     134.9 14993 210.79
# + drat  1      87.6 15040 210.89
# + gear  1      79.4 15048 210.91
# - wt    1    6327.7 21455 218.26
# - disp  1   17271.9 32400 231.44
# - carb  1   24482.5 39610 237.88

# Step:  AIC=208.28
# hp ~ mpg + disp + wt + carb

#        Df Sum of Sq   RSS    AIC
# - mpg   1     856.1 16564 207.98
# <none>              15708 208.28
# + vs    1     580.3 15128 209.07
# + gear  1     131.3 15577 210.01
# + drat  1      48.7 15659 210.18
# + cyl   1      39.8 15668 210.20
# + am    1      38.4 15669 210.20
# + qsec  1       2.3 15706 210.27
# - wt    1    5792.6 21501 216.32
# - disp  1   20461.9 36170 232.97
# - carb  1   26384.0 42092 237.82

# Step:  AIC=207.98
# hp ~ disp + wt + carb

#        Df Sum of Sq   RSS    AIC
# <none>              16564 207.98
# + mpg   1       856 15708 208.28
# + vs    1       388 16176 209.22
# + cyl   1       276 16288 209.44
# + drat  1       239 16325 209.51
# + qsec  1        67 16497 209.85
# + am    1        12 16552 209.95
# + gear  1         4 16560 209.97
# - wt    1      4961 21525 214.36
# - disp  1     26844 43408 236.81
# - carb  1     36686 53250 243.34

formula(m2)
# hp ~ disp + wt + carb

중요도 <- c('상', '중', '하')
df = data.frame(중요도)
df
#   중요도
# 1     상
# 2     중
# 3     하
transform(
    df,
    변수1 = ifelse(중요도=='중', 1, 0),
    변수2 = ifelse(중요도=='하', 1,0))
#   중요도 변수1 변수2
# 1     상     0     0
# 2     중     1     0
# 3     하     0     1
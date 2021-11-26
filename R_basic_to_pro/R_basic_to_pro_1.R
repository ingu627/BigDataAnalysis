# 변수 생성
# = : ~를 ~에 저장하여라 (할당)
a=2
print(a)
# [1] 2

# == 또는 !=
# == : 맞는지 판단하여라
# != : 틀린지 판단하여라
a = 2
a ==2
# [1] TRUE
a != 2
# [1] FALSE

# 벡터(Vector)
# c() = combind의 약자
# 벡터의 생성
# c(값1, 값2…)
x1 = c(1,2,3,4)
x1
# [1] 1 2 3 4

# seq()
x1 = c(1:10)
x1
# [1]  1  2  3  4  5  6  7  8  9 10

x2 = seq(1,10,2)
x2
# [1] 1 3 5 7 9

# rep()
# rep = repeat의 약자
# rep(반복할 값, 반복할 횟수)

y = rep(1,10)
y
# [1] 1 1 1 1 1 1 1 1 1 1
y2 = rep(c(1,10),2)
y2
# [1]  1 10  1 10
y3 = rep(c(1,100), c(2,2))
y3
# [1]   1   1 100 100

# 리스트(List)
# 리스트는 (키, 값) 형태로 데이터를 저장하는 R의 모든 객체를 담을 수 있는 데이터 구조
# list(key=value, key=value...)
a=list(
  x=c('poeun', 'pouen1'),
  y=c(1,2))
a$x  
# [1] "poeun"  "pouen1"
a$y
# [1] 1 2

# matrix(): matrix(data = 데이터 , nrow = 행의 수, ncol = 열의 수, byrow = 행/열 기준, dimnames = 행과 열의 이름 리스트)
# byrow는 TRUE이면 행을 기준으로 입력, FALSE이면 열을 기준으로 입력한다. (default = FALSE)
x1=c(1:8)
x1
# [1] 1 2 3 4 5 6 7 8

MATRIX_R = matrix(
  data =x1,
  nrow =4
)
MATRIX_R
#      [,1] [,2]
# [1,]    1    5
# [2,]    2    6
# [3,]    3    7
# [4,]    4    8

MATRIX_C = matrix(
  data = x1,
  ncol = 4
)
MATRIX_C
#      [,1] [,2] [,3] [,4]
# [1,]    1    3    5    7
# [2,]    2    4    6    8

# dataframe의 생성
# data.frame(변수명1=벡터1)
# head() : 데이터의 상단 부분을 지정해주는 행만큼 출력해주는 함수
DATA_SET = data.frame(
  x1 = c(1:10),
  x1_2 = seq(1,10,1),
  x2 = seq(1,10,2),
  y = rep(1,10)
)
head(DATA_SET, 3)
#   x1 x1_2 x2 y
# 1  1    1  1 1
# 2  2    2  3 1
# 3  3    3  5 1



# length()
# 1차원 벡터일 경우
# 벡터에 속한 원소의 갯수
length(x1)

length(c(1:10))
# [1] 10

# dim()
# 2차원 행렬, 데이터프레임인 경우
# 첫번째 : 행의 개수, 두번째 : 열의 개수
dim(MATRIX_R)
# [1] 4 2

dim(DATA_SET)
# [1] 10  4

# c() : 들어오는 값들을 묶어 하나의 벡터로 만드는 기능을 실행
# ()안에는 분석하고자 하는 원소값들이 입력되어야 한다.
a=c(1,2,3,4,5)
a
# [1] 1 2 3 4 5

# {}는 for, if문 등에서 조건식을 삽입할 때 쓰인다.

for(i in c(1:5)){
  print(i)
}
# [1] 1
# [1] 2
# [1] 3
# [1] 4
# [1] 5

B = c() # 빈 공간의 벡터 생성

for(k in seq(1,10,2)){
  B=c(B,k)
}
B
# [1] 1 3 5 7 9

# []는 index를 입력해야 될 때 쓰인다.

# 1, 2번째 값
a[1:2]
# [1] 1 2
# 3번째 값 빼고
a[-3]
# [1] 1 2 4 5
a[c(1,2,4,5)]
# [1] 1 2 4 5

DATA_SET
#    x1 x1_2 x2 y
# 1   1    1  1 1
# 2   2    2  3 1
# 3   3    3  5 1
# 4   4    4  7 1
# 5   5    5  9 1
# 6   6    6  1 1
# 7   7    7  3 1
# 8   8    8  5 1
# 9   9    9  7 1
# 10 10   10  9 1

# 1행 전부
DATA_SET[1,]
#   x1 x1_2 x2 y
# 1  1    1  1 1

# 1열 전부
DATA_SET[,1]
#  [1]  1  2  3  4  5  6  7  8  9 10

# 1,2,3행 & 2열 빼고 나머지
DATA_SET[c(1,2,3),-2]
#   x1 x2 y
# 1  1  1 1
# 2  2  3 1
# 3  3  5 1


# as.Date(변수, format='날짜 형식')

DATE_O = '2021-11-05'
str(DATE_O)
# chr "2021-11-05"
DATE_C = as.Date(DATE_O, format = '%Y-%m-%d')
str(DATE_C)
# Date[1:1], format: "2021-11-05"

# as.POSIXct(날짜, format = '날짜형식')

DATE_02 = '2021-11-05 23:13:23'
DATE_P = as.POSIXct(DATE_02, format = '%Y-%m-%d %H:%M:%S')
DATE_P
# [1] "2021-11-05 23:13:23 KST"

# format(날짜변수, '형식)

format(DATE_P, '%A')
# [1] "금요일"
format(DATE_P, '%M')
# [1] "13"
format(DATE_P, '%Y')
# [1] "2021"

# as()

x=c(1,2,3,4,5,6,7,8,9,10)
x1 = as.integer(x) ; str(x1)
# int [1:10] 1 2 3 4 5 6 7 8 9 10
x2 = as.numeric(x) ; str(x2)
# num [1:10] 1 2 3 4 5 6 7 8 9 10
x3 = as.factor(x) ; str(x3)
# Factor w/ 10 levels "1","2","3","4",..: 1 2 3 4 5 6 7 8 9 10
x4 = as.character(x) ; str(x4)
# chr [1:10] "1" "2" "3" "4" "5" "6" "7" "8" "9" "10"
summary(x1)
#  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#  1.00    3.25    5.50    5.50    7.75   10.00

# is()

x=c(1:5)
y=c("str1", "str2")
is.integer(x)
# [1] TRUE
is.numeric(x)
# [1] TRUE
is.factor(y)
# [1] FALSE
is.character(y)
# [1] TRUE

# sample()
S1 =sample(1:45, 6, replace= FALSE)
S1
# [1] 39 11 35 20 37 27

# set.seed()
S2 = sample(1:45, 6, replace=FALSE)
S2
# [1]  8 31 15  9 42 45

# ifelse 문법
# ifelse(조건식, 명령어1, 명령어2) : 참이면 명령어1, 거짓이면 명령어2
A = c(1,2,3,4,5)
if(7 %in% A){
  print('TRUE')
} else{
  print('FALSE')
}
# [1] "FALSE"

# switch 문
# 조건에 따라 여러 개의 경로 중 하나를 선택하여 명령어를 실행하는 명령어
course = "C"
switch(course,
       "A" = "brunch",
       "B" = "lunch",
       "dinner")
# [1] "dinner"


# for 문
# 범위에 들어있는 각각의 값을 변수에 할당하고 블록 안의 문장을 수행
for (i in 1:4){
  print(i)
}
# [1] 1
# [1] 2
# [1] 3
# [1] 4

# while 문
# 조건문 참일 때 블록 안의 명령어들을 수행
i=1
while (i<=4){
  print(i)
  i=i+1
}
# [1] 1
# [1] 2
# [1] 3
# [1] 4

# repeat 문
# 반복문을 중간에 탈추하기 위해 사용하는 명령어
i=1
repeat {
  print(i)
  if (i>=2){
    break
  }
  i=i+1
}
# [1] 1
# [1] 2

# break 문 
for (i in 1:5){
  print(i)
  if (i>=3){
    break
  }
}
# [1] 1
# [1] 2
# [1] 3

# next 문
# 반복문에서 다음 반복으로 넘어갈 수 있도록 하는 명령어
# 파이썬의 continue와 같은 개념
for (i in 1:5){
  if (i == 3){
    next
  }
  print(i)
}
# [1] 1
# [1] 2
# [1] 4
# [1] 5

# function()
Plus_One = function(x){
  y=x+1
  return (y)
}
Plus_One(3)
# [1] 4

# install.packages('ggplot2')
# 'C:/Rlib'의 위치에 패키지(들)을 설치합니다.
# (왜냐하면 'lib'가 지정되지 않았기 때문입니다)
# --- 현재 세션에서 사용할 CRAN 미러를 선택해 주세요 ---
# URL 'https://cran.seoul.go.kr/bin/windows/contrib/4.1/ggplot2_3.3.5.zip'을 시도합니다
# Content type 'application/zip' length 4129789 bytes (3.9 MB)
# downloaded 3.9 MB

# package 'ggplot2' successfully unpacked and MD5 sums checked

# The downloaded binary packages are in
#         C:\Users\poeun\AppData\Local\Temp\RtmpCULWCS\downloaded_packages
library(ggplot2)


# geom_boxplot 예시
head(airquality)
#   Ozone Solar.R Wind Temp Month Day
# 1    41     190  7.4   67     5   1
# 2    36     118  8.0   72     5   2
# 3    12     149 12.6   74     5   3
# 4    18     313 11.5   62     5   4
# 5    NA      NA 14.3   56     5   5
# 6    28      NA 14.9   66     5   6


library(ggplot2)
ggplot(data=airquality, # 그래프에 필요한 객체인 airquality 대입
       aes(x=Month, # x축에 들어갈 칼럼명으로 Month 대입
           y=Temp, # y축에 들어갈 컬럼명으로 Temp 대입
           group=Month) # Month 기준으로 집계
       ) + geom_boxplot() #Boxplot으로 출력

# chapter1

a = 2 
print(a) 

a = 2
a == 2
a != 2

x1 = c(1,2,3,4)
x1

x1 = c(1:10)
x1
# seq = sequence 
# seq(시작숫자, 마지막 숫자, 증가범위)
x1_2 = seq(1,10,1)
x1_2
x2 = seq(1,10,2)
x2

# rep = repeat 
# rep() : rep(반복할 값, 반복할 횟수)
y = rep(1,10)
y
y2 = rep(c(1,10),2)
y2
y3 = rep(c(1,100), c(2,2))
y3

#matrix(data=데이터, nrow=행의 수, ncol=열의 수, byrow=행/열 기준)

x1= c(1:8)
x1

MATRIX_R =matrix(
  data = x1,
  nrow = 4
)

MATRIX_R

MATRIX_C = matrix(
  data = x1,
  ncol = 4
)
MATRIX_C

DATA_SET = data.frame(
  x1 = x1, # 변수명 = 벡터값
  x1_2 = x1_2,
  x2 = x2,
  y=y
)
DATA_SET

DATA_SET = data.frame(
  x1 = c(1:10),
  x1_2 = seq(1,10,1),
  x2 = seq(1,10,2),
  y = rep(1,10)
)
head(DATA_SET, 3)

# 1차원 벡터일 경우
# 벡터에 속한 원소의 갯수
length(x1)

length(c(1:10))

# 2차원 행렬
dim(MATRIX_R)

dim(DATA_SET)

# c() : 들어오는 값들을 묶어 하나의 벡터로 만드는 기능을 실행
# ()안에는 분석하고자 하는 원소값들이 입력되어야 한다.
a=c(1,2,3,4,5)
a

# {}는 for, if문 등에서 조건식을 삽입할 때 쓰인다.

for(i in c(1:5)){
  print(i)
}

B = c() # 빈 공간의 벡터 생성

for(k in seq(1,10,2)){
  B=c(B,k)
}
B

# []는 index를 입력해야 될 때 쓰인다.

# 1, 2번째 값
a[1:2]
# 3번째 값 빼고
a[-3]

a[c(1,2,4,5)]

# 2차원 data.frame()형태의 경우
DATA_SET

# 1행 전부
DATA_SET[1,]

# 1열 전부
DATA_SET[,1]

# 1,2,3행 & 2열 빼고 나머지
DATA_SET[c(1,2,3),-2]

# chr : 문자열 형태
# int : 숫자
# num : 숫자
# Factor : 명목형 변수
# Posixct : 시간 변수
# Tseries : 시계열 변수

Numeric_Vector = c(1:20)
Chr_Vector = c('A','B','C')
str(Numeric_Vector)
str(Chr_Vector)

# as.Date(변수, format='날짜 형식')

DATE_O = '2021-11-05'
str(DATE_O)
DATE_C = as.Date(DATE_O, format = '%Y-%m-%d')
str(DATE_C)

# as.POSIXct(날짜, format = '날짜형식')

DATE_02 = '2021-11-05 23:13:23'
DATE_P = as.POSIXct(DATE_02, format = '%Y-%m-%d %H:%M:%S')
DATE_P

# format(날짜변수, '형식)

format(DATE_P, '%A')
format(DATE_P, '%M')
format(DATE_P, '%Y')

# as() : 변수 x를 ~ 취급하겠다

x=c(1,2,3,4,5,6,7,8,9,10)
x1 = as.integer(x) ; str(x1)
x2 = as.numeric(x) ; str(x2)
x3 = as.factor(x) ; str(x3)
x4 = as.character(x) ; str(x4)

summary(x1)

# is : 논리문으로써 변수 x가 ~인지 판단하여라라는 의미 
# str = Strings()

x=c(1:5)
y=c("str1", "str2")
is.integer(x)
is.numeric(x)
is.factor(y)
is.character(y)

# sample(데이터 추출범위, 데이터 추 갯수, replace = )

S1 =sample(1:45, 6, replace= FALSE)
S1

# set.seed() : 결과값 고정

set.seed(1234)
S2 = sample(1:45, 6, replace=FALSE)
S2

# %in% ~에 속해 있는지 확인

A = c(1,2,3,4,5)

if(7 %in% A){
  print('TRUE')
} else{
  print('FALSE')
}

# function()을 통해 사용자함수 만들기 

Plus_One = function(x){
  y= x+1
  return (y)
}
Plus_One(3)

install.packages('ggplot2')
library(ggplot2)


# chapter2

HR = read.csv("./HR_comma_sep.csv")
#head() : 데이터 윗부분을 출력하는 명령어
head(HR, n=3)
str(HR) # 각 변수들이 어떤 strings를 가지는지 확인을 하는 것 
#요약된 데이터 살펴보기 
summary(HR)

summary(HR$left)

HR$Work_accident = as.factor(HR$Work_accident)
HR$left = as.factor(HR$left)
HR$promotion_last_5years = as.factor(HR$promotion_last_5years)

summary(HR$left)

# ifelse(조건, TRUE, FALSE)
HR$satisfaction_level_group_1 = ifelse(HR$satisfaction_level > 0.5,
       'High', 'Low')
HR$satisfaction_level_group_1 = as.factor(HR$satisfaction_level_group_1)

summary(HR$satisfaction_level_group_1)

HR$satisfaction_level_group_2 = ifelse(HR$satisfaction_level > 0.8,
       'High', ifelse(HR$satisfaction_level > 0.5,
                      'Mid', 'Low'))
HR$satisfaction_level_group_2 = as.factor(HR$satisfaction_level_group_2)

summary(HR$satisfaction_level_group_2)

#subset() : 조건에 맞는 데이터를 추출하는 명령어
#subset(데이터, 추출 조건)
HR_High = subset(HR, salary == 'high')
summary(HR_High$salary)

HR_High_IT =  subset(HR, (salary == 'high')& (sales == 'IT'))
print(xtabs(~ HR_High_IT$sales + HR_High_IT$salary))

HR_High_IT2 = subset(HR, salary == 'high' | sales == 'IT')
print(xtabs(~ HR_High_IT2$sales + HR_High_IT2$salary))

# install.packages('plyr')
library(plyr)

#ddply(데이터, 집계기준, summarise, 요약변수)
SS=ddply(HR, c('sales', 'salary'), summarise,
         M_SF = mean(satisfaction_level),
         COUNT = length(sales),
         M_WH = round(mean(average_montly_hours), 2))
SS

# ggplot2 
# 1. 축을 그린다 2. 그래프를 그린다 3. 범례, 제목, 글씨 등 기타 옵션을 수정한다.
# aes = aesthetic(미적) ; 그래프에 변수를 설정 (축 설정)
# ggplot2에 들어갈 변수들은 모두 aes()안에 들어간다.

# geom_bar() : 막대도표 
# geom_histogram() : 히스토그램
# geom_boxplot() : 박스플롯 
# geom_line() : 선 그래프 
# labs() : 범례 제목 수정 
# ggtitle() : 제목 수정 
# xlabs(), ylabs(), x축, y축 이름 수정

library(ggplot2)
# library(ggthemes)

HR$salary = factor(HR$salary, levels = 
                     c('low', 'medium', 'high'))

# 막대 도표 : 이산형 변수 하나를 집계 내는 그래프, 1차원
ggplot(HR)
ggplot(HR,aes(x=salary))
ggplot(HR, aes(x=salary)) +
  geom_bar(aes(fill = salary))

ggplot(HR, aes(x=salary)) +
  geom_bar(aes(fill=left)) # left 값에 따라 색 채우기

# 점,선처럼 면적이 없는 그래프는 col옵션을 통해 색을 바꿔주며,
# 면적이 있는 그래프들은 fill옵션을 통해 색을 변경한다.

# 히스토그램 : 연속형 변수 하나를 집계 내는 그래프, 1차원 
ggplot(HR, aes(x=satisfaction_level)) +
  geom_histogram()

ggplot(HR, aes(x=satisfaction_level)) +
  geom_histogram(binwidth =  0.01, col='red',
                 fill='royalblue')

# 밀도그래프 : 연속형 변수 하나를 집계 내는 그래프, 1차원
ggplot(HR, aes(x=satisfaction_level)) +
  geom_density()

ggplot(HR, aes(x=satisfaction_level)) +
  geom_density(col='red', fill='royalblue')
# col=테두리, fill=채우기 박스플롯 

# 박스플롯 : 이산형 변수에 따라 연속형 변수의 분포 차이를
# 표현해주는 2차원 그래프
ggplot(HR, aes(x=left, y=satisfaction_level)) +
  geom_boxplot(aes(fill = left)) +
  xlab('이직여부') + ylab('만족도') + ggtitle('Boxplot') +
  labs(fill = '이직 여부')

ggplot(HR, aes(x=left, y=satisfaction_level)) +
  geom_boxplot(aes(fill = left), alpha = I(0.4)) +
  geom_jitter(aes(col = left), alpha = I(0.4)) +
  xlab('이직여부') + ylab('만족도') + ggtitle('Boxplot') +
  labs(fill = '이직 여부')

ggplot(HR, aes(x=left, y=satisfaction_level)) +
  geom_boxplot(aes(fill = salary), alpha = I(0.4), outlier.colour = 'red') +
  xlab('이직여부') + ylab('만족도') + ggtitle('Boxplot') +
  labs(fill = '임금 수준')

# 산점도 : 두 연속형 변수의 상관관계를 표현해주는 2차원 그래프 
# 산점도는 모델링 전에 변수들 간의 관계를 파악하는데 있어, 가장 효과적이다.
ggplot(HR, aes(x=average_montly_hours, y=satisfaction_level)) +
  geom_point(aes(col = left)) +
  labs(col = '이직 여부') + xlab('평균 근무 시간') + ylab('만족도')

# summary = 변수에 대한 요약 값
summary(HR$salary)
summary(HR$satisfaction_level)

# quantile : 분위수
quantile(HR$satisfaction_level, 
         probs = c(0.1, 0.3, 0.6, 0.9))

sum(HR$satisfaction_level)
mean(HR$last_evaluation)
sd(HR$satisfaction_level)

# 행별로 합, 평균 구할 시에는 rowSums, rowMeans 활용 
colMeans(HR[1:5])
colSums(HR[1:5])

# 빈도 테이블 작성
# table = 각 빈도수 보여줌
TABLE = as.data.frame(table(HR$sales))

TABLE2 = as.data.frame(xtabs(~ HR$salary + HR$sales))


# chapter3

IMDB = read.csv('./imdb-movie-data.csv')

# 결측치 : 데이터에 값이 없는 것
is.na(IMDB$Metascore)[1:20]
sum(is.na(IMDB$Metascore))

colSums(is.na(IMDB))

# na.omit : 결측치가 하나라도 포함된 obs(헁)은 삭제
# 결측치 전부 삭제
IMDB2 =na.omit(IMDB)
colSums(is.na(IMDB2))

# 특정 변수에 결측치가 존재하는 행만 삭제하는 경우
IMDB3 = IMDB[complete.cases(IMDB[, 12]),]
colSums(is.na(IMDB3))

IMDB$Metascore2 =  IMDB$Metascore
IMDB$Metascore2[is.na(IMDB$Metascore2)] =58.99

# 결측치 
# 연속형 변수 : 평균으로 대체 
# 이산형 변수 : 최빈값으로 대체 
# => 결측치의 비율 / 데이터의 분포 / 다른 변수와의 관계가 있는지
mean(IMDB$Revenue..Millions.)

mean(IMDB$Revenue..Millions., na.rm = TRUE)

library(ggplot2)

ggplot(IMDB, aes(x=Revenue..Millions.)) +
  geom_histogram(fill='royalblue', alpha = 0.4) +
  ylab('') +
  xlab('Revenue_Millions') +
  theme_classic()

ggplot(IMDB, aes(x='', y=Revenue..Millions.)) +
  geom_boxplot(fill='red', alha = 0.4, outlier.color = 'red') +
  xlab('') +
  ylab('Revenue_Millions') +
  theme_classic()

summary(IMDB$Revenue..Millions.)
# 평균은 극단값(Outer, 이상치)에 영향을 받는다.
# 중위수는 극단값에 영향을 받지 않는다.

# 이상치 뽑아내기
# 이상치 : 패턴에서 벗어난 값

ggplot(IMDB, aes(x=as.factor(Year), y=Revenue..Millions.)) +
  geom_boxplot(aes(fill=as.factor(Year)), outlier.colour = 'red', alpha=I(0.4))+
  xlab('년도') + ylab('수익') + guides(fill = FALSE) + 
  theme_bw()+
  theme(axis.text.x = element_text(angle = 90))

# Outlier의 처리방법

Q1 = quantile(IMDB$Revenue..Millions., probs = c(0.25), na.rm = TRUE)
Q3 = quantile(IMDB$Revenue..Millions., probs = c(0.75), na.rm = TRUE)

LC = Q1 - 1.5 * (Q3 - Q1)                                   
UC = Q3 + 1.5 * (Q3 + Q1)

IMDB2 = subset(IMDB,
               (Revenue..Millions. > LC)&(Revenue..Millions. < UC) )

# ggplot(IMDB2, aes(x=as.factor(Year), y=Revenue..Millions.))+
  # geom_boxplot(aes(fill=as.factor(Year)), outlier.colour = 'red')

# 문자열 데이터 다루기 
# 문자열 대체 : gsub()
# 문자열 분리 : strsplit()
# 문자열 합치기 : paste()
# 문자열 추출 : substr()
# 텍스트마이닝 함수 : Corpus() & tm_map() & tdm()

#문자열 추출
substr(IMDB$Actors[1], 1, 5)

#문자열 붙이기
paste(IMDB$Actors[1],'_','A')

#띄어쓰기 없이 붙이기
paste(IMDB$Actors[1],'_','A', sep='')

paste(IMDB$Actors[1],'_','A', sep='|')

# paste는 기본적으로 붙이는 문자열 사이에 (한칸 빈칸)이 기본 설정
# 이를 수정하기 위해서는 sep=''옵션을 주어야 한다.

#문자열 분리 
strsplit(as.character(IMDB$Actors[1]), split=',')

#문자열 대체
IMDB$Genre2 = gsub(',', ' ', IMDB$Genre)

# 텍스트 마이닝 
# 1. 코퍼스(말뭉치) 생성
# 2. TDM(문서 행렬) 생성
# 3. 문자 처리(특수문자 제거, 조사 제거, 숫자 제거 등..)
# 4. 문자열 변수 생성

# 1단계: 코퍼스 생성
# 영어의 경우, 대문자와 소문자가 다른 글자로 인식되기 때문에 
# 바꿔주는 작업이 필요 
# install.packages('tm')
library(tm)

# 코퍼스 생성
# Corpus : 말뭉치 : 텍스트 마이닝을 하기 터에
# 문자열 데이터를 정리하는 과정
CORPUS = Corpus(VectorSource(IMDB$Genre2)) 
#특수문자 제거
CORPUS_TM = tm_map(CORPUS, removePunctuation)
#숫자 제거 
CORPUS_TM =tm_map(CORPUS, removeNumbers)
# 알파벳 모두 소문자로 바꾸기 
CORPUS_TM = tm_map(CORPUS_TM, tolower)

# 2단계 : 문서행렬 생성
# => 특정 단어를 변수로 만들어, 분석에 사용  
# => 특정 단어가 포함되어 있는 데이터만 따로 추출하거나
# 특정 단어가 많이 등장하였을 때,
# 이것이 다른 무언과와 상관성이 있는지 분석하기 위한 목적
# 즉, 문자열 데이터를 가지고 통계적인 분석을 하기위한 준비과정

# 문서행렬 생성
TDM = DocumentTermMatrix(CORPUS_TM)
inspect(TDM)

TDM = as.data.frame(as.matrix(TDM))
head(TDM)

# 3단계 : 기존데이터와 결합하기 
IMDB_GENRE = cbind(IMDB, TDM)

# 데이터 결합하기
# cbind : 행이 동일하고, 순서도 같을 때 옆으로 합치기
# rbind : 열이 동일하고, 순서도 같을 때 아래로 합치기
# merge : 열과 행이 다른 두 데이터 셋을 하나의 기준을 잡고 합치고자 할 때 사용 

# Description 변수 사용 (단어의 중복 등장 / 조사, 동사, 명사 등 등장)
# 1단계 : stopwords을 이용한 단어 제거 

library(tm)
CORPUS = Corpus(VectorSource(IMDB$Description))
CORPUS_TM = tm_map(CORPUS, stripWhitespace)
CORPUS_TM = tm_map(CORPUS_TM, removePunctuation)
CORPUS_TM = tm_map(CORPUS_TM, removeNumbers)
CORPUS_TM = tm_map(CORPUS_TM, tolower)

DTM = DocumentTermMatrix(CORPUS_TM)
inspect(DTM)

CORPUS_TM = tm_map(CORPUS_TM, removeWords,
                   c(stopwords('english'), 'my', 'custom', 'words'))

# 중복등장 단어 처리 결정
# 1안 : 특정 단어가 문장에 포함되어 있냐 없냐로 표시 -> 0,1로 코딩(0:포함x, 1:포함 o)
convert_count = function(x){
  y=ifelse(x>0,1,0)
  y = as.numeric(y)
  return(y)
}

# 2안 : 특정 단어가 문장에서 몇번 등장했나를 표시 -> 등장 빈도로 코딩 
convert_count = function(x) {
  y=ifelse(x>0,x,0)
  y=as.numeric(y)
  return(y)
}

DESCRIPT_IMDB = apply(DTM, 2, convert_count)
DESCRIPT_IMDB =  as.data.frame(DESCRIPT_IMDB)

# 3단계 : 문자열 데이터 시각화
# term Document Matrix 생성 
TDM = TermDocumentMatrix(CORPUS_TM)

# 위드 클라우드 생성 
m = as.matrix(TDM)
v =sort(rowSums(m), decreasing = TRUE)
d = data.frame(word = names(v), freq=v)

# install.packages("SnowballC")
library('SnowballC')
# install.packages('wordcloud')
library('wordcloud')
# install.packages('RColorBrewer')
library('RColorBrewer')

# min.freq -> 최소 5번 이상 쓰인 단어만 띄우기 
# max.words -> 최대 200개만 띄우기
# random.order -> 단어 위치 랜덤 여부

wordcloud(words = d$word, freq = d$freq, min.freq = 5,
          max.words=200, random.order=FALSE,
          colors=brewer.pal(8, 'Dark2'))

# 단어 빈도 그래프 그리기
ggplot(d[1:10,]) +
  geom_bar(aes(x = reorder(word, freq), y=freq),
           stat = 'identity') +
  coord_flip() + xlab('word') + ylab('freq') +
  theme_bw()



# chapter 4

library(dplyr)
# install.packages('dplyr')
library(reshape)
# install.packages('reshape')
library(plyr)

HR = read.csv('./HR_comma_sep.csv')
# for문은 하나의 열에 대해 작동한다. 
# apply는 여러 columns 혹은 row에 대해 동시에 계산할 수 있도록 도와줌
# apply(데이터, 계산 기준(1 혹은 2), 함수)
# 1: 행 별로 계산 / 2: 열 별로 계산
apply(HR[,1:2],2, mean)

colMeans(HR[,1:2])

apply(HR[,1:2],2,sd)

# R에서 연산함수는 na.rm=TRUE 옵션이 존재하지 않으면,
# 모든 결과값이 NA로 나오게 된다.

# 각 변수의 표준편차 구하는 방법 
D = c(1,2,3,4, NA)
E = c(1,2,3,4,5)

DF = data.frame(
  D = D,
  E = E
)
DF
apply(DF,2,sd)

colSd = function(x){
  y= sd(x, na.rm=TRUE)
  return(y)
}
colSd(D)

apply(DF, 2, colSd)

# tapply() : 그룹간 평균을 구하고 싶은 경우 
# tapply(데이터, 그룹, 연산함수)
tapply(HR$satisfaction_level, HR$left, mean)

# lapply() :한번에 여러 변수들에 대해 동일 조건을 주고 싶은 경우

#일반적인 방법 
DF$D2 = gsub(1, 'A', DF$D)
DF$E2 = gsub(1, 'A', DF$E)

DF2 = DF[,1:2]

DF3 = lapply(DF2, function(x) gsub(1,'A',x))
DF3 = as.data.frame(DF3)
DF3

head(rowMeans(HR[,1:2]))

#dplyr 를 썼을 때
# %>% 는 직관적으로 구성이 될 수 있도록 중간다리 역할
HR[,1:2] %>% 
  rowMeans() %>% 
  head()

HR[,1:5] %>% 
  colMeans()

# 데이터 집계 내기
# Summarise
summarise(HR, MEAN=mean(satisfaction_level),
          N = length(satisfaction_level))
# 또는
HR %>% 
  summarise(MEAN = mean(satisfaction_level),
            N = length(satisfaction_level))

HR2_O = ddply(subset(HR, left == 1), c('sales'),
      summarise,
      MEAN = mean(satisfaction_level),
      N = length(satisfaction_level))

HR2_D = HR %>% 
  subset(left ==1) %>% 
  group_by(sales) %>% 
  dplyr::summarise(
    MEAN = mean(satisfaction_level),
    N = length(satisfaction_level)
  )

# 새로운 변수를 추가하고 싶은 경우 
HR3_D = HR2_D %>% 
  mutate(percent = MEAN /N)

# dplyr와 ggplot2의 조합 
library(ggplot2)

HR2_D %>% 
  ggplot() +
  geom_bar(aes(x=sales, y=MEAN, fill=sales), stat='identity') +
  geom_text(aes(x=sales, y= MEAN+0.05,
                label=round(MEAN, 2))) +  # 위에 숫자 표시 
  theme_bw() + #배경화면 
  xlab('부서') + ylab('평균 만족도') + guides(fill = 'none') +
  theme(axis.text.x = element_text(
    angle=45, size = 8.5, color = 'black',
    face='plain', vjust=1, hjust=1))

# 중복데이터 제거하기 및 데이터 프레임 정렬
rep(1:10, 2)
A=rep(1:10, each = 2)

# 중복 제거
unique(A)

# 데이터 프레임에서의 중복 제거 
duplicate = read.csv('./duplicated.csv')
# 전체 중복 제거 
duplicated3_1 = duplicate[-which(duplicated(duplicate)),]

# 변수 한개를 기준으로 중복 제거
# NAME이 같은 변수들 중복 제거 
duplicated3_2 = duplicate[-which(duplicated(duplicate$NAME)),]

# 다변수를 기준으로 중복 제거 

# NAME, ID 두 개의 값이 같은 중복 데이터 제거 
# 변수명으로 제거 
duplicated3_3 = duplicate[!duplicated(duplicate[,c('NAME', 'ID')]),]

# 변수인덱스로 제거 
duplicated3_4 = duplicate[!duplicated(duplicate[,c(2,3)]),]

duplicate$DATE = as.Date(duplicate$DATE, '%Y-%m-%d')
summary(duplicate$DATE)

# as.Date : 년-월-일
# as.Posixct : 년-월-일 시:분:초

# DATE변수 기준으로 정렬 
duplicate_sort = duplicate[order(duplicate[,'DATE'], decreasing = TRUE),]

library(reshape) # 데이터 프레임의 형태를 바꾸고 싶을 때

RESHAPE = read.csv('./reshape.csv')
RESHAPE
CAST_DATA = cast(RESHAPE, OBS + NAME + ID + DATE ~ TEST)

# 다시 원래대로 돌아가는 방법 
MELT_DATA = melt(CAST_DATA, id=c('OBS', 'NAME', 'ID', 'DATE'))
MELT_DATA = na.omit(MELT_DATA)
MELT_DATA

# CAST_DATA의 경우, 그래프 시각화할 때의 데이터 구조로 적합 
# MELT_DATA의 경우, 모델링 할때의 데이터 구조로 적합

# 데이터 합병 
DUPLICATE = duplicate
DUPLICATED3_3 = duplicated3_3
RESHAPE
CAST_DATA

MERGE = merge(DUPLICATED3_3, CAST_DATA[, c(-1,-2,-4)], by='ID',
      all.x = TRUE)



# chapter 5

library(dplyr)

STOCK = read.csv('./uniqlo_stocks2012-2016.csv')
STOCK

STOCK$Date = as.Date(STOCK$Date)
STOCK$Year = as.factor(format(STOCK$Date, '%Y'))
STOCK$Day = as.factor(format(STOCK$Date, '%a'))

str(STOCK)

# group_by : 집계 기준 변수를 정해주는 명령어
# summarise : 집계 기준 변수 및 명령어에 따라 요약값을 계산

Group_Data = STOCK %>% 
  group_by(Year, Day) %>% 
  summarise(Mean = round(mean(Open)),
            Median = round(median(Open)),
            Max = round(max(Open)),
            Counts = length(Open)
    
  )

# ungroup : group으로 묶인 데이터를 그룹 해제 시켜주는 명령어 
Ungroup_Data = Group_Data %>% 
  ungroup()

# count : 집계 기준에 따라 데이터의 row 갯수를 계산해준다.
Count_Data = STOCK %>% 
  group_by(Year, Day) %>% 
  count()

# 조건에 따라 데이터 추출하기 (filter(), subset())
Subseted_Data = Group_Data %>% 
  filter(Year == '2012')

head(Subseted_Data)

# distinct() : 데이터 내에 존재하는 중복데이터 제거
SL = sample(1:nrow(Group_Data), 500, replace = TRUE)
Duplicated_Data = Group_Data[SL,]

Duplicated_Data2 = Duplicated_Data %>% 
  distinct(Year,Day,Mean,Median,Max,Counts)

# sample_frac(), sample_n() : 샘플 데이터 무작위 추출
# sample_frac() : 그룹이 지정되어 있는 데이터
Sample_Frac_Gr = Group_Data %>% 
  sample_frac(size=0.4, replace = FALSE)

# 그룹이 해제되어 있는 데이터 
Sample_Frac_Un = Ungroup_Data %>% 
  sample_frac(size=0.4, replace = FALSE)

Sample_N_Gr = Group_Data %>% 
  sample_n(size= 5, replace= FALSE)

Sample_N_Un = Ungroup_Data %>% 
  sample_n(size= 10, replace= FALSE)

# 정해진 index에 따라 데이터 추출하기 
# slice() : index를 직접 설정함으로, 원하는 구간만 추출가능

Slice_Data =Ungroup_Data %>% 
  slice(1:10)

# top_n() : 설정해준 변수를 기준으로 가장 값이 높은 n개의 데이터를 가져온다,
Top_n_Data = Ungroup_Data %>% 
  top_n(5, Mean) # Mean이 가장 높은 5개 데이터 추출

# arrange() : 데이터를 특정 변수를 기준으로 정렬하는 방법

Asce_Data =Ungroup_Data %>% 
  arrange(Mean)
# 내림차순은 변수에 -를 붙여준다.
Desc_Data = Ungroup_Data %>% 
  arrange(-Mean)

# select() : 원하는 변수를 뽑아 낼 수 있다.
# 인덱스, 변수명 다 상관없다.
# index 활용
Select_Data = Group_Data %>% 
  select(1:2)
# Column명 활용
Select_Data = Group_Data %>% 
  select(Year, Day)

# select_if :뽑는 조건을 줄 수 있다.
# Factor 변수만 뽑기
Select_if_Data1 = Group_Data %>% 
  select_if(is.factor)
# integer 변수만 뽑기
Select_if_Data2 = Group_Data %>% 
  select_if(is.integer)


# 새로운 변수 만들기 혹은 한번에 처리하기 
# mutate(): 하나의 변수를 명령어에 따라 추가하는 방법 
Mutate_Data = STOCK %>% 
  mutate(Divided = round(High/Low, 2)) %>% 
  select(Date,High,Low,Divided)

# mutate_if() : 지정해준 모든 변수에 대해 계산식을 적용시켜 준다.
# integer 타입 변수를 모두 numeric으로 변경 
Mutate_If_Data = STOCK %>% 
  mutate_if(is.integer, as.numeric)

# mutate_at() : 지정한 변수들에 대해 계산식을 적용시키는 명령어
Mutate_At_Data = STOCK %>% 
  mutate_at(vars(-Date, -Year, -Day), log) %>% 
  select_if(is.numeric)



# chapter 6

library(ggplot2)
library(ggthemes)
# install.packages('ggthemes')
# getwd()

HR =read.csv('./HR_comma_sep.csv')
HR$left = as.factor(HR$left)
HR$salary = factor(HR$salary, levels = c('low', 'medium', 'high'))

# classic Theme
ggplot(HR, aes(x=salary)) +
  geom_bar(aes(fill=salary)) +
  theme_classic()

# BW theme
ggplot(HR, aes(x=salary)) +
  geom_bar(aes(fill=salary)) +
  theme_bw()

Graph = ggplot(HR,aes(x=salary)) +  
  geom_bar(aes(fill=salary)) 

# 테마 적용
Graph + theme_bw() + ggtitle("Theme_bw") 
Graph + theme_classic() + ggtitle("Theme_classic") 
Graph + theme_dark() + ggtitle("Theme_dark") 
Graph + theme_light() + ggtitle("Theme_light")  

Graph + theme_linedraw() + ggtitle("Theme_linedraw") 
Graph + theme_minimal() + ggtitle("Theme_minimal") 
Graph + theme_test() + ggtitle("Theme_test") 
Graph + theme_void() + ggtitle("Theme_vold") 

# 범례제목 수정
ggplot(HR,aes(x=salary)) +  
  geom_bar(aes(fill=salary)) +
  theme_bw() +
  labs(fill = "범례 제목 수정(fill)")

ggplot(HR,aes(x = salary)) +  
  geom_bar(aes(col = salary)) +
  theme_bw() +
  labs(col = "범례 제목 수정(col)")

# 범례 위치 수정
Graph + theme(legend.position = "top")
Graph + theme(legend.position = "bottom")
Graph + theme(legend.position = c(0.9,0.7))
Graph + theme(legend.position = 'none')

# 범례 테두리 설정
Graph + theme(legend.position = "bottom")


Graph + theme(legend.position = "bottom",
              legend.box.background = element_rect(),
              legend.box.margin = margin(1, 1, 1, 1))

# x축 : 이산형 : scale_x_discrete()
# x축 : 연속형 : scale_x_continuous()
# y축 : 이산형 : scale_y_discrete()
# y축 : 연속형 : scale_y_continuous()

# 축 변경
ggplot(HR,aes(x = salary)) +  
  geom_bar(aes(fill = salary)) +
  theme_bw() +
  scale_x_discrete(expand =  c(0,0), labels = c("하","중","상")) +
  scale_y_continuous(expand = c(0,0),breaks = seq(0,8000,by = 1000))

ggplot(HR,aes(x = salary)) +  
  geom_bar(aes(fill = salary)) +
  theme_bw() +
  scale_x_discrete(expand =  c(0,0), labels = c("하","중","상")) +
  scale_y_continuous(expand = c(0,0),breaks = seq(0,8000,by = 1000)) +
  scale_fill_discrete(labels = c("하","중","상"))

# 축범위 설정 : 그래프를 표현할 범위를 나타낼 수가 있다.
ggplot(HR,aes(x = salary)) +  
  geom_bar(aes(fill = salary)) +
  theme_bw() +
  ylim(0,5000)

ggplot(HR,aes(x = salary)) +  
  geom_bar(aes(fill = salary)) +
  theme_bw() +
  ylim(0,13000)

# 색변경
ggplot(HR,aes(x = salary)) +  
  geom_bar(aes(fill = salary)) +
  theme_bw() +
  scale_fill_manual(values = c('red','royalblue','tan')) 


ggplot(HR,aes(x = salary)) +  
  geom_bar(aes(fill = salary), alpha = 0.4) +
  theme_bw() +
  scale_fill_manual(values = c('red','royalblue','tan')) 

# 그래프 분할 및 대칭 이동
ggplot(HR,aes(x = salary)) +  
  geom_bar(aes(fill = salary), alpha = 0.4) +
  theme_bw() +
  scale_fill_manual(values = c('red','royalblue','tan')) +
  coord_flip()


ggplot(HR,aes(x = salary)) +  
  geom_bar(aes(fill = salary)) +
  theme_bw() +
  scale_fill_manual(values = c('red','royalblue','tan'))  +
  guides(fill = FALSE) + 
  facet_wrap(~left,ncol = 1) 

#글자크기, 각도 수정
ggplot(HR,aes(x = salary)) +  
  geom_bar(aes(fill = salary)) +
  theme_bw() +
  scale_fill_manual(values = c('red','royalblue','tan'))  +
  coord_flip() +
  theme(legend.position = 'none',
        axis.text.x = element_text(size = 15,angle = 90),
        axis.text.y = element_text(size = 15),
        legend.text = element_text(size = 15))



# chapter 7 

library(ggplot2)
library(dplyr)

STOCK = read.csv('./Uniqlo.csv')

STOCK$Date = as.Date(STOCK$Date)
STOCK$Year = as.factor(format(STOCK$Date, '%Y'))
STOCK$Day = as.factor(format(STOCK$Date, '%a'))

Group_Data = STOCK %>% 
  group_by(Year, Day) %>% 
  summarise(Mean = round(mean(Open)),
            Median = round(median(Open)),
            Max = round(max(Open)),
            Counts = length(Open))
Group_Data

# Bar Chart

# 막대도표는 가장 기본적인 그래프. 
# 하나의 이산형 변수에 대해 시각화를 하는 그래프. 
# 기본적으로 y축은 따로 설정할 필요는 없다.

# 하나의 이산형 변수를 기준으로 x축 변수 1개로만 그리는 경우
ggplot(Group_Data) +
  geom_bar(aes(x = as.factor(Counts), fill = ..count..)) +
  xlab('') + ylab('') +
  scale_fill_gradient(low = '#CCE5FF', high = '#FF00FF') +
  theme_classic() + ggtitle('Continuous Color')
# scale_fill_gradient()를 통해서 칸의 크기와 
# count의 최저,최대치를 설정 가능

ggplot(Group_Data) +
  geom_bar(aes(x = as.factor(Counts), fill = Day), alpha =.4) + 
  # fill 함수는 도형에 색을 채워줄 때 사용
  # bar그래프와 오차그래프 등 채울 공간이 있는 도형에 색상을 채운다.
  # <-> color 함수는 선의 색깔을 채워줄 때 사용하는 함수
  # Bar 그래프의 테두리, Line그래프의 색상, 
  # 경우에 따라 Point그래프의 Point 테두리 등에 색상을 채워줌 
  xlab('') + ylab('')+
  theme_classic() + ggtitle('Discrete Color')
  
# plyr 패키지
# - plyr 패키지는 원본 데이터를 분석하기 쉬운 형태로 나눠서 다시 새로운 형태로 만들어 주는 패키지이다.
# - plyr 패키지의 함수들은 데이터 분할(split), 원하는 방향으로 특정 함수 적용(apply), 그 결과를 재조합(combine)하여 반환한다.
# - plyr 패키지 함수는 ##ply 형태이고, 첫 번째 글자는 입력 데이터의 형태, 두 번째 글자는 출력 데이터의 형태를 의미한다.

# install.packages("plyr")
# library(plyr)
# install.packages('dplyr')

# install.packages('ggplot2')

# select()
# - `데이터 프레임 이름 %>% select(선택할 변수명, -제외할 변수명)`
library(dplyr)

iris %>% 
    select(Sepal.Length) %>% head()

# filter()
# `데이터 프레임 이름 %>% filter(조건)` : 조건에 맞는 데이터 추출

iris %>% filter(Species == 'setosa') %>% select(Sepal.Length, Sepal.Width) %>% head()

# mutate()

# - `데이터 프레임 이름 %>% mutate(새로운 변수명=값)` : 데이터에 새로운 파생변수를 추가
iris %>% 
    filter(Species == 'virginica') %>% 
    mutate(Len = ifelse(Sepal.Length>6, 'L', 'S')) %>% 
    select(Species, Len) %>% 
    head()

# group_by와 summarise 함수

# - `데이터 프레임 이름 %>% group_by(그룹화할 기준 변수1, ...) %>% summarise(새로운 변수명=계산식)` : 지정한 변수들을 기준으로 데이터를 그룹화하고, 요약 통계치 산출
# - **요약 통계치 함수** : mean(), sd(), sum(), median(), min(), max(), n

iris %>% 
    group_by(Species) %>% 
    summarise(Petal.Width = mean(Petal.Width))

# arrange 함수

# `데이터 프레임 이름 %>% arrange(정렬 기준변수)` : 오름차순 정렬
# `데이터 프레임 이름 %>% arrange(desc(정렬 기준변수))` : 내림차순 정렬

iris %>% 
    filter(Species == 'setosa') %>% 
    mutate(Len = ifelse(Sepal.Length>5, 'L', 'S')) %>% 
    select(Species, Len, Sepal.Length) %>% 
    arrange(desc(Sepal.Length))

# join 함수 

# - `inner_join(x, y, by, ...)` : 두 데이터 프레임에서 공통적으로 존재하는 모든 열을 병합하는 함수
# - `left_join(x, y, by, ...)` : 왼쪽 데이터 프레임을 기준으로 모든 열을 병합하는 함수
# - `right_join(x, y, by, ...)` : 오른쪽 데이터 프레임을 기준으로 모든 열을 병합하는 함수
# - `full_join(x, y, by, ...)` : 두 데이터 프레임에 존재하는 모든 열을 병합하는 함수

# bind_rows()
# - `bind_rows(데이터명1, ...)` : 데이터 행들을 연결하여 결합 

x = data.frame(x=1:3, y=1:3)
x
y = data.frame(x=4:6, z=4:6)
y
bind_rows(x, y)

# bind_cols()

# - `bind_cols(데이터명1, ...)` : 데이터 열들을 연결하여 결합

x = data.frame(title=c(1:5),
                a=c(30,70,45,90,65))
x
y = data.frame(b=c(70,65,80,80,90))
y
bind_cols(x, y)                




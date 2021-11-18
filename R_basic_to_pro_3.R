# 결측값 인식 함수 예제
ds_na = is.na(head(airquality, 5))
ds_na

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
head(mtcars$wt)
str(mtcars)

# 변수 선택 기법 예시
data(mtcars)
m1 = lm(hp~., data=mtcars)
m2 = step(m1, direction="both")
formula(m2)

중요도 <- c('상', '중', '하')
df = data.frame(중요도)
df
transform(
    df,
    변수1 = ifelse(중요도=='중', 1, 0),
    변수2 = ifelse(중요도=='하', 1,0))
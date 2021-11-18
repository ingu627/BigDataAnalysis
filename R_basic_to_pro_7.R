# 군집분석 

# 데이터 탐색 
str(USArrests)
head(USArrests)
summary(USArrests)

# 유클리디안 거리 측정 

US.dist_euclidean = dist(USArrests, 'euclidean')
US.dist_euclidean

# 분석 모형 구축(계층적 군집 분석)

US.single = hclust(US.dist_euclidean^2, method="single")
plot(US.single)

group = cutree(US.single, k=6)
group

rect.hclust(US.single, k=6)

# 비계층적 군집 분석 - k평균 군집 분석 

# install.packages('NbClust')
library(NbClust)
# install.packages('rattle')
library(rattle)
df=scale(wine[-1])
set.seed(1234)
fit.km = kmeans(df, 3, nstart=25)
fit.km$size
fit.km$centers

# 분석 모형 활용
plot(df, col=fit.km$cluster)
points(
    fit.km$center, col=1:3, 
    pch=8, cex=1.5)


# 연관성 분석

install.packages('arules')
install.packages('arulesViz')

library(arules)
library(arulesViz)
data('Groceries')
summary(Groceries)

# apriori 함수를 통한 연관 규칙 생성 
apr = apriori(
    Groceries,
    parameter=list(support=0.01,
    confidence=0.3)
    )

# inspect 함수를 통해 연관 규칙 확인 

inspect(sort(apr, by='lift')[1:10])
# 11. airquality

data(airquality)
str(airquality)

library(dplyr)
ds=airquality %>% 
    filter(Month==8 & Day==20)

result=ds$Ozone
print(result)


# 12. iris

data(iris)
result = mean(iris$Sepal.Length, na.rm = TRUE) + mean(iris$Sepal.Width, na.rm = TRUE)
print(result) # 8.900667


# 13. mtcars

data(mtcars)
str(mtcars)
summary(mtcars)

library(dplyr)
ds=mtcars %>% 
    filter(cyl==4)

result = nrow(ds) / nrow(mtcars) * 100
print(result) # 34.375


# 14. mtcars

data(mtcars)
summary(mtcars)

library(dplyr)
ds = mtcars %>% 
    filter(gear == 4 & am==1)

result = mean(ds$mpg) + sd(ds$hp)
print(result) # 50.44959


# 15. BostonHousing
library(MASS)
data(Boston)

str(Boston)
summary(Boston)

library(dplyr)
ds = Boston %>% 
    filter(crim <= 1)
result=mean(ds$medv)
print(result) # 25.11084


# 16. iris

data(iris)
library(dplyr)

ds = iris %>% filter(Species == 'virginica') %>% 
    mutate(Len = ifelse(Sepal.Length > 6, 1, 0))
result = sum(ds$Len)
print(result) # 41


# 17. airquality

data(airquality)
a_mean = mean(airquality$Ozone, na.rm = TRUE)

airquality$Ozone = ifelse(
    is.na(airquality$Ozone),
    a_mean,
    airquality$Ozone)

a_med = median(airquality$Ozone)
quantile(airquality$Ozone)
#        0%       25%       50%       75%      100%
#   1.00000  21.00000  42.12931  46.00000 168.00000 
a_under = a_med - 2*IQR(airquality$Ozone)
a_upper = a_med + 2*IQR(airquality$Ozone)

library(dplyr)
ds = airquality %>% 
    filter(Ozone < a_upper & Ozone > a_under)

result = sum(ds$Ozone)
print(result) # 5279.784


# 18. marvel

ds = read.csv('sujebi_data/marvel-wikia-data.csv')
head(ds)
str(ds)
summary(ds)

library(dplyr)
ds1 = ds %>% 
    filter(HAIR == "Brown Hair" & EYE == "Brown Eyes")

iqr = IQR(ds1$APPEARANCES, na.rm = TRUE)
q1 = quantile(ds1$APPEARANCES, na.rm = TRUE)[2]
m_under = q1 - 1.5*iqr
m_upper = q1 + 1.5*iqr

ds2 = ds1 %>% 
    filter(APPEARANCES <= m_upper & APPEARANCES >= m_under)
result = mean(ds2$APPEARANCES, na.rm = TRUE)
print(result) # 7.773512


# 19. ChickWeight

library(MASS)
data(ChickWeight)
str(ChickWeight)
dim(ChickWeight)

library(dplyr)
ds = ChickWeight %>% 
    filter(Time == 10)

before_mean = mean(ds$weight) # 107.8367

ds1 = ds %>% 
    arrange(desc(weight))
head(ds1)

stand = ds1$weight[30]

ds1$weight = ifelse(ds1$weight >= stand, before_mean, ds1$weight)
after_mean = mean(ds1$weight)
result = abs(after_mean - before_mean)
print(result) # 9.120367


# 20. FIFA Ranking

fifa=read.csv("sujebi_data/fifa_ranking.csv")
str(fifa)
summary(fifa)
# country_abrv total_points
library(dplyr)

fifa_point = fifa %>% select(total_points) %>% 
    arrange(desc(total_points))
top3_point = fifa_point[3,]

fifa_country = fifa %>% 
    filter(fifa_point >= top3_point) %>% 
    select(country_abrv)
fifa_country = as.vector(fifa_country$country_abrv)  # GER ITA SUI

f_mean = fifa %>% 
    filter(country_abrv %in% fifa_country) %>% 
    summarise(mean = mean(total_points, na.rm = TRUE))
print(f_mean$mean) # 348.098


# 21. sales_train

sales=read.csv('sujebi_data/sales_train_v2.csv')

head(sales)
str(sales)
summary(sales)
dim(sales)

library(dplyr)
top3_item = sales %>% group_by(item_id) %>% 
    summarise(n = n()) %>% 
    arrange(desc(n)) %>% 
    head(3)
top3_item

top3_id = as.vector(top3_item$item_id)
top3_id

sum(is.na(sales$item_price))

total_sd = sd(sales$item_price)

top3_sd = sales %>% 
    filter(item_id %in% top3_id) %>% 
    summarise(sd = sd(item_price))
top3_sd = top3_sd$sd

print(abs(total_sd - top3_sd)) # 1101.796


# 1. airquality

data(airquality)
str(airquality)

library(dplyr)
ds = airquality %>% filter(!is.na(Solar.R))
before_sd = sd(ds$Ozone, na.rm = TRUE)
before_sd # 33.27597

med_O = median(ds$Ozone, na.rm = TRUE)

ds$Ozone = ifelse(
    is.na(ds$Ozone), 
    med_O, ds$Ozone)

after_sd = sd(ds$Ozone)
after_sd # 29.3704
print(abs(before_sd - after_sd)) # 3.90557

# 2. Hitters 
# install.packages('ISLR')
library(ISLR)
data(Hitters)

head(Hitters)
str(Hitters)
summary(Hitters)

med = median(Hitters$Salary, na.rm = TRUE)
iqr = IQR(Hitters$Salary, na.rm = TRUE)

library(dplyr)
ds2 = Hitters %>% select(Salary) %>% 
    filter(Salary < (med - 2*iqr) | Salary > (med + 2*iqr))
result = sum(ds2)
print(result) # 21671.86

# 3. diamonds

# install.packages('ggplot2')
library(ggplot2)
data(diamonds)

head(diamonds)
str(diamonds)
summary(diamonds)

idx=nrow(diamonds)*0.8
ds=diamonds[1:idx,]

library(dplyr)
ds_train = ds %>% arrange(desc(price)) %>% 
    head(100)

mean(ds_train$price) # 18663.33

# 4. airquality

data(airquality)

idx=nrow(airquality)*0.9
ds = airquality[1:idx,]
before_sd = median(ds$Ozone, na.rm = TRUE)

ds$Ozone = ifelse(
    is.na(ds$Ozone),
    mean(ds$Ozone, na.rm = TRUE), ds$Ozone)

after_sd = median(ds$Ozone, na.rm = TRUE)
result = abs(before_sd - after_sd)
print(result) # 10.36634

# 5. music

music=read.csv('./sujebi_data/music.csv')
head(music)
str(music)
summary(music)

quantile(music$tempo)
#       0%       25%       50%       75%      100%
#  54.97839  99.38401 117.45384 135.99918 234.90767

ds <- music$tempo <- ifelse(
    music$tempo < 99.38401,
    0,
    ifelse(
        music$tempo > 135.99918,
        0,
        music$tempo
    )
)
result = mean(ds) + sd(ds)
print(result) # 124.3836


# 6. telco-customer-churn

churn = read.csv('sujebi_data/WA_Fn-UseC_-Telco-Customer-Churn.csv')
str(churn)

sum(is.na(churn$TotalCharges))
mean = mean(churn$TotalCharges, na.rm = TRUE)
sd = sd(churn$TotalCharges, na.rm = TRUE)

upper = mean + 1.5*sd
under = mean - 1.5*sd

library(dplyr)
ds <- churn %>% select(TotalCharges) %>% 
    filter(TotalCharges > under & TotalCharges < upper)

result = mean(ds$TotalCharges, na.rm = TRUE)
print(result) # 1663.995


# 7. cats

# install.packages('MASS')
library(MASS)
data(cats)
quantile(cats$Hwt)
sum(is.na(cats$Hwt))

c_mean = mean(cats$Hwt)
c_sd = sd(cats$Hwt)

upper = c_mean + 1.5*c_sd
under = c_mean - 1.5*c_sd

library(dplyr)
ds <- cats %>%
    filter(Hwt > upper | Hwt < under)

result = mean(ds$Hwt)
print(result) # 13.94375


# 8. orings

# install.packages('faraway')
library(faraway)
data(orings)

library(dplyr)
ds = orings %>% 
    filter(damage >= 1)
result = cor(ds$temp, ds$damage, method="pearson")
print(result) # -0.5790513


# 9. mtcars

data(mtcars)
str(mtcars)

library(dplyr)
ds1 = mtcars %>%
    filter(am==1) %>% 
    arrange(wt)
am1_mean = mean(head(ds1$mpg, 10))

ds2 = mtcars %>% 
    filter(am==0) %>% 
    arrange(wt)
am2_mean = mean(head(ds2$mpg, 10))

result = abs(am1_mean - am2_mean)
print(result) # 7.07


# 10. diamonds

library(ggplot2)
data(diamonds)

idx1 = nrow(diamonds)*0.8
idx2 = nrow(diamonds)

ds = diamonds[idx1:idx2,]

library(dplyr)
ds1 = ds %>% 
    filter(cut == "Fair" & carat >=1)
sum(is.na(ds1))
str(ds1)

result = max(ds1$price) 
print(result) # 2745
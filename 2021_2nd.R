# 11. BostonHousing

library(mlbench)
data(BostonHousing)
boston = BostonHousing
str(boston)

library(dplyr)
top_crim = head(sort(boston$crim, decreasing = TRUE), 10)
ten = top_crim[10]

boston$crim <- ifelse(boston$crim>=ten, ten, boston$crim)

boston = boston %>% filter(age>=80)
result = mean(boston$crim)
print(result)



# 12. housing

housing = read.csv('./data/housing.csv', header=TRUE)
head(housing)
str(housing)
nrow(housing)

train = housing[1:(nrow(housing)*0.8),]
nrow(train)
before_sd = sd(train$total_bedrooms, na.rm = TRUE)

train$total_bedrooms = ifelse(is.na(train$total_bedrooms), median(train$total_bedrooms, na.rm = TRUE), train$total_bedrooms) 
after_sd = sd(train$total_bedrooms)
print(abs(before_sd - after_sd))
# [1] 1.975147

# 13. insurance

insurance=read.csv('./data/insurance.csv')
head(insurance)
str(insurance)
summary(insurance)

sum(is.na(insurance$charges))

avg = mean(insurance$charges)  # 13270.42
sd1 =  sd(insurance$charges) # [1] 12110.01

library(dplyr)

insurance %>% 
    select(charges) %>% 
    filter(charges >= avg + 1.5*sd1 | charges <= avg - 1.5*sd1) %>% 
    sum()
# [1] 6421430


# 14. Train.csv


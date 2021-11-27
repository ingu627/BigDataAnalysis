# getwd()
setwd('./solve_bigdata')

X_train=read.csv('./example_data/X_train.csv')
y_train=read.csv('./example_data/y_train.csv')
X_test=read.csv('./example_data/X_test.csv')

head(X_train)
str(X_train)
summary(X_train)
dim(X_train)

head(y_train)
str(y_train)
dim(y_train)

str(X_test)
dim(X_test)

sum(is.na(X_train))
sum(is.na(y_train))
sum(is.na(X_test))

# cust_id 총구매액 최대구매액 환불금액  주구매상품 
# 주구매지점 내점일수 내점당구매건수 주말방문비율 구매주기
X_train$총구매액 = ifelse(
    is.na(X_train$총구매액)
)
mean(X_train$총구매액, na.rm = TRUE)





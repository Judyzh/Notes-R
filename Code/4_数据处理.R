## 数据处理
# 算术运算: + - * / ^   x%%y:求余   x%/%y:整数除法

mydata <- data.frame(x1=c(2,2,6,4), x2=c(3,4,2,8))

attach(mydata)
mydata$sumx <- x1+x2
detach(mydata)

mydata <- transform(mydata, sum = x1+x2, mean=(x1+x2)/2)
#创建新的变量sum,mean并赋值
mydata <- transform(mydata, sum=-sum)

# 逻辑运算： < <= > >= == != !x   x|y  x&y   isTRUE(x)
manager <- c(1,2,3,4,5)
age <- c(25,34,28,52,99)
date <- c("10/24/08","10/28/08","10/1/08","10/12/08","5/12/09")
country <- c("US","US","UK","UK","UK")
gender <- c("M","F","F","M","F")
q1 <- c(5,3,3,3,2)
q2 <- c(4,5,5,2,3)
q3 <- c(5,2,5,3,1)
q4 <- c(5,5,5,NA,2)
q5 <- c(5,5,2,NA,1)
leadership <- data.frame(manager,date,country,gender,age,q1,q2,q3,q4,q5
                         ,stringsAsFactors = FALSE)

leadership$age[leadership$age == 99] <- NA
#variable[condition] <- expression, 仅在condition为TRUE时执行

leadership <- within(leadership, {
    agecat <- NA
    agecat[age >=75] <- "Elder"
    agecat[age>=55 & age <75] <- "Middle Aged"
    agecat[age <55] <- "Young"
})
# within同with，但可直接修改数据框
# 新增agecat列，并按age值赋值


# Missing Value: NA (NaN为非数值，如 0/0), 缺失值不可比较，要用is.NA()判断
is.na(leadership[,6:10]) #NA返回TRUE
newdata<- na.omit(leadership) #删除含NA的行

score_m <- sapply(leadership[,6:10],2,mean,na.rm=TRUE)

# 日期
mydates <- as.Date("2017/1/1")
mydates2 <- as.Date("01/01/2017", "%d/%m/%Y")
mydates3 <- as.Date("20170101", "%Y%m%d")

today <- Sys.Date()
format(today, "%Y")

#日期计算
startdate <- as.Date("2014-01-02")
enddate <- as.Date("2014-02-03")
days <- enddate-startdate
days

difftime(enddate, startdate, units = "weeks")

## 排序
attach(leadership)
newdata <- leadership[order(gender, -age)]
detach(leadership)

#取子集
newdata <- subset(leadership, gender=="M" & age >25, select=gender:q4)
newdata

newdata2 <- subset(leadership, gender=="M" | age >25, select=gender:q4)
newdata2

## 创建及调取数据集

# 向量 -- 一维，同模式
a <- c(1,2,3,5,-2,4)
b <- c("one","two","three")
d <- c(TRUE, FALSE, TRUE)

a[5]
a[c(2,4)]
a[2:4]

x <- c(1,2,3)
x[7] <- 10
x  #自动扩展数据结构

# 矩阵 -- 二维，同模式
y <- matrix(1:6,2,3)  # 2行3列矩阵，按列赋值

rnames <- c("R1","R2")
cnames <- c("C1","C2","C3")
z <-
    matrix(
        1:6, nrow = 2, ncol = 3, byrow = TRUE, dimnames = list(rnames,cnames)
    )
# 2行3列矩阵，按行赋值(默认按列赋值)，并取行、列名

y[,1] #取第一列
y[1,] #取第一行
y[2,3] #取第二行第三列值
y[2,c(1,3)] #取第二行第一列值 和 第二行第三列值
y[1,1:3] #取第一行


# 数组 -- 多维，同模式
dim1 <- c("A1","A2")
dim2 <- c("B1","B2","B3")
dim3 <- c("C1","C2","C3","C4")
arr <- array(1:24,c(2,3,4), dimnames=list(dim1,dim2,dim3))
# 2*3*4数组

# arr[1,2,3]  #C3的第一行第二列


# 数据框 -- 二维，每列可不同模式，同列为同模式
patientid <- c(1,2,3,4)
age <- c(25,34,28,52)
diabetes <- c("Type1","Type2","Type1","Type1")
status <- c("Poor","Improved","Excellent","Poor")
patientdata <- data.frame(patientid,age,diabetes,status)
names(patientdata)[1:2] <- c("id","agetest") #重命名patientid为id

patientdata2 <- data.frame(id=patientid,age,diabetes,status, stringsAsFactors = FALSE)

patientdata3 <- data.frame(id=patientid,age,diabetes,status,row.names=patientid)

patientdata[2,3] #取第二行第三列值
patientdata[1:2] #取第一二列
patientdata[1:2,] #取第一二行
patientdata$age #取age

patientdata2[c("age","id")] #取age,id列


attach(patientdata)
summary(status)
mean(age)
detach(patientdata)

with(patientdata, {
    ss <-sum(age)
    mm <-mean(age)
})
# 赋值只在with函数内生效  with函数外调用ss 报错Error: object 'ss' not found

with(patientdata, {
    nokeep <-sum(age)
    keep <<-sum(age)
})
nokeep
keep
# <<- 对象将保存在with函数外的全局环境中

# 因子
diabetes_f <- factor(diabetes)
status_f <- factor(status,ordered=T,levels=c("Poor","Improved","Excellent"))
#创建有序因子

gender <- c(1,1,2,1)
patient_n <- cbind(patientdata,gender=gender)
patient_n$gender <- factor(patient_n$gender, levels=c(1,2), labels= c("Male", "Female") )
# 新增gender列，并给因子添加标签

# 列表 -- 各种对象的组合
g <- "My List"
h <- c(23,54,32,76)
j <- matrix(1:4,2,2)
k <- c("one","two")
mylist <- list(title=g,ages=h,j,k)

mylist[[2]][1] #对象h的第一个值
mylist[[3]][2,1] #对象j的第二行第一列
mylist[["ages"]] #对象h
mylist$title #对象g


# ---------------------------------------------

## 数据输入

#手动输入
mydata <- data.frame(age=numeric(0), gender=character(0), weight=numeric(0))
mydata <- edit(mydata)

mydata2 <- data.frame(age=numeric(0), weight=numeric(0))
fix(mydata2)

#导入.csv
grades <- read.table("studentgrades.csv", header=TRUE, sep=",", row.names="StudentID")

#导入excel
install.packages("RODBC")
library(RODBC)
channel <- odbcConnectExcel("myfile.xls")
mydataframe <- sqlFetch(channel, "mysheet")
odbcClose(channel)

library(xlsx)
workbook <- "c:/myworkbook.xlsx"
mydataframe <- read.xlsx(workbook,1) #工作表1

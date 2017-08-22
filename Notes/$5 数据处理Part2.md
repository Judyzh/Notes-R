# $5 数据处理Part2

---

## 1. 数值和字符处理函数
* 数学函数：
    * `abs(x)` 绝对值
    * `sqrt(x)` 平方根
    * `ceiling(x)` 不小于x的最小整数
    * `floor(x)` 不大于x的最大整数
    * `trunc(x)` 向0方向截取x中整数部分 trunc(5.99) 返回5
    * `round(x, digits=n)` 四舍五入到指定小数位
    * `signif(x,digits=n)` 四舍五入到指定有效数字位数 
    * `cos(x)` `sin(x)` `tan(x)` 
    * `acos(x)` `asin(x)` `atan(x)` 
    * `cosh(x)` `sinh(x)` `tanh(x)` 双曲
    * `acosh(x)` `asinh(x)` `atanh(x)` 反双曲
    * `log(x, base=n)` `log(x)` `log10(x)` 
    * 可用于数值向量、矩阵、数据框，作用于每个独立值。

* 统计函数：
    * `mean(x)`
    * `median(x)`
    * `sd(x)` 标准差
    * `var(x)` 方差
    * `mad(x)`  绝对中位数
    * `quantile(x, probs)`  分位数
    * `range(x)` 值域
    * `sum(x)`
    * `diff(x, lag=n)`  滞后差分
    * `min(x)` `max(x)`
    * `scale(x, center=TRUE, scale=TRUE)` 为对象x按列进行中心化（center=TRUE）或标准化（center=TRUE, scale=TRUE）
* 数据标准化
    * 对矩阵或数据框进行均值=0，标准差=1的标准化 `newdata <- scale(mydata)`
    * 对指定列进行标准化 `newdata <- transform(mydata, myvar=scale(myvar)`
    * 任意均值和标准差的标准化 `newdata <- scale(mydata)*10+50 #均值=50，标准差=10的标准化` 
    * 非数值型的列上用scale会报错
    
* 概率函数：
    * `dnorm()` 密度函数
    * `pnorm()` 分布函数： 位于z=1.96左侧的标准正态曲线下面积 `pnorm(1.96)`
    * `qnorm()` 分位数函数: 均值=500，标准差=100的正态分布的0.9分位点值为 `qnorm(.9, mean=500, sd=100)`
    * `rnorm()` 随机函数: 生成50个均值=50，标准差=10的正态随机数 `rnorm(50, mean=50, sd=10)`
    * 生成随机数
        * `runif()` 生成0-1间服从均匀分布的伪随机数
        * `set.seed()` 指定种子，让每次生成的随机数都一样
        
* 字符处理函数：
    * `nchar(x)` 计算x的字符数量
    * `substr(x, start,stop)` 提取或替换子串
        * `x <- "abcdef" substr(x,2,4)  #bcd`
        * `x <- "abcdef" substr(x,2,4) <-"2222"  #a222ef`
    * `grep(pattern, x,ignore.case=FALSE, fixed=FALSE)` 在x中搜索某张模式，返回匹配的下标。 fixed=TRUE, pattern为字符串，fixed=FALSE, pattern为正则
        * `grep("A", c("b","A","c"), fixed=TRUE) #2`
    * `sub(pattern,replacement, x,ignore.case=FALSE, fixed=FALSE)` 在x中搜索pattern并以replacement代替
    * `strsplit(x, split, fixed=FALSE)` 在split处分割x中的元素
    * `paste(..., sep="")` 连接字符串
        * `paste("x",1:3,sep="M"  #"xM1","xM2","xM3")` 
    * `toupper(x)` 转大写
    * `tolower(x)` 转小写
* 其他函数：
    * `length(x)` x的长度
    * `seq(from, to, by)` 按步长by生成一个序列
    * `rep(x, n)` x重复n次
    * `cut(x, n)` 将连续变量x分割为有n个水平的因子
    * `pretty(x, n)` 通过选取n+1个等间距对的取整值，将一个连续变量x分割为n个区间。绘图中常用
    * `cat(..., file="myfile", append=FALSE)` 连接...中对象，并输出到文件或屏幕
* `apply(x, MARGIN, FUN, ...)` 将函数运用到矩阵、数值、数据框的任意维度上
    * MARGIN 维度下标， =1 行，=2 列
    * FUN 任意函数， ... 传递给FUN的参数
    * `apply(mydata, 2,mean, trim=0.2)` 对mydata按列算截尾均值 （取中间60%的数据，最高、最低20%被忽略）

## 2. 控制流
* 循环
    * 大数据集中，R中循环较低效费时
    * for `for(var in seq) statement` 
        * `for (i in 10) print("Hello World")` 
    * while `while (cond) statement`
```R
i <-10 
while (i >0 {print("Hello World"); i<- i-1 })
```
    
* 条件
    * if-else 
`if (cond) statement
if (cond) statement1 else statement2`
    * ifelse `ifelse(cond, statement1, statement2)`
    * switch `switch(expr, ...)` 
```
feelings <- c("sad","afraid")
for (i in feelings)
    print(
        switch(i, 
            happy= "1"
            afraid ="2"
            sad = "3"
        )
    )
```

## 3. 用户自定义函数
```
myfunction <- function(arg1, arg2, ...) {
    statements
    return(object)
}
```
* 函数中的对象只在函数内部使用

##4. 整合、重构
* 行列转置 `t(x)`
* 整合数据(group by) `aggregate(x, by, FUN)` 
```
aggregate(mtcars, by= list(cyl,gear), FUN=mean, na.rm=TRUE) # group by cyl and gear, 其他列取均值
```

* reshape包
    * 需安装
    * 融合 `melt(x, id= )` 转竖表 
    `md <- melt(mydata, id=(c("id","time")))`
    * 重铸 `cast(x, formula, FUN)`  formula: rowvar1+rowvar2...~ colvar1+colvar2...
    ```R
    cast(md, id+time ~ variable)
    cast(md, id+variable ~ time)
    cast(md, id~ variable, mean)
    ```
    

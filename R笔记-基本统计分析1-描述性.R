## 基本统计分析- 描述性统计分析

# 基础包方法
    vars <- c("mpg", "hp", "wt")
    summary(mtcars[vars]) # min, max, 1st Q, 3st Q, Median, Mean
    fivenum(mtcars$mpg) # min, 1st Q, Median, 3st Q, max
    
    sapply(mtcars[vars], sd) #sapply(x, FUN, option) 来计算所选择的任意统计量
    
    #自定义函数
    mystats <- function(x, na.omit=F) {
        if (na.omit) x<- x[!is.na(x)] #忽略缺失值
        m <- mean(x)
        n <- length(x)
        s <- sd(x)
        skew <- sum((x-m)^3/s^3)/n # 偏度
        kurt <- sum((x-m)^4/s^4)/n - 3 # 峰度
        return (c(n=n, mean=m, stdev=s, skew=skew, kurtosis=kurt))
    }
    sapply(mtcars[vars], mystats)
    sapply(mtcars[vars], mystats, na.omit=T) #忽略缺失


#扩展包
    # Hmisc中describe()
    # 返回观测的数量，缺失值，唯一值，mean, 分位数，5个最大最小值
    library(Hmisc)
    describe(mtcars[vars])
    
    # pastecs中stat.desc()
    # stat.desc(x, basic=T, desc=T, norm=F, p=0.95)
    # basic=T,返回所有值，空值，缺失值，最大最小值，值域，sum
    # desc=T, 返回median, mean, 平均数的标准误差，平均数95%的置信区间，
    # 方差，标准差，变异系数
    # norm=T, 返回正态分布统计量(峰度，偏度等)
    install.packages("pastecs")
    library(pastecs)
    stat.desc(mtcars[vars])
    stat.desc(mtcars[vars], norm=T)
    
    # psych中describe()
    # 返回非缺失值的数量,mean,sd,median, 截尾均值，绝对中位差，
    # min,max,range,偏度，峰度，平均值的标准误
    install.packages("psych")
    library(psych)
    describe(mtcars[vars])
    # 同名函数会优先调用最后载入的程序包，可如Hmisc::describe()来指定


# 分组计算描述性统计量
    aggregate(mtcars[vars], by=list(am=mtcars$am), mean)
    # 按am分组计算各变量的mean值
    aggregate(mtcars[vars], by=list(am=mtcars$am, cyl=mtcars$cyl), mean)
    # aggregate 只可调用单返回函数
    
    # by(data, INDICES, FUN)
    dstats <- function(x) (c(mean=mean(x), sd=sd(x))) #自定义个函数
    by(mtcars$wt, mtcars$am, dstats) #调用自定义函数（多返回）分组计算

    #扩展
        #doBy包中summaryBy()
        #summaryBy(formula, data=dataframe, FUN=function)
        #formula: var1+var2...+varN ~ groupvar1+groupvar2+...+groupvarN
        install.packages("doBy")
        library(doBy)
        summaryBy(mpg+hp+wt ~ am, data=mtcars, FUN=mystats)
        #按am分组，调用自定义函数mystats分别计算mpg,hp,wt的统计值
        
        #psych包describeBy()
        #分组计算和describe()函数相同的描述性统计值
        library(psych)
        describeBy(mtcars[vars], mtcars$am)
        describeBy(mtcars[vars], list(am=mtcars$am, cyl=mtcars$cyl))
        
        #reshape包
        install.packages("reshape")
        library(reshape)
        #自定义函数dstats
        dstats <- function(x)(c(n=length(x), mean=mean(x), sd=sd(x)))
        #融合：变量为mpg,hp,wt; 标示为am,cyl
        dfm <- melt(mtcars,measure.vars=c("mpg","hp","wt"),
                    id.vars=c("am","cyl"))
        #重铸：cast(data, formula, FUN) 
        #formula为想要的最后结果：rowvar ~ colvar
        cast(dfm, am+cyl+variable ~ ., dstats)
        

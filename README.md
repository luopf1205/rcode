---
title: useful R packages and functions
Author: pengfei luo. 
Update date: 4/30, 2021
---



[TOC]

# R

## Rstudio setting

### set working dictionary to source file location

```R
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()
```

### sset message language to English (recommended!!!)

locate language from JAPANESE to ENGLISH

```R
## set message language to English (recommended!!!!!!)
Sys.setenv(LANGUAGE="en")

## show all R local settings
Sys.getlocale()
## set all R local settings to English
Sys.setlocale("LC_ALL","English")

```



## packages

### gg-family (extension for ggplot)

`ggfortify`

`ggpubr`:publication ready plots

`ggsci`: SCI journals themes

 `ggthemes`

`ggannnotate`

`ggforce`: accelerating `ggplot2`

`cowplot`

`dygraphs`:The dygraphs package is an R interface to the [dygraphs](http://dygraphs.com/) JavaScript charting library. It provides rich facilities for charting time-series data in R

`corrplot`: correlations plot



### databases to get data

`quantmod`

`quandl`

`OECD`:OECD

`imfr`:IMF

`COVID19`: R interface to COVID-19 Data Hub



### article writing

`bibliometrix`: comprehensice science mapping analysis



### models

`broom`: convert statistical objects into tidy tibbles

`bruseR`:broadly useful covenient and efficient R functions

## sample datasets

- `ttrc`  : OHLC data, dataframe objects, daily

- `population`: Long format panel (single indicator)
- 





## 1. Plotting

### popular plotting packages

`cowplot` package

 - Plot grid for ggplot objects

 - simple vignettes

   https://cran.r-project.org/web/packages/cowplot/vignettes/introduction.html

- Full vignettes

  https://wilkelab.org/cowplot/articles/index.html

`ggfortify` package

- Extension to ggplot2 to handle some popular packages - R software and data visualization
- e.g. support plot multiple plots for xts objects

`ggtheme` package

 - 自动添加ggplot主题

```R
# using a stata style theme for plots
ggplot+theme_stata()

# usage is same as
ggplot+theme_bw()
```

`ggthemr` package

- 自动添加ggplot主题

https://github.com/Mikata-Project/ggthemr

```R

```

`esquisse` package

- add-in with UI

 - 免代码ggplot生成器, using ide to obtain ggplot code

`ggThemAssist`

- add-in with UI

- 界面调ggplot代码, using ide to obtain ggplot code

`plotly`

 - 交互界面图, generate interactive plots

 - ```R
   #generate ggplot object, then
   plotly(ggplot)
   ```

`tygraphs`

- plot mutiple time series

 - xts objects

`corrplot`

- correlation plot

- <https://cran.r-project.org/web/packages/corrplot/vignettes/corrplot-intro.html>

```R
# calculate correlation and save 
correlation <- cor(
  x=numeric vecror/matrix/data frame, na.rm= T or F,  use="everything","all.obs","complete.obs","na.or.complete","pairwise.complete.obs",
  method= "pearson"(default), "kendall", "spearman"
)

# plot correlation
corrplot(correlation)
```

`xtsExtra`

- `plot.xts()` for **xts** object

### multiple plots

- `matplot()`: base R

- ggplot
- for multiple columns **xts** object
  - load `ggfortify` package, then `autoplot()`
  - `plot.zoo()`
  - `ggExtra::plot.xts()`



### plots combination: ggplot objects

`ggpubr::ggarrange()`

```R
ggpubr::ggarrange(p1,p2,p3,p4
                ncol=2,nrow=2,
                labels="",label.x= , label.y= ,
                align=c("none", "h", "v", "hv"),
                common.legend=T)
```



`gridExtra::grid.arrange()`

``` R
 gridExtra::grid.arrange(p1,p2,p3,p4)
```



`cowplot::plot_grid()`

```R
cowplot::plot_grid(p1,p2,p3,p4,
                  align='h')
```



`patchwork()`

- <https://github.com/thomasp85/patchwork>

```R
# library(ggplot2)
# library(patchwork)

# generate ggplot objects
p1 <- ggplot(mtcars) + geom_point(aes(mpg, disp))
p2 <- ggplot(mtcars) + geom_boxplot(aes(gear, disp, group = gear))
p3 <- ggplot(mtcars) + geom_smooth(aes(disp, qsec))
p4 <- ggplot(mtcars) + geom_bar(aes(carb))

# combine plots
p1 + p2

# combine plots with latouts
# 3 plots in first row, 1 plot in second row 
(p1 | p2 | p3) /
      p4

# tagging plots
patchwork + plot_annotation(tag_levels = 'A')

# add title
patchwork + plot_annotation(title='XXX')
```

------

#### reorder facet

- Example 1: changing facor level

```R
# p:ggplot2 object
# data: dataframe object,including country, x, y
p+facet_grid(~.country)

reorder the country
p+facet_grid(~factor(country,levels=c('japan','china','korea')))
```

- example 2

```R
library(tidyverse)
# download data
quantmod::getSymbols(Symbols = 'GOOG')
goog=data.frame(index(GOOG),GOOG)
colnames(goog)=c('date','open','high','low','close','volumn','adj')

# convert to long data
goog1=goog %>% pivot_longer(-date,names_to = 'indicator',values_to = 'price')
head(goog1)

# plot
p <- goog1 %>% filter(indicator!='volumn' & indicator!='adj') %>% 
  ggplot(aes(x = date,y=price))+
  geom_line()+
  theme_bw()+
  facet_grid(~factor(indicator,levels = c('open','high','low','close'))) # reorder facet
```

### plots combination: basic R

- <https://www.statmethods.net/advgraphs/layout.html>
- `par()`
- `layout()`

Plot device set

```R
dev.new(width=7, height=5,units='cm')

options(device = "quartz")

plot(1:10,text_cex=2)
```

### plot multiple time series data: indexation by base date

https://blog.revolutionanalytics.com/2014/01/quantitative-finance-applications-in-r-plotting-xts-time-series.html



------

###　Japanese language themeset in ggplot（日本語）

- 用途：日本語をgglotに設定する

```R
library(ggplot2)
theme_set(theme_bw())

# 日本語
theme_set(theme_bw(base_family="HiraKakuProN-W3"))
theme_set(theme_bw(base_family="HiraKakuProN-W3"))
# infection by income group
p1 <- data_income %>% ggplot(aes(x=date,y=new_cases_smoothed_per_million,colour=location)) +geom_line()+
  labs(title = '感染者数（百万人当たり）',x = '',y='')+
  scale_color_discrete(name='所得別',labels=c('High income'='高所得国','Upper middle income'='中・高所得国','Lower middle income'='低・中所得国','Low income'='低所得国','World'='世界平均'))

# center title
ggplot +
  theme(plot.title = element_text(hjust = 0.5)) 
```

- example

![covid infections](https://i.loli.net/2021/12/02/8kirUj7dSTDCMvI.png)Changing Line Type for specified interval in time series (solid to dotted)

- Usage: 改变同时时间序列在某一时点前后的线的形状,例如: IMF World Economic Outlook, real GDP, 前:实线(solid),表示实现值《现在时点》后:点线(dotted),表示预测值

- https://stackoverflow.com/questions/42072942/changing-line-type-for-specified-interval-in-time-series-solid-to-dotted

- using `subset()`

- ```R
  data1 <- subset(data, int_year <= 2015)
  data2 <- subset(data, int_year >= 2015)
  ggplot(data1, aes(x = year, y = value, color = group)) +
    geom_point() + 
    geom_line() + 
    geom_point(data=data2, aes(x = year, y = value, color = group)) + 
    geom_line(data=data2, aes(x = year, y = value, color = group), lty=2) + 
    theme_bw()
  ```

- Example

  ![enter image description here](https://i.stack.imgur.com/kaZgU.png)

## 2. tidyverse

#### `dyplr`

 data wragling, including functions as follows:

- `mutate()`生成新变量

- `select()` picks variables based on their names.

- `filter()` picks cases based on their values.

- ```R
  country=c('China','Japan','Korea','Hong Kong','Brunei','Combodia','Indonesia','Laos','Malaysia','Myanmar','Philippines','Singapore','Thailand','Vietnam')
  data %>% filter(location %in% country) 
  ```

- `summarise()` reduces multiple values down to a single summary.

- `arrange()` changes the ordering of the rows.

These all combine naturally with `group_by()` which allows you to perform any operation “by group”. You can learn more about them in `vignette("dplyr")`. As well as these single-table verbs, dplyr also provides a variety of two-table verbs, which you can learn about in `vignette("two-table")`.

example:

- video 1: tidyr and dplyr

- <https://www.youtube.com/watch?v=jOd65mR1zfw&list=PL9HYL-VRX0oQOWAFoKHFQAsWAI3ImbNPk>

```R
library(tidyverse)
library(ggplot2)
diamonds
#tbl object is helpful for showing table like data frame
tbl_df(diamonds)

## the pipe operator %>% 
# function using pipe operator %>% 
diamonds$x %>% round(2) %>% mean()
# same result by basic function
d2 <- round(diamonds$x,2)
mean(d2)
# shorter code to beeasily understood


## what is data wrangling
same meanings with **wrangling, munging, janitor work, manipulation, transformation**
It will cost 50-80% of your time.


#video 2: wrangling
## two goals of data wrangling: 
1. make data suitable to use with a particular piece of software
2. reveal information

data sets come in many formats, but R prefers just one.

**EDAWR**: R package used here.
# devtools::install_github('rstudio/EDAWR')
# install.packages("EDAWR")
library(EDAWR)


deal with **storms**

storms
# calculation ratio=presure/wind
storms$pressure/storms$wind
## tidyr
tidy data
1. each variable is saved in its own column.
2. each observation is saved in its own row.
3. each "type" of observation stored in a single table(here, storms).

tidyr:
two main functions: 
gather()
spread()
library(tidyr)
cases
# tidy to form like country, year, n (turn: key,key, value)
gather(cases,"year","n",2:4)

pollution

your turn:
  imagine how the pollution data set would look tidy with three variables: city,large,small
spread(pollution,size,amount)
unite() and separate()
storms
separate(storms,date,c("year","month","day"),sep = "-")
unite(storms,"date",year,month,day,sep="-")
## recap:tidyr
-a package that reshapes the layout f data sets
-make observations from variables with gather()
-make variables from observations with spread()
-split and merge columns with unite() and separate()

#清空所有变量
rm(list=ls())
gc()

#video 3:dplyr
a package that helps transform tabular data
-select(): extract existing variables
-mutate(): extract existing observations
-filter(): derive new variables from existing variables
-summarise():change the unit of analyis
-arrange()
-group_by()

library(dplyr)
library(nycflights13)

## select()
extract existing variables
storms
select(storms, name,wind)
filter(storms,wind>50)
filter(storms,year %in% 1975:1978)
filter(storms,,wind>=25, year %in% 1975:1978)
```

  

####  `tidyr`

- https://tidyr.tidyverse.org/

- tidyr functions fall into five main categories:

- “Pivotting” which converts between long and wide forms. tidyr 1.0.0 introduces `pivot_longer()` and `pivot_wider()`, replacing the older `spread()` and `gather()` functions. See `vignette("pivot")` for more details.
- “Rectangling”, which turns deeply nested lists (as from JSON) into tidy tibbles. See `unnest_longer()`, `unnest_wider()`, `hoist()`, and `vignette("rectangle")` for more details.
- Nesting converts grouped data to a form where each group becomes a single row containing a nested data frame, and unnesting does the opposite. See `nest()`, `unnest()`, and `vignette("nest")` for more details.
- Splitting and combining character columns. Use `separate()` and `extract()` to pull a single character column into multiple columns; use `unite()` to combine multiple columns into a single character column.
- Make implicit missing values explicit with `complete()`; make explicit missing values implicit with `drop_na()`; replace missing values with next/previous value with `fill()`, or a known value with `replace_na()`.

functions in `tidyr`package

(1) reshape data

- `pivot_longer`

- `pivot_wider`

(2) handle missing value

- `drop_na` drop rows containing GAs in column
- `fill()` fill in NAs in columns with most recent non-NA values
- `replace_na()` replace NAs by column

(3) Split cells

-   `separate()` seperate eacha cell in a column to make several columns

-   `seperate_rows` seperate each cell in a column to make several rows

-   `unite()` collapse cells across several columns to make a single column

####  `lubridate`

 - 处理时间

####  `reshape2`

 -	变形,整合
 -	out of date, replaced by `tidyr` package

####  `stringr`

 -	处理字符串

#### `lubridate`

处理时间

#### `reshape2`

out of date, replaced by `tidyr` package

#### `stringr`

处理字符串



------

### some functions using tidyverse

#### convert all factor columns to character in a data.frame without affecting non-factor columns

https://stackoverflow.com/questions/47633241/convert-all-factor-columns-to-character-in-a-data-frame-without-affecting-non-fa/47633303

```R
# library(tidyverse)
df <- data.frame(a = 1:5, b = factor(c("a", "b", "c", "d", "e")), c = factor(c("f", "g", "h", "i", "j")))
df %>% glimpse() 

# Observations: 5
# Variables: 3
# $ a <int> 1, 2, 3, 4, 5
# $ b <fctr> a, b, c, d, e
# $ c <fctr> f, g, h, i, j

df %>% mutate_if(is.factor, as.character) %>% glimpse()
# Observations: 5
# Variables: 3
# $ a <int> 1, 2, 3, 4, 5
# $ b <chr> "a", "b", "c", "d", "e"
# $ c <chr> "f", "g", "h", "i", "j"
```



## 3. data.table (unfinished)

need to finish

another object for tabular data

------



## 4. data frame

#### Divide all columns by the value from the 2nd column - apply for all rows

```R
tbl_data[, -(1:2)] <- sweep(tbl_data[, -(1:2)], 1, tbl_data[, 2], "/")
```

####  Join/merge multiple data.frames

- using `merge()` and pipe operator

- using `join()` function in dyplr package and pipe operator

- using function

  - https://gist.github.com/yuu-ito/7094938 

  - Rのmerge関数で3つ以上のデータフレームを結合したかったので。 ググって見つけたものをまとめておく。

  - ```R
    merge2 <- function(dfs, ...)
    {
    　 # res <- merge2(list(Df1, Df2, Df3), by="ID")
    　 base <- dfs[1]
    　 lapply(dfs[-1], function(i) base <<- merge(base, i, ...)) # [1]
      return(base)
    }
    ```

#### merge multiple data.frames and add a row of data.frame names

- Usage: combine country data to a panel data

- https://stackoverflow.com/questions/15162197/combine-rbind-data-frames-and-create-column-with-name-of-original-data-frames

- ```r
  > library(gdata)
  > gdata::combine(df1, df2)
    x y source
  1 1 2    df1
  2 3 4    df1
  3 5 6    df2
  4 7 8    df2
  ```

------

## 5. pipe operator (migrittr package)

- %>%

forward pipe operator

```R
# without pipe
lm(Sepal.Length ~ Sepal.Width, data=iris)
# with pipe (第一个参数不能放入iris, 报错)
iris %>% lm(Sepal.Length ~ Sepal.Width)
# with pipe (准确告知iris应该放入哪个参数,不报错)
iris %>% lm(Sepal.Length ~ Sepal.Width, data=.)
```

- %$%

exposition pipe-operator

准确告知上一段的运行结果放入下一个函式的data参数中

```R
iris %$% lm(Sepal.Length ~ Sepal.Width)
```

- %T>%

tee operarator

主要作用: 通过pipe生成数据集, 返回新的数据集,并画图or统计分析(mean, etc.), 不为画图或统计分析生成新的变量

```R
# without pipe
set.seed(1)
test<- rnorm(200) %>% matrix(ncol=2)
plot(test)
colSums(test)

# with pipe (通过%T>%分别将test传入plot()和colSums())
set.seed(1)
test<- rnorm(200) %>% matrix(ncol=2)

test %T>% 
     plot() %>%
     colSums()
```

- %<>%

compound assignment pipe-operator

将右边执行完的结果传入左边

```R
# without pipe
iris <- iris %>% filter(Species == "virginica") %>% arrange(Sepal.Length)

# with pipe
iris %<>%  filter(Species == "virginica") %>% arrange(Sepal.Length)
```



## 6. time series

`ts` objects

- Time Series in R: Quick Reference

- https://rstudio-pubs-static.s3.amazonaws.com/404513_6cb313f3258b4c98a5c5948e93ad6c20.html#fn1

`xts` package

`quantmod`  package

`MTS` package

- diffM() function: take difference  of multivariate time series in one XTS

### Covert  time series frequency

- method 1: using basic R
  - Converting a Daily, Weekly, or Monthly Series to Quarterly in R, https://www.youtube.com/watch?v=9v8n9oZTo7w

```R
library(dplyr)
library(lubridate)
# data include daily date and value
data<- read_csv('path') #import data from csv

data$Date=as.Date(data$Date, format='%m/%d/%y') 
data<- arrange(data, Date) # arrange value by Date in data
data$qdate<- as.yearqtr(data$Date) # generate quarterly date 
data_qtrly <- data %>% 
              group_by(qdate)%>%
						summarise_all(mean)  # convert daily to quarterly data

write.csv(data_qtrly, "path")

```

- method 2: using lubridate::floor_date()

```R
### example 1: time series 
library(dplyr)
library(lubridate)
# data include daily date and value
data<- read_csv('path') #import data from csv

# 
df %>% 
  mutate(week = month(ymd(date))) %>% 
  group_by(month)%>%
	summarise_all(mean)
# in lubridate package: month(),quarter(),year(),....

### example 2: panel data
# x is a panel data (country, day), convert to monthly sum or mean
x$month <- floor_date(x$date,'month')
x$administrative_area_level_1 <- as.factor(x$administrative_area_level_1)
y <- x %>% group_by(administrative_area_level_1,month) %>% 
  summarise(across(c(confirmed,people_fully_vaccinated),sum))
```



### calculate returns and log returns

```R
library(tidyverse)

# group1
date=seq(as.Date("2000/1/1"), by='month', length.out=15)
y=c(1,2,3,4,5,1,2,3,4,5,1,2,3,4,5)
data1 <- data.frame(date,y) %>% mutate(id='a')
data1

# group2
date=seq(as.Date("2000/1/1"), by='month', length.out=15)
y=c(15,20,25,45,55,15,20,25,45,55,15,20,25,45,55)
data2 <- data.frame(date,y) %>% mutate(id='b')
data2

# combine all data groups
data <- merge(data1,data2,all=TRUE)

## 1. for one group (data.frame)
## 1st difference (first value: NA)
data1%>%mutate(dy=y-lag(y))

## return (first value: NA)
data1 %>% mutate(dy=(y-lag(y))/lag(y))
# return in percentage (first value: NA)
data1 %>% mutate(dy=(y-lag(y))/lag(y)*100)
or 
data1 %>% mutate(dy=(y/lag(y))*100-100)

## log returns for one group
data1 %>% mutate(dy=log(y)-lag(log(y)))
data1 %>% mutate(dy=(log(y)-lag(log(y))*100)) # in percentage
data1 %>% mutate(dy=(
  100*log(y)-100*lag(log(y))
))


## calculate returns/log returns for one group in panel data
data %>% group_by(id) %>% mutate(dy=y-lag(y))
## calculate returns/log returns for one group

```

------



## XTS(need add)

remove NA values: `na.omit`





## database packages

### quantmod package(with XTS)

Get and merge closing data from quantmod

```R
# method 1
library(quantmod)
e<-new.env()
tickers<-c("GE","BMW.DE","NOVO-B.CO","1COV.DE")
getSymbols("^GSPC",from="2018-01-01")
getSymbols(tickers,from="2019-01-01",env=e)

merged_prices <- do.call(merge, lapply(e, Ad))
merged_prices

## plot multiple timeseries
library(tidyverse)
library(ggfortify)
autoplot(merged_prices,facets = FALSE)


# method 2
symbol <- c('JPY=X','CNY=X','IDR=X','THB=X','MYR=X','PHP=X')
start_date <- as.Date('2000-01-01')
end_date <- as.Date('2021-11-30')
data.env <- new.env()
getSymbols(Symbols = symbol,from=start_date,to=end_date,
           env = data.env,periodicity='daily')
EX_Adj_Data <- do.call(merge, eapply(data.env, Ad))
```

### 複数の指標を指数化（同じ日付をベース＝100にする）：Divide each row of an XTS or ZOO time series object by a fixed row (a value on a Date)

```R
<<<<<<< Updated upstream
# wrong method
data <- merged_prices/drop(coredata(merged_prices['2020-01-06']))*100 
autoplot(data)

# method available

=======
＃method wrong

data <- merged_prices/drop(coredata(merged_prices['2020-01-06']))*100 
autoplot(data)


# method available: dataframe and mapply()
date=seq.Date(as.Date('2000-01-01'),by='day',length.out = 5)
a=1:5
b=11:15
c=21:25
>>>>>>> Stashed changes
dat=data.frame(date,a,b,c)
dat

dat1=data.frame(mapply('/', dat[,-1],dat[2,-1]))
dat1
dat2 <- cbind(dat$date,dat1*100)
dat2

dat.xts <- xts(dat2[,-1],order.by = dat2$`dat$date`)
library(tidyverse)
library(ggfortify)
autoplot(dat.xts)
<<<<<<< Updated upstream
=======



>>>>>>> Stashed changes
```







### OECD data

- https://rpubs.com/keisato/OECD

### IMF data



## 7. Econometrics package

`MASS` package

- 经典的统计方法

`forecast` package

- ??? to be finished



## 8.  unit root test

https://elsur.jpn.org/mt/2020/02/002830.html

`tseries` package

時系列分析パッケージの古手だと思う。ADF検定, KPSS検定, PP検定の関数を持っている。

- `add.test() `ADF test
- `kpss.test()` KPSS test
- `pp.test() `PP test



`urca` package

　単位根検定のためのパッケージとして最も有名なのはこれだと思う。

- `ur.df(y, type, lags, selectlags)` ADF 
- `ur.kpss(y, type, lags, selectlags)` KPSS
- `ur.pp(y, type, lags, selectlags)` PP test



### unit root test for all columns in dataframe

```R
# data
dat <- Canada

# dat is data.frame
MY_LIST=apply(dat,2,function(x){
  return(
    list(
      ur.df(x, type = "none",selectlags = "BIC"),
      ur.pp(x, type = "Z-tau",model = 'constant',lags='short'),
      ur.kpss(x, type = "tau",lags = 'short')
    )
  )
})
```





### explanations function for `ur.df`

- https://www.r-bloggers.com/2021/12/easy-interpretations-of-adf-test-in-r/

- Function:

- ```R
  ############################################################################
  # This R function helps to interpret the output of the urca::ur.df function.
  # The rules are based on https://stats.stackexchange.com/questions/
  # 24072/interpreting-rs-ur-df-dickey-fuller-unit-root-test-results
  #
  # urdf is the output of the urca::ur.df function
  # level is one of c(“1pct”, “5pct”, “10pct”)
  #
  # Author: Hank Roark
  # Date: October 2019
  ############################################################################
  interp_urdf <– function(urdf, level=“5pct”) {
    
    # urdf = lt.adf.df.trend$LRY
    # level = “5pct”
    
    if(class(urdf) != “ur.df”) 
      stop(‘parameter is not of class ur.df from urca package’)
    if(!(level %in% c(“1pct”, “5pct”, “10pct”) ) ) 
      stop(‘parameter level is not one of 1pct, 5pct, or 10pct’)
    #cat(“========================================================================\n”)
    cat( paste(“At the”, level, “level:\n”) )
    if(urdf@model == “none”) {
      cat(“The model is of type none : “); print(urdf@testreg$call$formula)
      tau1_crit = urdf@cval[“tau1”,level]
      tau1_teststat = urdf@teststat[“statistic”,“tau1”]
      tau1_teststat_wi_crit = tau1_teststat > tau1_crit
      if(tau1_teststat_wi_crit) {
        cat(“tau1: The null hypothesis is not rejected, unit root is present\n”)
      } else {
        cat(“tau1: The null hypothesis is rejected, unit root is not present\n”)
      }
    } else if(urdf@model == “drift”) {
      #cat(“The model is of type drift\n”)
      cat(“The model is of type drift : “); print(urdf@testreg$call$formula)
      tau2_crit = urdf@cval[“tau2”,level]
      tau2_teststat = urdf@teststat[“statistic”,“tau2”]
      tau2_teststat_wi_crit = tau2_teststat > tau2_crit
      phi1_crit = urdf@cval[“phi1”,level]
      phi1_teststat = urdf@teststat[“statistic”,“phi1”]
      phi1_teststat_wi_crit = phi1_teststat < phi1_crit
      if(tau2_teststat_wi_crit) {
        # Unit root present branch
        cat(“tau2: The first null hypothesis is not rejected, unit root is present\n”)
        if(phi1_teststat_wi_crit) {
          cat(“phi1: The second null hypothesis is not rejected, unit root is present\n”)
          cat(”      and there is no drift.\n”)
        } else {
          cat(“phi1: The second null hypothesis is rejected, unit root is present\n”)
          cat(”      and there is drift.\n”)
        }
      } else {
        # Unit root not present branch
        cat(“tau2: The first null hypothesis is rejected, unit root is not present\n”)
        if(phi1_teststat_wi_crit) {
          cat(“phi1: The second null hypothesis is not rejected, unit root is present\n”)
          cat(”      and there is no drift.\n”)
          warning(“This is inconsistent with the first null hypothesis.”)
        } else {
          cat(“phi1: The second null hypothesis is rejected, unit root is not present\n”)
          cat(”      and there is drift.\n”)
        }
      }
    } else if(urdf@model == “trend”) {
      #cat(“The model is of type trend\n”)
      cat(“The model is of type trend : “); print(urdf@testreg$call$formula)
      tau3_crit = urdf@cval[“tau3”,level]
      tau3_teststat = urdf@teststat[“statistic”,“tau3”]
      tau3_teststat_wi_crit = tau3_teststat > tau3_crit
      phi2_crit = urdf@cval[“phi2”,level]
      phi2_teststat = urdf@teststat[“statistic”,“phi2”]
      phi2_teststat_wi_crit = phi2_teststat < phi2_crit
      phi3_crit = urdf@cval[“phi3”,level]
      phi3_teststat = urdf@teststat[“statistic”,“phi3”]
      phi3_teststat_wi_crit = phi3_teststat < phi3_crit
      if(tau3_teststat_wi_crit) {
        # First null hypothesis is not rejected, Unit root present branch
        cat(“tau3: The first null hypothesis is not rejected, unit root is present\n”)
        if(phi3_teststat_wi_crit) {
          # Second null hypothesis is not rejected
          cat(“phi3: The second null hypothesis is not rejected, unit root is present\n”)
          cat(”      and there is no trend\n”)
          if(phi2_teststat_wi_crit) {
            # Third null hypothesis is not rejected
            # a0-drift = gamma = a2-trend = 0
            cat(“phi2: The third null hypothesis is not rejected, unit root is present\n”)
            cat(”      there is no trend, and there is no drift\n”)
          } else {
            # Third null hypothesis is rejected
            cat(“phi2: The third null hypothesis is rejected, unit root is present\n”)
            cat(”      there is no trend, and there is drift\n”)
          }
        }
        else {
          # Second null hypothesis is rejected
          cat(“phi3: The second null hypothesis is rejected, unit root is present\n”)
          cat(”      and there is trend\n”)
          if(phi2_teststat_wi_crit) {
            # Third null hypothesis is not rejected
            # a0-drift = gamma = a2-trend = 0
            cat(“phi2: The third null hypothesis is not rejected, unit root is present\n”)
            cat(”      there is no trend, and there is no drift\n”)
            warning(“This is inconsistent with the second null hypothesis.”)
          } else {
            # Third null hypothesis is rejected
            cat(“phi2: The third null hypothesis is rejected, unit root is present\n”)
            cat(”      there is trend, and there may or may not be drift\n”)
            warning(“Presence of drift is inconclusive.”)
          }
        }
      } else {
        # First null hypothesis is rejected, Unit root not present branch
        cat(“tau3: The first null hypothesis is rejected, unit root is not present\n”)
        if(phi3_teststat_wi_crit) {
          cat(“phi3: The second null hypothesis is not rejected, unit root is present\n”)
          cat(”      and there is no trend\n”)
          warning(“This is inconsistent with the first null hypothesis.”)
          if(phi2_teststat_wi_crit) {
            # Third null hypothesis is not rejected
            # a0-drift = gamma = a2-trend = 0
            cat(“phi2: The third null hypothesis is not rejected, unit root is present\n”)
            cat(”      there is no trend, and there is no drift\n”)
            warning(“This is inconsistent with the first null hypothesis.”)
          } else {
            # Third null hypothesis is rejected
            cat(“phi2: The third null hypothesis is rejected, unit root is not present\n”)
            cat(”      there is no trend, and there is drift\n”)
          }
        } else {
          cat(“phi3: The second null hypothesis is rejected, unit root is not present\n”)
          cat(”      and there may or may not be trend\n”)
          warning(“Presence of trend is inconclusive.”)
          if(phi2_teststat_wi_crit) {
            # Third null hypothesis is not rejected
            # a0-drift = gamma = a2-trend = 0
            cat(“phi2: The third null hypothesis is not rejected, unit root is present\n”)
            cat(”      there is no trend, and there is no drift\n”)
            warning(“This is inconsistent with the first and second null hypothesis.”)
          } else {
            # Third null hypothesis is rejected
            cat(“phi2: The third null hypothesis is rejected, unit root is not present\n”)
            cat(”      there may or may not be trend, and there may or may not be drift\n”)
            warning(“Presence of trend and drift is inconclusive.”)
          }
        }
      }
    } else warning(‘urdf model type is not one of none, drift, or trend’)
    cat(“========================================================================\n”)
  }
  
  
  #######
  #R code example
  #######
  #In the following R code, we perform ADF test for denmark time series by using ur.df() function and apply Hank Roark’s R function to these results.
  
  #========================================================#
  # Quantitative ALM, Financial Econometrics & Derivatives 
  # ML/DL using R, Python, Tensorflow by Sang-Heon Lee 
  #
  # https://kiandlee.blogspot.com
  #——————————————————–#
  # Augmented Dickey-Fuller (ADF) Test with
  # easy interpretations using Hank Roark R function
  #========================================================#
   
  graphics.off()  # clear all graphs
  rm(list = ls()) # remove all files from your workspace
   
  library(urca)  # ur.df
   
  interp_urdf <– function(urdf, level=“5pct”) {
      # body of Hank Roark R function
  }
   
  #========================================================
  # Data
  #========================================================
   
  data(denmark)
   
  # lv data
  lv <– denmark[,c(“LRM”,“LRY”,“IBO”,“IDE”)]
  nr_lv <– nrow(lv)
   
  # 1st differenced data
  df <– as.data.frame(diff(as.matrix(lv), lag = 1))
  colnames(df) <– c(“LRM”, “LRY”, “IBO”, “IDE”)
   
  #========================================================
  # ADF test of level variables
  #========================================================
   
  # Level
  adf.lv.n.LRY = ur.df(lv$LRY, type=‘none’ , selectlags = c(“BIC”))
  adf.lv.d.LRY = ur.df(lv$LRY, type=‘drift’, selectlags = c(“BIC”))
  adf.lv.t.LRY = ur.df(lv$LRY, type=‘trend’, selectlags = c(“BIC”))
   
  # 1st difference
  adf.df.n.LRY = ur.df(df$LRY, type=‘none’ , selectlags = c(“BIC”))
  adf.df.d.LRY = ur.df(df$LRY, type=‘drift’, selectlags = c(“BIC”))
  adf.df.t.LRY = ur.df(df$LRY, type=‘trend’, selectlags = c(“BIC”))
   
  #========================================================
  # Automatic Interpretation by using Hank Roark procedure
  #========================================================
   
  # Level
      interp_urdf(adf.lv.n.LRY, “5pct”)
      interp_urdf(adf.lv.d.LRY, “5pct”)
      interp_urdf(adf.lv.t.LRY, “5pct”)
      
  # 1st difference
      interp_urdf(adf.df.n.LRY, “5pct”)
      interp_urdf(adf.df.d.LRY, “5pct”)
      interp_urdf(adf.df.t.LRY, “5pct”)
  ```

  

`forecast` package

泣く子も黙る(?) 有名パッケージ。中の人Hyndman先生は、ただいまこのパッケージのtidyverse対応版であるfableパッケージを鋭意ご製作中らしいのだが、単位根検定関係はまだ移植していない模様。

------



## 9. VAR model

### Packages for VAR model

`vars` package

VAR model, SVAR model

`VARsignR` package

- Uhlig's (2005) sign restricted VAR model
- to be finished

`pacman` package

- panel VAR model
- Example:  https://rpubs.com/lijunjie/pvar

### IRF from exogenous shock to endogenous variables

`MTS` package `VARirf` function: generate IRFs for exogenous variables



### PERFECT WAY TO PLOT MULTIPLE IRFS !!!!

```R
{r}
rm(list = ls())
library(tidyverse)
library(magrittr)
library(vars)

extract_varirf <- function(...){
    
    varirf_object <- list(...) #list one or more varirf input objects
    
    get_vec_length <- function(list_item){nrow(list_item[[1]][[1]])}
    
    if (!("varirf" %in% mapply(class, varirf_object))){
        stop("this function only accepts 'varirf' class objects")
    }
    
    if (length(unique(mapply(class, varirf_object)))!=1){
        stop("all input items must be 'varirf' class objects")
    }    
    if (length(unique(mapply(get_vec_length, varirf_object)))!=1){
        stop("all irf vectors must have the same length")   
    }  
    
    period <- as.data.frame(0:(nrow(varirf_object[[1]][[1]][[1]])-1)) 
    names(period) <- "period"
    
    for (l in 1:length(varirf_object)){
        for (i in 1:3){
            for (j in 1:dim(varirf_object[[l]][[i]][[1]])[2]){
                for (k in 1:length(varirf_object[[l]][[1]])){
                    temp_colname <- paste(names(varirf_object[[l]][i]), #vector type (irf, lower, or upper)
                                          names(varirf_object[[l]][[i]])[k], #impulse name
                                          colnames(varirf_object[[l]][[i]][[k]])[j], #response name
                                          sep = "_")
                    
                    temp <- as.data.frame(varirf_object[[l]][[i]][[k]][, j]) #extracts the vector
                    
                    names(temp) <- temp_colname #add the column name (vectortype_impulse_reponse)
                    period <- cbind(period, temp) 
                }
                
            }
        }
    }
    names(period) <- tolower(names(period))
    return(period)
}

##BEGIN!!!
#VAR
data("Canada")
varmodel <- VAR(y = Canada,type = 'const',lag.max = 4,ic='AIC' )
## full irf
varirf <- irf(varmodel,n.ahead = 12)

# tidy irf object
irfdata <- extract_varirf(varirf)
cleanirf <- irfdata %>% pivot_longer(!period,names_to = 'index',values_to = 'value') %>% separate(col = 'index',into = c('list','impulse','response')) %>% pivot_wider(names_from = list,values_from = value)

#or
cleanirf <- extract_varirf(varirf) %>% pivot_longer(!period,names_to = 'index',values_to = 'value') %>% separate(col = 'index',into = c('list','impulse','response')) %>% pivot_wider(names_from = list,values_from = value)

## plot by clean data
theme_set(theme_bw())
ggplot(data = cleanirf)+
  geom_line(aes(x=period,y=irf))+
  geom_ribbon(aes(x=period,ymin=lower,ymax=upper),fill='orange',alpha=0.3)+
  geom_hline(yintercept=0,linetype='dotted')+
  facet_grid(vars(impulse),vars(response))+
  labs(title =  'shocks',x='period',y='responses')+
  theme(plot.title = element_text(hjust = 0.5))

## reorder impulse and response in factors to show the plots by variable ordering
cleanirf$impulse <- factor(cleanirf$impulse,levels = c('prod','e','u','rw'))
cleanirf$response <- factor(cleanirf$response,levels = c('prod','e','u','rw'))

ggplot(data = cleanirf)+
  geom_line(aes(x=period,y=irf))+
  geom_ribbon(aes(x=period,ymin=lower,ymax=upper),fill='orange',alpha=0.3)+
  geom_hline(yintercept=0,linetype='dotted')+
  facet_grid(vars(impulse),vars(response))+
  labs(title =  'shocks',x='period',y='responses')+
  theme(plot.title = element_text(hjust = 0.5))
```

<img src="C:\Users\luope\Desktop\00003a (1).png" alt="00003a (1)" style="zoom:150%;" />







### varIRF function

https://rstudio-pubs-static.s3.amazonaws.com/270271_9fbb9b0f8f0c41e6b7e06b0dc2b13b62.html

- Usage

```R
# irf
myIRF.c <- irf(mySVAR, n.ahead = 12, ci = .9, cumulative = TRUE)

# plot all IRF

source("C:/Users/rmerrima/Dropbox/Spring 2017/ECO 5316 - Time Series Econometrics/Homework 6/plotIRF.R")
par(mar=c(2,2,1,1),mfcol=c(4,4),cex=0.5)
plotIRF(myIRF.c, lwd=2.5, ask=FALSE)


### adjust 
plotIRF(result_irf,lty = c(1,1,2,2),lwd = c(2,1,1,1),col=c(1,2,4,4))
```

- function code

```R
plotIRF <-
  function (x, vnames = NULL, snames = NULL, vlabels = NULL, slabels = NULL,
            main = NULL, sub = NULL, lty = NULL, lwd = NULL, col = NULL, ylim = NULL,
            ylab = NULL, xlab = NULL, nc, mar.multi = c(0, 4, 0, 4),
            oma.multi = c(6, 4, 6, 4), adj.mtext = NA, padj.mtext = NA, col.mtext = NA, ...)
  {
    # op <- par(no.readonly = TRUE)
    # on.exit(par(op))
    ##
    ## Check arguments
    ##
    inames <- x$impulse
    if (is.null(snames)) {
      snames <- inames
    }
    else {
      snames <- as.character(snames)
      if (!(all(snames %in% inames))) { stop("\nInvalid shock name(s) supplied.\n") }
      else { inames <- snames }
    }
    nvi <- length(inames)
    rnames <- x$response
    if (is.null(vnames)) {
      vnames <- rnames
    }
    else {
      vnames <- as.character(vnames)
      if (!(all(vnames %in% rnames))) { stop("\nInvalid variable name(s) supplied.\n") }
      else { rnames <- vnames }
    }
    nvr <- length(rnames)
    if (is.null(slabels)) {
      slabels <- snames
    }
    else {
      if (!(length(slabels) == length(snames))) { 
        stop("\nNUmber of labels for shocks in slabels does not math number of shocks in snames.\n") }
    }
    if (is.null(vlabels)) {
      vlabels <- vnames
    }
    else {
      if (!(length(slabels) == length(snames))) { 
        stop("\nNUmber of labels for shocks in slabels does not math number of shocks in snames.\n") }
    }
    
    ##
    ## Presetting certain plot-argument
    ##
    ifelse(is.null(lty), lty <- c(1, 1, 2, 2), lty <- rep(lty, 4)[1:4])
    ifelse(is.null(lwd), lwd <- c(1, 1, 1, 1), lwd <- rep(lwd, 4)[1:4])
    ifelse(is.null(col), col <- c("black", "gray", "red", "red"), col <- rep(col, 4)[1:4])
    
    ##
    ## Extract data for variable rname from varirf object
    ##
    dataplot.r <- function(x, rname){
      impulses <- NULL
      for(j in 1:length(x$irf)){
        impulses <- cbind(impulses, x$irf[[j]][,rname])
        colnames(impulses)[j] <- names(x$irf)[j]
      }
      range <- range(impulses)
      upper <- NULL
      lower <- NULL
      if(x$boot){
        for(j in 1:length(x$irf)){
          upper <- cbind(upper, x$Upper[[j]][,rname])
          lower <- cbind(lower, x$Lower[[j]][,rname])
          colnames(upper)[j] <- names(x$irf)[j]
          colnames(lower)[j] <- names(x$irf)[j]
        }
        range <- range(cbind(impulses, upper, lower))
      }
      if ((x$model == "varest") || (x$model == "vec2var")) {
        text1 <- "Impulse Response"
      } else if (x$model == "svarest") {
        text1 <- "SVAR Impulse Response"
      } else if (x$model == "svecest") {
        text1 <- "SVECM Impulse Response"
      }
      if (x$cumulative)  text1 <- paste("Cumulative", text1, sep = " ")
      text2 <- ""
      if (x$boot) text2 <- paste((1 - x$ci) * 100, "% Bootstrap CI, ", x$runs, "runs")
      
      result <- list(impulses = impulses, upper = upper, 
                     lower = lower, range = range, 
                     text1 = text1, text2 = text2)
      return(result)
    }
    ##
    ## Plot function for irf per impulse and response
    ##
    plot.single <- function(x, iname, rname, ylabel, slabel,...) {
      x$text1 <- paste(slabel,'->', ylabel)
      ifelse(is.null(main), main <- x$text1, main <- main)
      ifelse(is.null(sub), sub <- '', sub <- '')
      xy <- xy.coords(x$impulses[, iname])
      ifelse(is.null(xlab), xlabel <- "", xlabel <- xlab)
      ifelse(is.null(ylim), ylim <- x$range, ylim <- ylim)
      plot(xy, type = "l", ylim = ylim, 
           col = col[1], lty = lty[1], 
           lwd = lwd[1], axes = FALSE, 
           ylab = '', xlab = '', ...)
      title(main = main, sub = sub, ...)
      axis(1, at = xy$x, labels = c(0:(length(xy$x) - 1)))
      axis(2, ...)
      box()
      if (!is.null(x$upper)) lines(x$upper[, iname], col = col[3], lty = lty[3], lwd = lwd[3])
      if (!is.null(x$lower)) lines(x$lower[, iname], col = col[3], lty = lty[3], lwd = lwd[3])
      abline(h = 0, col = col[2], lty = lty[2], lwd = lwd[2])
    }
    ##
    ## Plot IRFs
    ##
    for(i in 1:nvr){
      dp.r <- dataplot.r(x, rname = rnames[i])
      for(j in 1:nvi){
        plot.single(dp.r, iname = inames[j], rname = rnames[i], 
                    ylabel = vlabels[i], slabel = slabels[j], ...)
        # if (nvr > 1) par(ask = TRUE)
      }
    }
  }

```



### nice plot for irf

```R
# load package
library(vars)
library(ResearchGroupTools)
library(tidyverse)

# load data----
data("Canada")
summary(Canada)
plot(Canada,nc=2,xlab="")
#tip: canada is a mts/ts object

VARselect(Canada, lag.max = 8, type = "both")
Canada <- Canada[, c("prod", "e", "U", "rw")]
#tip: object class: mts/ts/matrix
VAR1 <- VAR(Canada, p = 1, type = "both")

# draw IRF plots as ggplot objects and combine
p1 <- VAR1 %>%  impulseResponsePlot(impulse = "prod", response = "prod", n.ahead = 20)+
  labs(title = "prod -> prod",x='',y='')
p2 <- VAR1 %>%  impulseResponsePlot(impulse = "e", response = "prod", n.ahead = 20)+
  labs(title = "e -> prod",x='',y='')
p3 <- VAR1 %>%  impulseResponsePlot(impulse = "rw", response = "prod", n.ahead = 20)+
  labs(title = "rw -> prod",x='',y='')
p4 <- VAR1 %>%  impulseResponsePlot(impulse = "e", response = "prod", n.ahead = 20)+
  labs(title = "e -> prod",x='',y='')
p5 <- VAR1 %>%  impulseResponsePlot(impulse = "prod", response = "e", n.ahead = 20)+
  labs(title = "prod -> e",x='',y='')
p6 <- VAR1 %>%  impulseResponsePlot(impulse = "e", response = "e", n.ahead = 20)+
  labs(title = "e -> e",x='',y='')
p7 <- VAR1 %>%  impulseResponsePlot(impulse = "U", response = "e", n.ahead = 20)+
  labs(title = "U -> e",x='',y='')
p8 <- VAR1 %>%  impulseResponsePlot(impulse = "rw", response = "e", n.ahead = 20)+
  labs(title = "rw -> e",x='',y='')
p9 <- VAR1 %>%  impulseResponsePlot(impulse = "prod", response = "U", n.ahead = 20)+
  labs(title = "prod -> U",x='',y='')
p10 <- VAR1 %>%  impulseResponsePlot(impulse = "e", response = "U", n.ahead = 20)+
  labs(title = "e -> U",x='',y='')
p11 <- VAR1 %>%  impulseResponsePlot(impulse = "U", response = "U", n.ahead = 20)+
  labs(title = "U -> U",x='',y='')
p12 <- VAR1 %>%  impulseResponsePlot(impulse = "rw", response = "U", n.ahead = 20)+
  labs(title = "rw -> U",x='',y='')
p13 <- VAR1 %>%  impulseResponsePlot(impulse = "prod", response = "rw", n.ahead = 20)+
  labs(title = "prod -> rw",x='',y='')
p14 <- VAR1 %>%  impulseResponsePlot(impulse = "e", response = "rw", n.ahead = 20)+
  labs(title = "e -> rw",x='',y='')
p15 <- VAR1 %>%  impulseResponsePlot(impulse = "U", response = "rw", n.ahead = 20)+
  labs(title = "U -> rw",x='',y='')
p16 <- VAR1 %>%  impulseResponsePlot(impulse = "rw", response = "rw", n.ahead = 20)+
  labs(title = "rw -> rw",x='',y='')

# combine plots 4 x 4
gridExtra::grid.arrange(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16)
```

![plot_zoom_png](https://s2.loli.net/2021/12/28/29lidyPgc5rNQq6.png)

```R
## ResearchGroupTools::plotIrf function

plotIrf <- function(irf, name = NULL, ylab = NULL, alpha = 0.3, n.ahead = NULL, filename = NULL, width = 10, height = 6, ...) {
  if (!irf$boot) {
    stop("Plot requires confidence intervals (call irf with argument boot).")
  }

  if (is.null(name)) {
    if (length(irf$impulse) == 1) {
      name <- irf$impulse
    } else {
      stop("More than one impulse stored, but no selection made via argument 'name'.")
    }
  } else if (!(name %in% irf$impulse)) {
    stop("Argument 'name' is not a valid impulse as it is not stored in 'irf' object.")
  }

  # to surpress warnings
  x <- NULL
  impulse <- NULL
  upper <- NULL
  lower <- NULL

  df <- data.frame(x = 1:length(irf$irf[[name]]),
                   impulse = irf$irf[[name]],
                   upper = irf$Upper[[name]],
                   lower = irf$Lower[[name]])
  colnames(df) <- c("x", "impulse", "upper", "lower")

  if (!is.null(n.ahead)) {
    df <- df[1:n.ahead, ]
  }

  p <- ggplot2::ggplot(df, ggplot2::aes(x = x)) +
    ggplot2::geom_line(ggplot2::aes(y = impulse)) +
    ggplot2::geom_hline(ggplot2::aes(yintercept = 0)) +
    ggplot2::geom_ribbon(ggplot2::aes(ymin = lower, ymax = upper), alpha = alpha) +
    ggplot2::theme_bw() +
    ggplot2::xlab("")

  if (is.null(ylab)) {
    p <- p + ggplot2::ylab(name)
  } else {
    p <- p + ggplot2::ylab(ylab)
  }

  if (!is.null(filename)) {
    ggsave(filename, p, ...)
  }

  return(p)
}

## ## ResearchGroupTools::impulseResponsePlot function
impulseResponsePlot <- function(var, impulse, response, n.ahead = 10, filename = NULL, width = 10, height = 6, ...) {
  if (class(var) != "varest" && class(var) != "svarest") {
    stop("Argument 'var' is not of type varest or svarest.")
  }

  if (!is.character(impulse) || length(impulse) > 1) {
    stop("Argument 'impulse' must be a single identifier as a string.")
  }
  if (!is.character(response) || length(response) > 1) {
    stop("Argument 'response' must be a single identifier as a string.")
  }

  irf <- vars::irf(var, impulse = impulse, response = response, boot = TRUE, n.ahead = n.ahead)
  plotIrf(irf, filename = filename, width = width, height = height, ...)
}
```



### plotting irf by basic R

```R
library(vars)
data(Canada)
head(Canada)
var_fit <- VAR(Canada, p = 1)
var_irf <- irf(var_fit)

irf1<-data.frame(var_irf$irf$e[,1],var_irf$Lower$e[,1],var_irf$Upper$e[,1])

irf2<-data.frame(var_irf$irf$e[,2],var_irf$Lower$e[,2],var_irf$Upper$e[,2])
irf3<-data.frame(var_irf$irf$e[,3],var_irf$Lower$e[,3],var_irf$Upper$e[,3])
irf4<-data.frame(var_irf$irf$e[,4],var_irf$Lower$e[,4],var_irf$Upper$e[,4])

par(mfrow=c(1,4))
matplot(irf1, type="l", lwd=2, col="red", ylab='',main=expression( sigma[e] %->% e), lty=c(1,2,2))
abline(h=0,col='black')
matplot(irf2, type="l", lwd=2, col="red", ylab='',main=expression( sigma[prod] %->% e), lty=c(1,2,2))
abline(h=0,col='black')
matplot(irf3, type="l", lwd=2, col="red", ylab='',main=expression( sigma[rw] %->% e), lty=c(1,2,2))
abline(h=0,col='black')
matplot(irf4, type="l", lwd=2, col="red", ylab='',main=expression( sigma[U] %->% e), lty=c(1,2,2))
abline(h=0,col='black')
```

### extract irf, then plotting

function to extract irf, lower/upper bound

```R
# -------------------------------------------------------------------------------
# `extract_varirf()` extracts the impulse reponse vector, along with the upper and 
# lower confidence interval vectors, created by the `irf()` function in the `vars`
# package and puts them into a tidy dataframe that allows for easier 
# impulse-reponse function plotting, particularly with the ggplot2. `extract_varirf()`
# accepts single or multiple 'varirf' list objects created by `irf()`, provided they 
# are created from the same dataset and of the same length. For additional details
# and examples of usage, please consult:
# mentalbreaks.rbind.io/posts/impulse-reponse-plots-with-vars-and-ggplot2
# 
# @anguyen1210
# -------------------------------------------------------------------------------

extract_varirf <- function(...){
    
    varirf_object <- list(...) #list one or more varirf input objects
    
    get_vec_length <- function(list_item){nrow(list_item[[1]][[1]])}
    
    if (!("varirf" %in% mapply(class, varirf_object))){
        stop("this function only accepts 'varirf' class objects")
    }
    
    if (length(unique(mapply(class, varirf_object)))!=1){
        stop("all input items must be 'varirf' class objects")
    }    
    if (length(unique(mapply(get_vec_length, varirf_object)))!=1){
        stop("all irf vectors must have the same length")   
    }  
    
    period <- as.data.frame(0:(nrow(varirf_object[[1]][[1]][[1]])-1)) 
    names(period) <- "period"
    
    for (l in 1:length(varirf_object)){
        for (i in 1:3){
            for (j in 1:dim(varirf_object[[l]][[i]][[1]])[2]){
                for (k in 1:length(varirf_object[[l]][[1]])){
                    temp_colname <- paste(names(varirf_object[[l]][i]), #vector type (irf, lower, or upper)
                                          names(varirf_object[[l]][[i]])[k], #impulse name
                                          colnames(varirf_object[[l]][[i]][[k]])[j], #response name
                                          sep = "_")
                    
                    temp <- as.data.frame(varirf_object[[l]][[i]][[k]][, j]) #extracts the vector
                    
                    names(temp) <- temp_colname #add the column name (vectortype_impulse_reponse)
                    period <- cbind(period, temp) 
                }
                
            }
        }
    }
    names(period) <- tolower(names(period))
    return(period)
}
```



```R
## load function
library(devtools)
source_url("https://raw.githubusercontent.com/anguyen1210/var-tools/master/R/extract_varirf.R")

## extract irf,lower/upper bound
single_varirf <- extract_varirf(var_irf)
head(single_varirf)

## begin plot
asy_ulv <- multiple_varirf %>% 
  ggplot(aes(x=period, y=irf_asy_ulv, ymin=lower_asy_ulv, ymax=upper_asy_ulv)) +
  geom_hline(yintercept = 0, color="red") +
  geom_ribbon(fill="grey", alpha=.2, color="grey50", linetype="dashed") +
  geom_line() +
  theme_light() +
  ggtitle("Orthogonal impulse response, asylum - unemployment level")+
  ylab("log(total unemployment)")+
  xlab("Quarter") +
  theme(plot.title = element_text(size = 11, hjust=0.5),
        axis.title.y = element_text(size=11))

#ggsave("figs/asy_ulv.png", asy_ulv, width=6, height=4)

asy_ulv
# then plot all
## then combine all plots(using patchwork package)
```



## 10. GARCH model

### `rugarch`

单变量garch

### `rmgarch`

多变量garch,引用‘’‘rugarch’‘’功能

### `garchmodels`

a tidymodel framework for garch models package (`rugarch` and `rmgarch`)

https://albertoalmuinha.github.io/garchmodels/



## 11. Descriptive statistics

### Package for descriptive statistics

`summary()`

 - basic package for summarize descriptive statistics

`psych::describe()`

- descriptive statistics
- for multiple series data: describe(df)/ as.data.table(df, describe(变量),by=分组条件变量)

### example: describe data using pokemon data

-   <https://www.youtube.com/watch?v=ZA28sOmq7nU>

```{r}
rm(list=ls())
library(tidyverse)
library(data.table)
library(psych)

Here we try several ways (packages) to summary descriptive statistics of data.(link: https://www.youtube.com/watch?v=ZA28sOmq7nU)

# 1. load data
First, we load data from a local csv file. 

pokemon <- as_tibble(read.csv("Pokemon.csv",stringsAsFactors = TRUE))
# pokemon
# str(as_tibble(pokemon))

# 2. plot one variables in dataframe
plot(pokemon[,3:10])
plot(as_tibble(pokemon[,"Type.I"],pokemon[,'Atk']))

# 3. descriptive statistics
# summary() function in basic R
summary(pokemon)

### describe/describeBy functions in psych package
# library(psych)
psych::describe(pokemon[,3:9])

### use 'data table' and 'psy::describe' for grouping describe 
# library(data.table)
as.data.table(pokemon)[,describe(Atk),by=Type.I]

```



## 12. financial data fetch & solution

 `quantmod` package

 relative packages for getting and solving financial time series data from internet open source

- `getsymbols()`


- `chart???()`
- `PerformanceAnalystic``

`tidyquant()` package

- <https://cran.r-project.org/web/packages/tidyquant/vignettes/TQ00-introduction-to-tidyquant.html>
- http://delta0726.web.fc2.com/packages/finance/tidyquant.html
------



## get data through API

#### IMF database: `imfr`package

- https://meshry.com/blog/downloading-data-from-the-imf-api-using-r/

```R
### example 1
library(imfr)

all_iso2c

current_year()

imf_ids(return_raw = FALSE, times = 400)

imf_codelist(database_id = 'IFS')


indicator.exchange.rate <- c('EREER_IX','ENEER_IX')
indicator.interest.rate <- c('FPOLM_PA','FID_PA','FIDR_PA','FILR_PA')

country.main <- c('CA','CN','FR','DE','IT','JP','UK','US')

ex <- imf_data(database_id = 'IFS',indicator = indicator.exchange.rate,country = c('CN','GB'),freq='M')

interest <- imf_data(database_id = 'IFS',indicator = indicator.interest.rate,country = country.main,freq='M')

ggplot(interest,aes(x=as.yearmon(year_month),y=FPOLM_PA,lty=iso2c))+geom_line()

### example 2
library(tidyverse)
library(imfr)
library(xts)

imf_metadata(database_id = 'IFS', indicator = 'EREER_IX',start = 2001,end = 2001, country = 'CN')
imf_databases<-imf_ids() 
View(imf_databases)

bop <- imf_codelist(database_id = 'BOP')

imf_codes(codelist = imf_codelist(database_id = 'BOP'))


IFS_INDICATOR_codes<-imf_codes(codelist = "CL_INDICATOR_IFS")

IFS_prices<-imf_data(database_id = "IFS",indicator = c('PCPI_IX','PCPI_PC_CP_A_PT','PCPI_PC_PP_PT','PCPIHA_IX'), country = c('CN','CA','FR','DE','IT','JP','UK','US'), freq = 'M', start = 1990 , end = current_year())
prices <- IFS_prices %>% select(iso2c,year_month,PCPI_IX)
colnames(prices) <- c('country','date','consumer prices index')
prices$country <- as.factor(prices$country)
prices$date <- as.yearmon(prices$date)

str(prices)

prices %>% ggplot(aes(x=date,y=`consumer prices index`))+geom_line()+facet_wrap(~country,ncol=3)

```



## 13. model results output 模型结果输出

#### `stargazer` package

统计结果输出, like xreg2 in Stata, 内置格式e.g. AER

```R
stargazar(fit1,fit2,fit3,fit4,
          type="latex"(default) for LaTeX code,"html" for HTML/CSS code,"text" for ASCII text output,
            out= "result.html/tex/txt",
            out.labels=c("","","",""),
          digits=4
          )
          
          
```
- 内置格式e.g. AER

``` R
stargazar(fit1,fit2,fit3,fit4,
          # type="latex"(default) for LaTeX code,"html" for HTML/CSS code,"text" for ASCII text output,
            out= "result.html/tex/txt",
            out.labels=c("","","",""),
          digits=4
          )
```

#### `apaTables` package

-  ???直接一键输出APA格式的表格到word文件

#### `texreg:screenreg()` function

- show multiple model results in screen for comparison

``` R
screenreg(list(twoway_effects, twoway_effects_hac),
          custom.model.names = c("Twoway Fixed Effects","Twoway Fixed Effects (HAC)"),
          digits=2, # output number digit
          stars=c(0.001,0.01,0.05,0.1) # up to 4 p-values
         )
```

#### `broom`

The broom package takes the messy output of built-in functions in R, such as `lm`, `nls`, or `t.test`, and turns them into tidy tibbles.

- `broom::tidy(modelfit)` give a summary like `coef(summary(modelfit))`

- `broom::augment(modelfit)` give a tabular result data representation
------



## 14. panel regression model

#### `plm`

panel model regression

Guidance

- 太郎丸 博(京都大学)

  http://tarohmaru.web.fc2.com/R/RBasics.html

- Rで推定する回帰モデル入門　Sho Kuroda (黒田 翔)

  https://rstudio-pubs-static.s3.amazonaws.com/273098_93ddbae82f76423aa80d3089e07a7bb6.html#glm-

- Panel Data, Time-Series Cross-Section Models, *Introduction to Quantitative Methods*

   https://www.ucl.ac.uk/~uctqiax/PUBLG100/2016/week8/seminar8.html#

#### using pipe operator for `plm()`/`lm()`

not %>%, but %$%, 将上一个结果准确传入下一个函数的data参数

```R
pdata %$% plm()
data %$% lm()
```



## 15. dummy variables

- https://www.marsja.se/create-dummy-variables-in-r/#:~:text=A%20dummy%20variable%20is%20a,%2Fyes%20or%20off%2Fon.

#### one line code to generate time dummy

```r
data$dummy <- as.numeric(data$date >= "2018-01-01")
```

#### `ifelse()`

- basic R functions

```r
dataf$Disc_A <- ifelse(dataf$discipline == 'A', 1, 0)
dataf$Disc_B <- ifelse(dataf$discipline == 'B', 1, 0)
```

#### `fastDummies()`

- package to create dummy variables

- creat one dummy:

```r
dataf.2 <- dummy_cols(dataf, 
                      select_columns = 'rank')
```

- Create more than one column (multiple dummies) : 

```r
dataf <- dummy_cols(dataf, 
                    select_columns = c('rank', 'discipline'))
```

- Create dummy and remove columns:

```R
dataf.2 <- dummy_cols(dataf, 
                      select_columns = c('rank', 'discipline'),
                      remove_selected_columns = TRUE)
```

***





##  Other research tasks

### calculate weighted average on multiple time series (unfinished)

- e.g. for calculation of country-specific GEPU from country EPU and GDP data

- https://stackoverflow.com/questions/9864631/weighted-mean-by-row

- Method: take weighted average for every rows in a dataframe

- ```R
  # indicators for a,b,c; can be country EPU data
  a=c(1:10)
  b=c(16:25)
  c=c(24:33)
  # weights for a,b,c; can be country GDP
  wa=c(3,7,3,3,3,3,3,3,3,1)
  wb=c(3,2,3,3,3,3,3,3,3,8)
  wc=c(4,1,4,4,4,4,4,4,4,1)
  # combined data
  z=data.frame(a,b,c,wa,wb,wc)
  
  # method 1
  apply(z, 1, function(x) weighted.mean(x[1:3], x[4:6]))
   [1] 14.7  7.3 16.7 17.7 18.7 19.7 20.7 21.7 22.7 24.3
  # method 2
  rowSums(z[,1:3] * z[,4:6]) / rowSums(z[,4:6])
   [1] 14.7  7.3 16.7 17.7 18.7 19.7 20.7 21.7 22.7 24.3
  # deal with NA in dataframe
  # weighted.mean(..., na.rm=T)
  # rowSums() supports the na.rm argument, so it should work for that one as well.
  ```

### make 3D surface plot (unfinished)

- make 3D surface plot of TVP-VAR impulse responses

- https://stackoverflow.com/questions/60369552/how-do-i-create-a-3d-surface-plot-in-r-if-i-have-a-dataframe-of-3-columns

- ```R
  # data
  df <- read.table(text =
      "           x             y        z
  1        0.50          0.50 48530.98
  2        0.50          0.51 49029.34
  3        0.50          0.52 49576.12
  4        0.50          0.53 50161.22
  5        0.50          0.54 50752.05
  6        0.50          0.55 51354.43
  7        0.50          0.56 51965.09
  8        0.50          0.57 38756.51
  9        0.50          0.58 39262.34
  10       0.50          0.59 39783.68
  11       0.51          0.60 41052.09
  12       0.51          0.61 41447.51
  13       0.51          0.62 26972.85
  14       0.51          0.63 27134.74
  15       0.51          0.64 27297.85
  16       0.51          0.65 27462.82
  17       0.51          0.66 27632.45
  18       0.51          0.67 27806.77
  19       0.51          0.68 27988.12
  20       0.51          0.69 25514.42", header = T)
  
  # You can use plotly to create a 3d surface plot. Use xtabs to turn your data into a suitable matrix
  library(plotly)
  plot_ly(z = ~xtabs(z ~ x + y, data = df)) %>% add_surface()
  
  ```

  ### 

# Eviews command

## VAR model

```

## import data

pagecreate(page=germany) m 1997M01 2020M06

import "D:\GitHub\globalrisk\IJFE\reviewer comment, 2022-3-29\SVAR EVIEWS\data.xlsx" range=solvedDEU colhead=1 na="#N/A" @freq M @id @date(date) @destid @date @smpl @all

# VAR model
var01.ls 1 2 d(lcgepu) d(lepu) d(interest) d(lneer) d(lstock) d(lip) d(lcpi) d(ltrade) d(unemp)



# lag length

var01.laglen(5)


# SVAR
var03.ls 1 2 d(lvix) d(liv) d(interest) d(lneer) d(lstock) d(lip) d(lcpi) d(ltrade) d(unemp)
var03.laglen(4)
var03.svar(s=smat2)

# impulse response function
var01.impulse(imp=struct, se=a) @imp 1 2 3 4 5 6 7 8 9

# accumulated IRF and save IRF & SE magnitudes(matbys: ordering by shock variable; matbyr: by response variables)
var03.impulse(13, a, imp=struct, se=a, matbys=var3_cirf) @imp 1

```

>  
>
> > | impulse | [Var  Views](varcmd-Var.html#177177) |
> > | ------- | ------------------------------------ |
> > |         |                                      |
> >
> > Display impulse response functions  of var object with an estimated VAR or VEC. 
> >
> > Syntax
> >
> > var_name.impulse(n, options)  ser1 [ser2 ser3 ...] [@  shock_series [@ ordering_series]]
> >
> > You must specify the number of periods ![img](images/varcmd.126.21.1.jpg) over which to compute the  impulse response functions.
> >
> > List the series names in the var whose  responses you would like to compute. You may optionally specify the sources of  shocks. To specify the shocks, list the series after an “@”. By default, EViews  computes the responses to all possible sources of shocks using the ordering in  the Var. 
> >
> > If you are using impulses from the Cholesky  factor, you may change the Cholesky ordering by listing the order of the series  after a second “@”. 
> >
> > Options
> >
> > General Options
>
> | g (default)                      | Display combined graphs, with impulse  responses of one variable to all shocks shown in one graph. If you choose  this option, standard error bands will not be displayed. |
> | -------------------------------- | ------------------------------------------------------------ |
> | m                                | Display multiple graphs, with impulse  response to each shock shown in separate graphs. |
> | t                                | Tabulate the impulse  responses.                             |
> | a                                | Accumulate the impulse  responses.                           |
> | imp=arg (default=“chol”)         | Type of factorization for the  decomposition: unit impulses, ignoring correlations among the residuals  (“imp=unit”), non-orthogonal, ignoring correlations among the residuals  (“imp=nonort”), Cholesky with d.f. correction (“imp=chol”), Cholesky without  d.f. correction (“imp=mlechol”), Generalized (“imp=gen”), structural  (“imp=struct”), or user specified (“imp=user”).  The structural factorization is based on  the estimated structural VAR. To use this option, you must first estimate  the structural decomposition; see [Var::svar](varcmd-svar.html#174899). For user-specified impulses, you must  specify the name of the vector/matrix containing the impulses using the  “fname=” option. The option “imp=mlechol” is provided for backward compatibility  with EViews 3.x and earlier. |
> | fname=name                       | Specify name of vector/matrix containing  the impulses. The vector/matrix must have ![img](images/varcmd.126.21.2.jpg) rows and 1 or ![img](images/varcmd.126.21.3.jpg) columns, where ![img](images/varcmd.126.21.4.jpg) is the number of  endogenous variables. |
> | se=arg                           | Standard error calculations: “se=a”  (analytic), “se=mc” (Monte Carlo), “se=boot” (bootstrap). If selecting Monte Carlo or bootstrap, you  must specify the number of replications with the “rep=” option.  Note the following:  (1) Analytic standard errors are currently  not available for (a) VECs and (b) structural decompositions identified by  long-run restrictions. The “se=a” option will be ignored for these  cases. (2) Monte Carlo standard errors are  currently not available for (a) VECs and (b) structural decompositions. The  “se=mc” option will be ignored for these cases.  (3) VECs only compute bootstrap standard  errors so this option will be ignored. |
> | rep=integer                      | Number of Monte Carlo or bootstrap  replications to be used in computing the standard errors. Must be used with the  “se=mc” and “se=boot” options. |
> | bs=arg  (default = “hp”)         | Bootstrap method: “sp” (standard  percentile), “hp” (Hall’s percentile), “hs” (Hall’s studentized), “ku”  (Killian’s unbiased). |
> | dbsrep (default = 499)           | Number of double bootstrap replications.  Must be used with the “bs=hs” and “bs=ku” options unless the “fdb” option is  specified, in which case this option will be ignored. |
> | fdb                              | Approximate the double bootstrap  computation using fast double bootstrap routines. |
> | cilevels=arg  (default = “0.95”) | Confidence interval coverage: space limited  list of numbers between 0 and 1.  Available when  “se=boot”. |
> | matbys=name                      | Save responses ordered by shocks (impulses)  in a named matrix. The first column is the response of the first variable to the  first shock, the second column is the response of the second variable to the  first shock, and so on. The response and shock  orderings correspond to the ordering of variables in the  VAR. |
> | matbyr=name                      | Save responses ordered by response series  in a named matrix. The first column is the response of the first variable to the  first shock, the second column is the response of the first variable to the  second shock, and so on. The response and shock  orderings correspond to the ordering of variables in the  VAR. |
> | smat=name                        | Save responses ordered by shocks (impulses)  in a named matrix (akin to the “matbys=” option). The  shocks and responses are ordered according to the user-specified order given by  the “@ shock_series”  and “@ ordering_series” specifications. |
> | rmat=name                        | Save responses ordered by response series  in a named matrix (akin to the “matbyr=”  option). The shocks and responses are ordered according to the user-specified  order given by the “@ shock_series” and “@  ordering_series”  specifications. |
> | prompt                           | Force the dialog to appear from within a  program.           |
> | p                                | Print the  results.                                          |
>
> Bayesian Options
>
>  
>
> | bvartype = arg  (default= “bayes”) | Impulse method: Bayesian sampling  (“bayes”), classical impulse response analysis using the posterior residual  covariance matrix (“classpost”), classical impulse response analysis using the  empirical residual covariance matrix  (“classemp”). |
> | ---------------------------------- | ------------------------------------------------------------ |
> |                                    |                                                              |
>
> If you are using Bayesian sampling, the  following Bayesian options are available:
>
>  
>
> | draws=integer  (default= 100000) | Number of draws.                                    |
> | -------------------------------- | --------------------------------------------------- |
> | burn=arg  (default=0.1)          | Proportion of initial draws to  discard.            |
> | seed=integer                     | Random number seed.                                 |
> | dropunstable                     | Drop any draws that produce unstable  coefficients. |
> | dgraph                           | Produce distribution  graphs.                       |
> | page=arg                         | Store the individual draws in a new  page.          |
>
> Examples
>
> var var1.ls 1 4 m1 gdp cpi
>
> var1.impulse(10,m) gdp @ m1 gdp  cpi
>
> The first line declares and estimates a VAR  with three variables. The second line displays multiple graphs of the impulse  responses of GDP to shocks to the three series in the VAR using the ordering as  specified in VAR1. 
>
> var1.impulse(10,m) gdp @ m1 @ cpi gdp  m1
>
> displays the impulse response of GDP to a  one standard deviation shock in M1 using a different ordering. 



# endnote

### add label to multiple selected reference: 

select multiple papers->library->change/move/copy fields

### remove duplicated reference

all reference->library-> find duplicates
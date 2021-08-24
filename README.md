---
title: useful R packages and functions
Author: pengfei luo. 
Update date: 4/30, 2021
---



[toc]



## 1. Plotting

### plot packages

`cowplot`

 - Plot grid for ggplot objects

 - simple vignettes

   https://cran.r-project.org/web/packages/cowplot/vignettes/introduction.html

- Full vignettes

  https://wilkelab.org/cowplot/articles/index.html



`ggfortify`

- Extension to ggplot2 to handle some popular packages - R software and data visualization
- e.g. support plot multiple plots for xts objects



`ggtheme`

 - 自动添加ggplot主题

```R
# using a stata style theme for plots
ggplot+theme_stata()

# usage is same as
ggplot+theme_bw()
```



`esquisse`

 - 免代码ggplot生成器, using ide to obtain ggplot code



`ggThemAssist`

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



### combine multiple plots: ggplot objects

`ggpubr::ggarrange()`

- ```R
  ggpubr::ggarrange(p1,p2,p3,p4
                  ncol=2,nrow=2,
                  labels="",label.x= , label.y= ,
                  align=c("none", "h", "v", "hv"),
                  common.legend=T)



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
```

------

#### reorder facet

- Example 1

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





### combine multiple plots: basic R

- <https://www.statmethods.net/advgraphs/layout.html>
-   `par()`
-   `layout()`

### 

------



## 2. tidyverse

#### `dyplr`

 data wragling, including functions as follows:

- `mutate()`生成新变量

- `select()` picks variables based on their names.

- `filter()` picks cases based on their values.

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

<br>



### `lubridate`

处理时间

### `reshape2`

out of date, replaced by `tidyr` package

### `stringr`

处理字符串



------



## 3. data.table

need to finish

another object for tabular data

------



## 3. data frame

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



## time series

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



## Econometrics package

`MASS` package

- 经典的统计方法

`forecast` package

- ??? to be finished



<br>



## unit root test

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



`forecast` package

泣く子も黙る(?) 有名パッケージ。中の人Hyndman先生は、ただいまこのパッケージのtidyverse対応版であるfableパッケージを鋭意ご製作中らしいのだが、単位根検定関係はまだ移植していない模様。

------



## VAR model

`vars` package

VAR model, SVAR model

`VARsignR` package

- Uhlig's (2005) sign restricted VAR model
- to be finished

### nice plot for impulse response

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



------


## GARCH model

`rugarch`	单变量garch

`rmgarch`	多变量garch,引用‘’‘rugarch’‘’功能

------







## Descriptive statistics

### Package

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

<br>









## financial data fetch & solution

 `quantmod` package

 relative packages for getting and solving financial time series data from internet open source

- `getsymbols()`


- `chart???()`
- `PerformanceAnalystic``

`tidyquant()` package

- <https://cran.r-project.org/web/packages/tidyquant/vignettes/TQ00-introduction-to-tidyquant.html>
- http://delta0726.web.fc2.com/packages/finance/tidyquant.html
------



## output model results 模型结果输出

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

`apaTables` package

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

### `broom`

The broom package takes the messy output of built-in functions in R, such as `lm`, `nls`, or `t.test`, and turns them into tidy tibbles.

- `broom::tidy(modelfit)` give a summary like `coef(summary(modelfit))`

- `broom::augment(modelfit)` give a tabular result data representation
------



## panel regression model

### `plm`

panel model regression

Guidance

- 太郎丸 博(京都大学)

  http://tarohmaru.web.fc2.com/R/RBasics.html

- Rで推定する回帰モデル入門　Sho Kuroda (黒田 翔)

  https://rstudio-pubs-static.s3.amazonaws.com/273098_93ddbae82f76423aa80d3089e07a7bb6.html#glm-

- Panel Data, Time-Series Cross-Section Models, *Introduction to Quantitative Methods*

   https://www.ucl.ac.uk/~uctqiax/PUBLG100/2016/week8/seminar8.html#

------



## How to create dummy variables
- https://www.marsja.se/create-dummy-variables-in-r/#:~:text=A%20dummy%20variable%20is%20a,%2Fyes%20or%20off%2Fon.

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



## # Others

`livecode`

- 局域网网页直播写代码
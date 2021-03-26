---
title: "Untitled"
author: "Pengfei Luo"
date: "1/31/2021"
---

# R packages



<br>



[TOC]

<br>



## plotting

### `cowplot`

Plot grid for (ggplot object)

- simple vignettes

  https://cran.r-project.org/web/packages/cowplot/vignettes/introduction.html

- Full vignettes

  https://wilkelab.org/cowplot/articles/index.html

### `ggfortify`

- Extension to ggplot2 to handle some popular packages - R software and data visualization
- e.g. support plot multiple plots for xts objects

### `ggtheme`

- 自动添加ggplot主题

- using a stata style theme for plots

 ```r
ggplot+theme_stata()
#same as
ggplot+theme_bw()
 ```

### `esquisse`

免代码ggplot生成器

### `ggThemAssist`

界面调ggplot代码

### `plotly`

交互界面图

```r
plotly(ggplot)
```

### `tygraphs`	

- plot mutiple time series
- xts objects

### `corrplot`

correlation plot

https://cran.r-project.org/web/packages/corrplot/vignettes/corrplot-intro.html

```R
# make correlation 
correlation <- cor(x=numeric vecror/matrix/data frame, na.rm= T or F,
                   use="everything","all.obs","complete.obs","na.or.complete",
                   "pairwise.complete.obs",
                   method= "pearson"(default), "kendall", "spearman"
)
# plot correlation
corrplot(correlation)
```

###  combine multiple ggplot objects into one figure

`ggpubr::ggarrange()`

```r
ggpubr::ggarrange(p1,p2,p3,p4
                  ncol=2,nrow=2,
                  labels="",label.x= , label.y= ,
                  align=c("none", "h", "v", "hv"),
                  common.legend=T)
```

`gridExtra::grid.arrange()`

```r
gridExtra::grid.arrange(p1,p2,p3,p4)
```

`cowplot::plot_grid()`

```r
cowplot::plot_grid(p1,p2,p3,p4,
                  align='h')
```

`patchwork()`

https://github.com/thomasp85/patchwork

```r
library(ggplot2)
library(patchwork)
# make multiple ggplot objects
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

### combine multiple basic plots into one figure

https://www.statmethods.net/advgraphs/layout.html

- `par()`

- `layout()`

  

<br>



## 数据处理加工

### `tidyr` package

https://tidyr.tidyverse.org/

tidyr functions fall into five main categories:

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

- `separate()` seperate eacha cell in a column to make several columns
- `seperate_rows` seperate each cell in a column to make several rows

- `unite()` collapse cells across several columns to make a single column

### `dyplr`

data wragling

- `mutate()`生成新变量
- `select()` picks variables based on their names.
- `filter()` picks cases based on their values.
- `summarise()` reduces multiple values down to a single summary.
- `arrange()` changes the ordering of the rows.
- These all combine naturally with `group_by()` which allows you to perform any operation “by group”. You can learn more about them in `vignette("dplyr")`. As well as these single-table verbs, dplyr also provides a variety of two-table verbs, which you can learn about in `vignette("two-table")`.

### `data.table`

need to finish

another object for tabular data

https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html

### `lubridate`

处理时间

### `reshape2`

out of date, replaced by `tidyr` package

### `stringr`

处理字符串



<br>



## data frame

to be finished



<br>



## time series

### `ts` objects

- Time Series in R: Quick Reference

https://rstudio-pubs-static.s3.amazonaws.com/404513_6cb313f3258b4c98a5c5948e93ad6c20.html#fn1

### `xts` package

to be finished



<br>



## Econometrics

### `MASS` package

经典的统计方法

### `forecast` package

???

 to be finished



<br>



## unit root test

https://elsur.jpn.org/mt/2020/02/002830.html

### `tseries` package

時系列分析パッケージの古手だと思う。ADF検定, KPSS検定, PP検定の関数を持っている。

- `add.test() `ADF test
- `kpss.test()` KPSS test
- `pp.test() `PP test

### `urca` package

　単位根検定のためのパッケージとして最も有名なのはこれだと思う。

- `ur.df(y, type, lags, selectlags)` ADF 
- `ur.kpss(y, type, lags, selectlags)` KPSS
- `ur.pp(y, type, lags, selectlags)` PP test

### `forecast` package

泣く子も黙る(?) 有名パッケージ。中の人Hyndman先生は、ただいまこのパッケージのtidyverse対応版であるfableパッケージを鋭意ご製作中らしいのだが、単位根検定関係はまだ移植していない模様。

<br>



## Descriptive statistics

### `summary()`

basic R function

### `psych::describe()`

descriptive statisticsusage: describe(df)/ as.data.table(df, describe(变量),by=分组条件变量)





## VAR model

### `vars` package

VAR model, SVAR model

### `VARsignR` package

Uhlig's (2005) sign restricted VAR model



## GARCH model

### `rugarch`	单变量garch

###  `rmgarch`	多变量garch,引用‘’‘rugarch’‘’功能



<br>



## financial data 金融データ、取得、処理

### `quantmod`

- ```getsymbols()```

- `chart???()`

### `PerformanceAnalystic`

### `tidy quant()`

https://cran.r-project.org/web/packages/tidyquant/vignettes/TQ00-introduction-to-tidyquant.html

http://delta0726.web.fc2.com/packages/finance/tidyquant.html



## output model results 模型结果输出

### `stargazer`

统计结果输出, like xreg2 in Stata, 内置格式e.g. AER

```R
stargazar(fit1,fit2,fit3,fit4,
          type="latex"(default) for LaTeX code,"html" for HTML/CSS code,"text" for ASCII text output,
            out= "result.html/tex/txt",
            out.labels=c("","","",""),
          digits=4
          )
          
          
```



### `apaTables`

???直接一键输出APA格式的表格到word文件

### `texreg:screen()`

show multiple model results in screen for comparison

```R
screenreg(list(twoway_effects, twoway_effects_hac),
          custom.model.names = c("Twoway Fixed Effects","Twoway Fixed Effects (HAC)"),
          digits=2, # output number digit
          stars=c(0.001,0.01,0.05,0.1) # up to 4 p-values
         )

```

### `broom`

The broom package takes the messy output of built-in functions in R, such as `lm`, `nls`, or `t.test`, and turns them into tidy tibbles.

`broom::tidy(modelfit)` give a summary like `coef(summary(modelfit))`

`broom::augment(modelfit)` give a tabular result data representation



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



## Dummy variable

https://www.marsja.se/create-dummy-variables-in-r/#:~:text=A%20dummy%20variable%20is%20a,%2Fyes%20or%20off%2Fon.

build dummy variables

### `ifelse()`

dataf$Disc_A <- ifelse(dataf$discipline == 'A', 1, 0) dataf$Disc_B <- ifelse(dataf$discipline == 'B', 1, 0)

### `fastDummies()`

creat one dummy:

```R
dataf.2 <- dummy_cols(dataf, select_columns = 'rank')
```

Create more than one column (multiple dummies) : 

```R
dataf <- dummy_cols(dataf, select_columns = c('rank', 'discipline'))
```

Create dummy and remove columns:

```R
dataf.2 <- dummy_cols(dataf, select_columns = c('rank', 'discipline'),
           remove_selected_columns = TRUE)
```



# Others

### `livecode`	局域网网页直播写代码



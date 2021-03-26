# useful R packages and functions
Author: pengfei luo  
Date: Feb 27, 2021
---
## plotting

 `cowplot`
 - Plot grid
 - ggplot objects

 `ggtheme` 
 - 自动添加ggplot主题
 - using a stata style theme for plots
- e.g. `theme_stata()`, 

 `esquisse`	
 - 免代码ggplot生成器, using ide to obtain ggplot code

 `ggThemAssist`	
 - 界面调ggplot代码, using ide to obtain ggplot code

 `plotly`	
 - 交互界面图, generate interactive plots

 `tygraphs`
 -plot mutiple time series
 - xts objects

 `corrplot`
 -	correlation plot
*** 
## 2. tidyverse packages

 `dyplr`  
 data wragling, including functions as follows:
- `mutate()`生成新变量
- `select()` picks variables based on their names.
- `filter()` picks cases based on their values.
- `summarise()` reduces multiple values down to a single summary.
- `arrange()` changes the ordering of the rows.
- These all combine naturally with `group_by()` which allows you to perform any operation “by group”. You can learn more about them in `vignette("dplyr")`. As well as these single-table verbs, dplyr also provides a variety of two-table verbs, which you can learn about in `vignette("two-table")`.

 `tidyr`  
tidyr functions fall into five main categories:
- “Pivotting” which converts between long and wide forms. tidyr 1.0.0 introduces `pivot_longer()` and `pivot_wider()`, replacing the older `spread()` and `gather()` functions. See `vignette("pivot")` for more details.
- “Rectangling”, which turns deeply nested lists (as from JSON) into tidy tibbles. See `unnest_longer()`, `unnest_wider()`, `hoist()`, and `vignette("rectangle")` for more details.
- Nesting converts grouped data to a form where each group becomes a single row containing a nested data frame, and unnesting does the opposite. See `nest()`, `unnest()`, and `vignette("nest")` for more details.
- Splitting and combining character columns. Use `separate()` and `extract()` to pull a single character column into multiple columns; use `unite()` to combine multiple columns into a single character column.
- Make implicit missing values explicit with `complete()`; make explicit missing values implicit with `drop_na()`; replace missing values with next/previous value with `fill()`, or a known value with `replace_na()`.

 `lubridate` 
 - 处理时间

 `reshape2`
 -	变形,整合

 `stringr`
 -	处理字符串
***

## data.table
forthcoming
***

## 统计计量相关

 `MASS`
 - 经典的统计方法

 `forecast`
 - ???, forcasting time series data
***

## Descriptive statistics

 `summary`	
 - basic package for summarize descriptive statistics

 `psych::describe()`
- descriptive statistics
- for multiple series data: describe(df)/ as.data.table(df, describe(变量),by=分组条件变量)

***

## VAR model
 `vars`
 - VAR模型,SVAR模型

***

## GARCH model

 `rugarch`
 - 单变量garch

 `rmgarch`
 - 多变量garch,引用`rugarch`功能

***



## 金融データ、処理

 `quantmod`  
  relative packages for getting and solving financial time series data from internet open source

- ```getsymbols()```

- `chart???()`

-  `PerformanceAnalystic`

***

## 统计结果输出 (results output)

 `stargazer`	
 - 统计结果输出
 - like `xreg2` in Stata
 - 内置格式, e.g. AER

 `apaTables`
 - ???直接一键输出APA格式的表格到word文件


***


## panel regression model

 `plm`
 - panel model regression
 - like `xtreg` in stata



## How to create dummy variables
details see https://www.marsja.se/create-dummy-variables-in-r/#:~:text=A%20dummy%20variable%20is%20a,%2Fyes%20or%20off%2Fon.

`ifelse()`
- basic R functions
```r
dataf$Disc_A <- ifelse(dataf$discipline == 'A', 1, 0) dataf$Disc_B <- ifelse(dataf$discipline == 'B', 1, 0)
```

`fastDummies()`
package to create dummy variables

- creat one dummy:

```r
dataf.2 <- dummy_cols(dataf, select_columns = 'rank')
```

- Create more than one column (multiple dummies) : 

```r
dataf <- dummy_cols(dataf, select_columns = c('rank', 'discipline'))
```

- Create dummy and remove columns:

```R
dataf.2 <- dummy_cols(dataf, select_columns = c('rank', 'discipline'),remove_selected_columns = TRUE)
```

***

## Others

 `livecode`
 - 局域网网页直播写代码

***
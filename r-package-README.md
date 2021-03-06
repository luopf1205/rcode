useful R packages/functions
================
Pengfei luo

-   [0.0.0.1 `esquisse` package](#esquisse-package)
-   [0.0.0.2 `ggThemAssist` package](#ggthemassist-package)
-   [0.0.0.3 `plotly` package](#plotly-package)
-   [0.0.0.4 `tygraphs` package](#tygraphs-package)
-   [0.0.0.5 `corplot` package](#corplot-package)
-   [0.0.1 combine multiple plots: ggplot
    objects](#combine-multiple-plots-ggplot-objects)
    -   [0.0.1.1 `ggpubr::ggarrange()`](#ggpubrggarrange)
    -   [0.0.1.2 `gridExtra::grid.arrange()`](#gridextragrid.arrange)
    -   [0.0.1.3 `cowplot::plot_grid()`](#cowplotplot_grid)
    -   [0.0.1.4 `patchwork` package](#patchwork-package)
    -   [0.0.1.5 combine multiple plots: basic
        R](#combine-multiple-plots-basic-r)
-   [0.1 tidyverse](#tidyverse)
    -   [0.1.1 `dyplr` package](#dyplr-package)
    -   [0.1.2 `tidyr` package](#tidyr-package)
    -   [0.1.3 `lubridate` package](#lubridate-package)
    -   [0.1.4 `reshape2` package](#reshape2-package)
    -   [0.1.5 `stringr` package](#stringr-package)
    -   [0.1.6 `#reshape2` package](#reshape2-package-1)
-   [0.2 data.table package](#data.table-package)
-   [0.3 data frame](#data-frame)
-   [0.4 time series](#time-series)
-   [0.5 Econometrics package](#econometrics-package)
-   [0.6 unit root test](#unit-root-test)
-   [0.7 VAR model](#var-model)
-   [0.8 GARCH model](#garch-model)
-   [0.9 Descriptive statistics](#descriptive-statistics)
    -   [0.9.1 Package](#package)
    -   [0.9.2 example: describe data using pokemon
        data](#example-describe-data-using-pokemon-data)
-   [0.10 financial data fetch &
    solution](#financial-data-fetch-solution)
-   [0.12 output model results
    模型结果输出](#output-model-results-模型结果输出)
    -   [0.12.0.1 `stargazer` package](#stargazer-package)
    -   [0.12.0.2 `texreg:screen()` function](#texregscreen-function)
    -   [0.12.1 `broom`](#broom)
-   [0.14 panel regression model](#panel-regression-model)
    -   [0.14.1 `plm`](#plm)
-   [0.15 How to create dummy variables](#how-to-create-dummy-variables)
    -   [0.15.0.1 `ifelse()`](#ifelse)
    -   [0.15.0.2 `fastDummies()`](#fastdummies)
-   [0.16 \# Others](#others)


    ## Plotting

    ### plot packages

    #### `ggfortify` package

    -   Extension to ggplot2 to handle some popular packages - R software
        and data visualization
    -   e.g. support plot multiple plots for xts objects

    #### `ggtheme` package

    -   自动添加ggplot主题


    ```r
        # using a stata style theme for plots
        ggplot+theme_stata()
        # usage is same as
        ggplot+theme_bw()

#### 0.0.0.1 `esquisse` package

-   免代码ggplot生成器, using ide to obtain ggplot code

#### 0.0.0.2 `ggThemAssist` package

-   界面调ggplot代码, using ide to obtain ggplot code

#### 0.0.0.3 `plotly` package

-   交互界面图, generate interactive plots

-   usage:

    ``` r
       #generate ggplot object, then
       plotly(ggplot)
    ```

#### 0.0.0.4 `tygraphs` package

-   plot mutiple time series

-   xts objects

#### 0.0.0.5 `corplot` package

-   usage: generate correlation plot into ggplot2 object

-   simple vignettes
    <https://cran.r-project.org/web/packages/cowplot/vignettes/introduction.html>

-   Full vignettes <https://wilkelab.org/cowplot/articles/index.html>

-   example:

    ``` r
    # calculate correlation and save 
    correlation <- cor(
      x=numeric vecror/matrix/data frame, na.rm= T or F,  use="everything","all.obs","complete.obs","na.or.complete","pairwise.complete.obs",
      method= "pearson"(default), "kendall", "spearman"
    )

    # plot correlation
    corrplot(correlation)
    ```

### 0.0.1 combine multiple plots: ggplot objects

#### 0.0.1.1 `ggpubr::ggarrange()`

-   example:

    ``` r
    ggpubr::ggarrange(p1,p2,p3,p4 ncol=2,nrow=2, labels="",label.x= , label.y= , align=c("none", "h", "v", "hv"), common.legend=T)
    ```

#### 0.0.1.2 `gridExtra::grid.arrange()`

-   example:

    ``` r
    gridExtra::grid.arrange(p1,p2,p3,p4)
    ```

#### 0.0.1.3 `cowplot::plot_grid()`

-   example:

    ``` r
    cowplot::plot_grid(p1,p2,p3,p4,
                      align='h')
    ```

#### 0.0.1.4 `patchwork` package

-   <https://github.com/thomasp85/patchwork>

-   example:

    ``` r
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

#### 0.0.1.5 combine multiple plots: basic R

-   see: <https://www.statmethods.net/advgraphs/layout.html>

-   `par()`

-   `layout()`

------------------------------------------------------------------------

## 0.1 tidyverse

### 0.1.1 `dyplr` package

data wragling, including functions as follows:

-   `mutate()`生成新变量

-   `select()` picks variables based on their names.

-   `filter()` picks cases based on their values.

-   `summarise()` reduces multiple values down to a single summary.

-   `arrange()` changes the ordering of the rows.

These all combine naturally with `group_by()` which allows you to
perform any operation “by group”. You can learn more about them in
`vignette("dplyr")`. As well as these single-table verbs, dplyr also
provides a variety of two-table verbs, which you can learn about in
`vignette("two-table")`.

example:

-   video 1: tidyr and dplyr

-   <https://www.youtube.com/watch?v=jOd65mR1zfw&list=PL9HYL-VRX0oQOWAFoKHFQAsWAI3ImbNPk>

-   example:

    ``` r
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

### 0.1.2 `tidyr` package

-   <https://tidyr.tidyverse.org/>

-   tidyr functions fall into five main categories:

-   “Pivotting” which converts between long and wide forms. tidyr 1.0.0
    introduces `pivot_longer()` and `pivot_wider()`, replacing the older
    `spread()` and `gather()` functions. See `vignette("pivot")` for
    more details.

-   “Rectangling”, which turns deeply nested lists (as from JSON) into
    tidy tibbles. See `unnest_longer()`, `unnest_wider()`, `hoist()`,
    and `vignette("rectangle")` for more details.

-   Nesting converts grouped data to a form where each group becomes a
    single row containing a nested data frame, and unnesting does the
    opposite. See `nest()`, `unnest()`, and `vignette("nest")` for more
    details.

-   Splitting and combining character columns. Use `separate()` and
    `extract()` to pull a single character column into multiple columns;
    use `unite()` to combine multiple columns into a single character
    column.

-   Make implicit missing values explicit with `complete()`; make
    explicit missing values implicit with `drop_na()`; replace missing
    values with next/previous value with `fill()`, or a known value with
    `replace_na()`.

functions in `tidyr`package

1 reshape data

-   `pivot_longer`

-   `pivot_wider`

2 handle missing value

-   `drop_na` drop rows containing GAs in column
-   `fill()` fill in NAs in columns with most recent non-NA values
-   `replace_na()` replace NAs by column

3 Split cells

-   `separate()` seperate eacha cell in a column to make several columns

-   `seperate_rows` seperate each cell in a column to make several rows

-   `unite()` collapse cells across several columns to make a single
    column

### 0.1.3 `lubridate` package

-   处理时间

### 0.1.4 `reshape2` package

-   变形,整合
-   out of date, replaced by `tidyr` package

### 0.1.5 `stringr` package

-   处理字符串

### 0.1.6 `#reshape2` package

out of date, replaced by `tidyr` package

------------------------------------------------------------------------

## 0.2 data.table package

need to finish

another object for tabular data

------------------------------------------------------------------------

## 0.3 data frame

to be finished

------------------------------------------------------------------------

## 0.4 time series

`ts` objects

-   Time Series in R: Quick Reference

-   <https://rstudio-pubs-static.s3.amazonaws.com/404513_6cb313f3258b4c98a5c5948e93ad6c20.html#fn1>

`xts` package

-   to be finished

------------------------------------------------------------------------

## 0.5 Econometrics package

`MASS` package

-   经典的统计方法

`forecast` package

-   ??? to be finished

<br>

## 0.6 unit root test

<https://elsur.jpn.org/mt/2020/02/002830.html>

`tseries` package

時系列分析パッケージの古手だと思う。ADF検定, KPSS検定,
PP検定の関数を持っている。

-   `add.test()`ADF test
-   `kpss.test()` KPSS test
-   `pp.test()`PP test

`urca` package

　単位根検定のためのパッケージとして最も有名なのはこれだと思う。

-   `ur.df(y, type, lags, selectlags)` ADF
-   `ur.kpss(y, type, lags, selectlags)` KPSS
-   `ur.pp(y, type, lags, selectlags)` PP test

`forecast` package

泣く子も黙る(?)
有名パッケージ。中の人Hyndman先生は、ただいまこのパッケージのtidyverse対応版であるfableパッケージを鋭意ご製作中らしいのだが、単位根検定関係はまだ移植していない模様。

------------------------------------------------------------------------

## 0.7 VAR model

`vars` package

VAR model, SVAR model

`VARsignR` package

-   Uhlig’s (2005) sign restricted VAR model

-   to be finished

------------------------------------------------------------------------

## 0.8 GARCH model

`rugarch` 单变量garch

`rmgarch` 多变量garch,引用’‘’rugarch’’’功能

------------------------------------------------------------------------

## 0.9 Descriptive statistics

### 0.9.1 Package

`summary()`

-   basic package for summarize descriptive statistics

`psych::describe()`

-   descriptive statistics
-   for multiple series data: describe(df)/ as.data.table(df,
    describe(变量),by=分组条件变量)

### 0.9.2 example: describe data using pokemon data

-   <https://www.youtube.com/watch?v=ZA28sOmq7nU>

``` r
rm(list=ls())
library(tidyverse)
```

    ## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──

    ## ✓ ggplot2 3.3.3     ✓ purrr   0.3.4
    ## ✓ tibble  3.0.6     ✓ dplyr   1.0.4
    ## ✓ tidyr   1.1.2     ✓ stringr 1.4.0
    ## ✓ readr   1.4.0     ✓ forcats 0.5.1

    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
library(data.table)
```

    ## 
    ## Attaching package: 'data.table'

    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     between, first, last

    ## The following object is masked from 'package:purrr':
    ## 
    ##     transpose

``` r
library(psych)
```

    ## 
    ## Attaching package: 'psych'

    ## The following objects are masked from 'package:ggplot2':
    ## 
    ##     %+%, alpha

``` r
# Here we try several ways (packages) to summary descriptive statistics of data.(link: https://www.youtube.com/watch?v=ZA28sOmq7nU)

# 1. load data
# First, we load data from a local csv file. 

pokemon <- as_tibble(read.csv("Pokemon.csv",stringsAsFactors = TRUE))
# pokemon
# str(as_tibble(pokemon))

# 2. plot one variables in dataframe
plot(pokemon[,3:10])
```

![](r-package-README_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->

``` r
plot(as_tibble(pokemon[,"Type.I"],pokemon[,'Atk']))
```

![](r-package-README_files/figure-gfm/unnamed-chunk-9-2.png)<!-- -->

``` r
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

## 0.10 financial data fetch & solution

`quantmod` package

relative packages for getting and solving financial time series data
from internet open source

-   `getsymbols()`

-   `chart???()`

-   \`PerformanceAnalystic\`\`

`tidyquant()` package

-   <https://cran.r-project.org/web/packages/tidyquant/vignettes/TQ00-introduction-to-tidyquant.html>

-   ## 0.11 <http://delta0726.web.fc2.com/packages/finance/tidyquant.html>

## 0.12 output model results 模型结果输出

#### 0.12.0.1 `stargazer` package

统计结果输出, like xreg2 in Stata, 内置格式e.g. AER

``` r
stargazar(fit1,fit2,fit3,fit4,
          type="latex"(default) for LaTeX code,"html" for HTML/CSS code,"text" for ASCII text output,
            out= "result.html/tex/txt",
            out.labels=c("","","",""),
          digits=4
          )
          
          
```

-   内置格式e.g. AER

``` r
stargazar(fit1,fit2,fit3,fit4,
          # type="latex"(default) for LaTeX code,"html" for HTML/CSS code,"text" for ASCII text output,
            out= "result.html/tex/txt",
            out.labels=c("","","",""),
          digits=4
          )
```

`apaTables` package

-   ???直接一键输出APA格式的表格到word文件

#### 0.12.0.2 `texreg:screen()` function

-   show multiple model results in screen for comparison

``` r
screenreg(list(twoway_effects, twoway_effects_hac),
          custom.model.names = c("Twoway Fixed Effects","Twoway Fixed Effects (HAC)"),
          digits=2, # output number digit
          stars=c(0.001,0.01,0.05,0.1) # up to 4 p-values
         )
```

### 0.12.1 `broom`

The broom package takes the messy output of built-in functions in R,
such as `lm`, `nls`, or `t.test`, and turns them into tidy tibbles.

-   `broom::tidy(modelfit)` give a summary like
    `coef(summary(modelfit))`

-   ## 0.13 `broom::augment(modelfit)` give a tabular result data representation

## 0.14 panel regression model

### 0.14.1 `plm`

panel model regression

Guidance

-   太郎丸 博(京都大学)

    <http://tarohmaru.web.fc2.com/R/RBasics.html>

-   Rで推定する回帰モデル入門　Sho Kuroda (黒田 翔)

    <https://rstudio-pubs-static.s3.amazonaws.com/273098_93ddbae82f76423aa80d3089e07a7bb6.html#glm->

-   Panel Data, Time-Series Cross-Section Models, *Introduction to
    Quantitative Methods*

    <https://www.ucl.ac.uk/~uctqiax/PUBLG100/2016/week8/seminar8.html#>

------------------------------------------------------------------------

## 0.15 How to create dummy variables

-   <https://www.marsja.se/create-dummy-variables-in-r/#>:\~:text=A%20dummy%20variable%20is%20a,%2Fyes%20or%20off%2Fon.

#### 0.15.0.1 `ifelse()`

-   basic R functions

``` r
dataf$Disc_A <- ifelse(dataf$discipline == 'A', 1, 0)
dataf$Disc_B <- ifelse(dataf$discipline == 'B', 1, 0)
```

#### 0.15.0.2 `fastDummies()`

-   package to create dummy variables

-   creat one dummy:

``` r
dataf.2 <- dummy_cols(dataf, 
                      select_columns = 'rank')
```

-   Create more than one column (multiple dummies) :

``` r
dataf <- dummy_cols(dataf, 
                    select_columns = c('rank', 'discipline'))
```

-   Create dummy and remove columns:

``` r
dataf.2 <- dummy_cols(dataf, 
                      select_columns = c('rank', 'discipline'),
                      remove_selected_columns = TRUE)
```

------------------------------------------------------------------------

## 0.16 \# Others

`livecode`

-   局域网网页直播写代码

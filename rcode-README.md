useful R packages/functions
================
lpf

-   [1 useful functions/packages](#useful-functionspackages)
    -   [1.1 Rstudio setting](#rstudio-setting)
        -   [1.1.1 set working dictionary to source file
            location](#set-working-dictionary-to-source-file-location)
    -   [1.2 packages](#packages)
        -   [1.2.1 gg-family (extension for
            ggplot)](#gg-family-extension-for-ggplot)
        -   [1.2.2 database](#database)
        -   [1.2.3 reference analysis](#reference-analysis)
        -   [1.2.4 models](#models)
-   [2 Plotting](#plotting)
    -   [2.1 basic-R plot (unfinished)](#basic-r-plot-unfinished)
        -   [2.1.1 plots combination: layout in basic
            R](#plots-combination-layout-in-basic-r)
    -   [2.2 ggplot](#ggplot)
        -   [2.2.1 popular plotting
            packages](#popular-plotting-packages)
        -   [2.2.2 combination of multiple ggplot
            objects](#combination-of-multiple-ggplot-objects)
            -   [2.2.2.1 reorder facet](#reorder-facet)
        -   [2.2.3 setting Japanese language theme in
            ggplot（日本語）](#setting-japanese-language-theme-in-ggplot日本語)
        -   [2.2.4 Changing Line Type for specified interval in time
            series (solid to
            dotted)](#changing-line-type-for-specified-interval-in-time-series-solid-to-dotted)
    -   [2.3 ](#section)

# 1 useful functions/packages

## 1.1 Rstudio setting

### 1.1.1 set working dictionary to source file location

``` r
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

# or
setwd(dirname(getwd()))
```

## 1.2 packages

### 1.2.1 gg-family (extension for ggplot)

`ggfortify`

`ggpubr`:publication ready plots

`ggsci`: SCI journals themes

`ggthemes`

`ggannnotate`

`ggforce`: accelerating `ggplot2`

`cowplot`

`dygraphs`:The dygraphs package is an R interface to the
[dygraphs](http://dygraphs.com/) JavaScript charting library. It
provides rich facilities for charting time-series data in R

`corrplot`: correlations plot

### 1.2.2 database

`quantmod`: yahoo financial data download

`quandl`: financial database, need API

`OECD`:OECD database

`imfr`:IMF database

`COVID19`: R interface to COVID-19 Data Hub

### 1.2.3 reference analysis

`bibliometrix`: comprehensice science mapping analysis

### 1.2.4 models

`broom`: convert statistical objects into tidy tibbles

`bruseR`:broadly useful convenient and efficient R functions

------------------------------------------------------------------------

# 2 Plotting

## 2.1 basic-R plot (unfinished)

### 2.1.1 plots combination: layout in basic R

-   <https://www.statmethods.net/advgraphs/layout.html>
-   `par()`
-   `layout()`

## 2.2 ggplot

### 2.2.1 popular plotting packages

`cowplot` package

-   Plot grid for ggplot objects

-   simple vignettes:
    <https://cran.r-project.org/web/packages/cowplot/vignettes/introduction.html>

-   Full vignettes: <https://wilkelab.org/cowplot/articles/index.html>

`ggfortify` package

-   Extension to ggplot2 to handle some popular packages - R software
    and data visualization
-   e.g. support plot multiple plots for xts objects

`ggtheme` package

-   自动添加ggplot主题

``` r
# library(ggthem)
# using a stata style theme for plots
ggplot+theme_stata()

# usage is same as
ggplot+theme_bw()
```

`esquisse` package

-   add-in with UI

-   免代码ggplot生成器, IDE to obtain ggplot code

`ggThemAssist`

-   add-in with UI

-   界面调ggplot代码, using IDE to obtain ggplot code

`plotly`

交互界面图, generate interactive plots

``` r
# generate ggplot object, then
library(plotly)
# ggplot object
plotly::plotly(ggplot)
```

`tygraphs`

-   plot multiple time series

-   xts objects

`corrplot`

-   correlation plot

-   usage:
    <https://cran.r-project.org/web/packages/corrplot/vignettes/corrplot-intro.html>

``` r
# calculate correlation and save 
correlation <- cor(
  x=numeric vecror/matrix/data frame, na.rm= T or F,  use="everything","all.obs","complete.obs","na.or.complete","pairwise.complete.obs",
  method= "pearson"(default), "kendall", "spearman"
)

# plot correlation
corrplot(correlation)
```

### 2.2.2 combination of multiple ggplot objects

`ggpubr::ggarrange()`

``` r
ggpubr::ggarrange(p1,p2,p3,p4,
                  ncol=2,nrow=2,
                  labels="",label.x= , label.y= ,
                  align=c("none", "h", "v", "hv"), # hv: align both vertical and horizon axis
                  common.legend=T)
```

`gridExtra::grid.arrange()`

``` r
 gridExtra::grid.arrange(p1,p2,p3,p4)
```

`cowplot::plot_grid()`

``` r
cowplot::plot_grid(p1,p2,p3,p4,
                  align='h')
```

`patchwork()`

-   usage: <https://github.com/thomasp85/patchwork>

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

# tagging plots
patchwork + plot_annotation(tag_levels = 'A')

# add title
patchwork + plot_annotation(title='XXX')
```

#### 2.2.2.1 reorder facet

-   Example 1: changing factor level

``` r
# p:ggplot2 object
# data: dataframe object,including country, x, y
p+facet_grid(~.country)

reorder the country
p+facet_grid(~factor(country,levels=c('japan','china','korea')))
```

-   example 2

``` r
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

### 2.2.3 setting Japanese language theme in ggplot（日本語）

``` r
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

-   example

<img src="https://i.loli.net/2021/12/02/8kirUj7dSTDCMvI.png" alt="covid infections" width="574"/>

### 2.2.4 Changing Line Type for specified interval in time series (solid to dotted)

-   Usage: 改变同时时间序列在某一时点前后的线的形状,例如: IMF World
    Economic Outlook, real GDP,
    前:实线(solid),表示实现值《现在时点》后:点线(dotted),表示预测值

-   <https://stackoverflow.com/questions/42072942/changing-line-type-for-specified-interval-in-time-series-solid-to-dotted>

-   using `subset()`

    ``` r
      data1 <- subset(data, int_year <= 2015)
      data2 <- subset(data, int_year >= 2015)
      ggplot(data1, aes(x = year, y = value, color = group)) +
        geom_point() + 
        geom_line() + 
        geom_point(data=data2, aes(x = year, y = value, color = group)) + 
        geom_line(data=data2, aes(x = year, y = value, color = group), lty=2) + 
        theme_bw()
    ```

-   Example

    <img src="https://i.stack.imgur.com/kaZgU.png" alt="enter image description here" width="500" height="250"/>

## 2.3 

library(vars)
library(ResearchGroupTools)
library(tidyverse)

# load data----
data("Canada")
summary(Canada)
plot(Canada,nc=2,xlab="")
#tip: canada is a mts/ts object 


#VAR----
VARselect(Canada, lag.max = 8, type = "both")
#tip: AIC => lag=3

# 
Canada <- Canada[, c("prod", "e", "U", "rw")]
#tip: object class: mts/ts/matrix
VAR1 <- VAR(Canada, p = 1, type = "both")


plot(VAR1, names = "e")

irf_VAR1 <- irf(VAR1, response = "U", n.ahead = 48, boot = TRUE)
plot(irf_VAR1)

# method 1: plot 4 x 4 panel for all variables' IRF
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
# combine plots
gridExtra::grid.arrange(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16)

#impulse response plot function
impulseResponsePlot <- function(var, impulse, response, cumulative,ci,
                                n.ahead = 10, filename = NULL, width = 10, height = 6, ...) {
  if (class(var) != "varest" && class(var) != "svarest") {
    stop("Argument 'var' is not of type varest or svarest.")
  }
  
  if (!is.character(impulse) || length(impulse) > 1) {
    stop("Argument 'impulse' must be a single identifier as a string.")
  }
  if (!is.character(response) || length(response) > 1) {
    stop("Argument 'response' must be a single identifier as a string.")
  }
  
  irf <- vars::irf(var, impulse = impulse, response = response, cumulative = cumulative,ci=ci,
                   boot = TRUE, n.ahead = n.ahead)
  plotIrf(irf, filename = filename, width = width, height = height, ...)
}
# method 2: plot 4 x 4 panel for all variables' IRF----

x1 <- VAR1 %>%  impulseResponsePlot(impulse = "prod", response = "prod", n.ahead = 20,cumulative = FALSE,ci=0.95)+
  labs(title = "prod -> prod",x='',y='')
x2 <- VAR1 %>%  impulseResponsePlot(impulse = "prod", response = "prod", n.ahead = 20,cumulative = FALSE,ci=0.8)+
  labs(title = "prod -> prod",x='',y='')
x3 <- VAR1 %>%  impulseResponsePlot(impulse = "prod", response = "prod", n.ahead = 20,cumulative = TRUE,ci=0.95)+
  labs(title = "prod -> prod",x='',y='')
# for comparison
gridExtra::grid.arrange(x1,x2,x3,ncol=3)

# method 2----
VAR1 %>%  vars::irf(impulse = "prod", response = "prod", cumulative = FALSE,ci=0.68,
                 boot = TRUE, n.ahead = 20) %>% 
  plotIrf()


irf0 <- VAR1 %>% irf(impulse = "prod", response = "e", boot = TRUE, n.ahead = 20,ci=0.95)
irf1 <- VAR1 %>% irf(impulse = "prod", response = "e",boot = TRUE, n.ahead = 20,ci=0.9)
irf2 <- VAR1 %>% irf(impulse = "prod", response = "e",boot = TRUE, n.ahead = 20,ci=0.95,cumulative=TRUE)
irf0 %>% plotIrf()
irf1 %>% plotIrf()
irf2 %>% plotIrf()
plot(irf0)

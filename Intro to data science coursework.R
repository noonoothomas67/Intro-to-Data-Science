#Load data
g<- read.csv("C:/Rlab/Assesment intro data science/broken rails and buckled rails.csv")

rail_data<-data.frame(
  Year=c(
    "2002-2003","2003-2004","2004-2005","2005-2006","2006-2007",
    "2007-2008","2008-2009","2009-2010","2010-2011","2011-2012",
    "2012-2013","2013-2014","2014-2015","2015-2016","2016-2017",
    "2017-2018","2018-2019","2019-2020","2020-2021","2021-2022",
    "2022-2023","2023-2024","2024-2025"
  ),
  Broken_Rails=c(444,334,322,316,192,181,165,169,182,129,
                 180,120,95,104,88,74,86,93,82,68,99,61,53
  ),
  Buckled_Rails = c(
    9,137,32,56,85,4,17,25,29,12,
    10,19,14,9,7,14,25,12,7,13,29,4,4
  )
)
View(rail_data)

summary(rail_data[,c("Broken_Rails","Buckled_Rails")])

#Exploratory Data Analysis

mean(rail_data$Broken_Rails)
mean(rail_data$Buckled_Rails)

var(rail_data$Broken_Rails)
var(rail_data$Buckled_Rails)

sd(rail_data$Broken_Rails)
sd(rail_data$Buckled_Rails)

range(rail_data$Broken_Rails)
range(rail_data$Buckled_Rails)

IQR(rail_data$Broken_Rails)
IQR(rail_data$Buckled_Rails)

install.packages("moments")
library(moments)

skewness(rail_data$Broken_Rails)
skewness(rail_data$Buckled_Rails)

descriptive_table <- data.frame(
  Variable = c("Broken Rails", "Buckled Rails"),
  Mean = c(mean(rail_data$Broken_Rails), mean(rail_data$Buckled_Rails)),
  Median = c(median(rail_data$Broken_Rails), median(rail_data$Buckled_Rails)),
  SD = c(sd(rail_data$Broken_Rails), sd(rail_data$Buckled_Rails)),
  Variance = c(var(rail_data$Broken_Rails), var(rail_data$Buckled_Rails)),
  Min = c(min(rail_data$Broken_Rails), min(rail_data$Buckled_Rails)),
  Max = c(max(rail_data$Broken_Rails), max(rail_data$Buckled_Rails)),
  IQR = c(IQR(rail_data$Broken_Rails), IQR(rail_data$Buckled_Rails))
)
descriptive_table
View(descriptive_table)

#plotting time series

rail_data$Time_Index<-1:nrow(rail_data)
plot(
  rail_data$Time_Index,
  rail_data$Broken_Rails,
  type = "l",
  lwd = 2,
  xlab = "Time (Year Index)",
  ylab = "Number of Broken Rails",
  main = "Time Series of Broken Rail Failures (2002–2025)"
)
points(
  rail_data$Time_Index,
  rail_data$Broken_Rails,
  pch = 16
)
plot(
  rail_data$Time_Index,
  rail_data$Buckled_Rails,
  type = "l",
  lwd = 2,
  xlab = "Time (Year Index)",
  ylab = "Number of Buckled Rails",
  main = "Time Series of Buckled Rail Failures (2002–2025)"
)
points(
  rail_data$Time_Index,
  rail_data$Buckled_Rails,
  pch = 16
)

plot(
  rail_data$Time_Index,
  rail_data$Broken_Rails,
  type = "l",
  lwd = 2,
  xlab = "Time (Year Index)",
  ylab = "Number of Failures",
  main = "Comparison of Broken and Buckled Rail Failures (2002–2025)"
)
lines(
  rail_data$Time_Index,
  rail_data$Buckled_Rails,
  lwd = 2,
  lty = 2
)
legend(
  "topright",
  legend = c("Broken Rails", "Buckled Rails"),
  lty = c(1, 2),
  lwd = 2
)

# Plotting a histogram
hist(
  rail_data$Broken_Rails,
  main ="Histogram of Broken Rail Failures",
  x1ab ="Number of Broken Rails",
  breaks = 10
)
hist(
  rail_data$Buckled_Rails,
  main = "Histogram of Buckled Rail Failures",
  xlab = "Number of Buckled Rails",
  breaks = 10
)

mean_broken <- mean(rail_data$Broken_Rails)
var_broken <- var(rail_data$Broken_Rails)

mean_broken
var_broken

mean_buckle <-mean(rail_data$Buckled_Rails)
var_buckle <-var(rail_data$Buckled_Rails)

mean_buckle
var_buckle

#Model diagnostics (overdispension)

dispersion_broken <- var_broken / mean_broken
dispersion_broken

dispersion_buckle <-var_buckle / mean_buckle
dispersion_buckle

#Poisson Regression

pois_broken <- glm(
  Broken_Rails ~ Time_Index,
  family = poisson,
  data = rail_data
)
summary(pois_broken)
exp(coef(pois_broken))

pois_buckle <- glm(
  Buckled_Rails ~ Time_Index,
  family = poisson,
  data = rail_data
)
summary(pois_buckle)
exp(coef(pois_buckle))

AIC_pois_broken <- AIC(pois_broken)
AIC_pois_buckle <- AIC(pois_buckle)
AIC_pois_broken
AIC_pois_buckle

install.packages("MASS")
library(MASS)

# Negative binomial regression

nb_broken <-glm.nb(
  Broken_Rails ~ Time_Index,
  data = rail_data
)
summary(nb_broken)
exp(coef(nb_broken))
AIC_nb_broken <- AIC(nb_broken)
AIC_nb_broken

nb_buckle <- glm.nb(
  Buckled_Rails ~ Time_Index,
  data = rail_data
)
summary(nb_buckle)
exp(coef(nb_buckle))
AIC_nb_buckle <- AIC(nb_buckle)
AIC_nb_buckle

# Model comparison

model_comparison <- data.frame(
  Model = c(
    "Poisson - Broken Rails",
    "Negative Binomial - Broken Rails",
    "Poisson - Buckled Rails",
    "Negative Binomial - Buckled Rails"
  ),
  AIC = c(
    AIC_pois_broken,
    AIC_nb_broken,
    AIC_pois_buckle,
    AIC_nb_buckle
  )
)
 
model_comparison
View(model_comparison)

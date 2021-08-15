##############Exploratory Graphs###############
#simple_summaries_of_data:-
#Data:-
pollution <- read.csv("./ad_viz_plotval_data.csv")
head(pollution)
str(pollution)
#remove columns:-
pollution <- pollution[, c(-3, -6:-12) ]
#summary and boxplot:-
#Five number summary:-
summary(pollution$Daily.Mean.PM2.5.Concentration)
#Boxplot:-
boxplot(pollution$Daily.Mean.PM2.5.Concentration,col = 'blue')
abline(h = 12)#abline function is for drawing a line
#Histogram:-
hist(pollution$Daily.Mean.PM2.5.Concentration,col = 'blue')
#Histogram (contd.)
rug(pollution$Daily.Mean.PM2.5.Concentration)#rug function tells us where the most of the values lies.
hist(pollution$Daily.Mean.PM2.5.Concentration,col = 'brown',breaks = 100)
abline(v = 12,lwd = 2)#lwd means line width
abline(v = median(pollution$Daily.Mean.PM2.5.Concentration),col = 'magenta',lwd = 4)
#Bar plot:-
barplot(table(pollution$COUNTY),col = 'purple',main = 'Pollution in County')#function main is for adding title.
#Multiple Box Plots:-
boxplot(Daily.Mean.PM2.5.Concentration ~ COUNTY ,data = pollution ,col = 'blue')
abline(h = 13)
#Multiple Histogram:-
par(mfrow = c(1,1),mar = c(4,4,2,1))
hist(subset(pollution,COUNTY == "Baldwin")$Daily.Mean.PM2.5.Concentration,col = 'green')
hist(subset(pollution,COUNTY == "Etowah")$Daily.Mean.PM2.5.Concentration,col = 'green')
#Scatterplot - using color:-
par(mfrow = c(1,1),mar = c(4,4,2,1))
pollution$Date = as.Date(pollution$Date,"%m/%d/%Y")
with(pollution,plot(Date,Daily.Mean.PM2.5.Concentration))
abline(h = 12 , lwd = 2 , lty = 3)#ity means the type of the line different numbers have different types.
#############Base Plot#############
library(datasets)
data(cars)
with(cars,plot(speed,dist))
#############Lattice Plot############
library(lattice)
state <- data.frame(state.x77,region = state.region)
xyplot(Life.Exp ~ Income | region,data = state ,layout=c(4,1))
############ggplot2 Plot##############
library(ggplot2)
data(mpg)
qplot(displ,hwy,data = mpg)
###########################The Base Plotting System###################
#Simple Base Graphics Histogram:-
library(datasets)
hist(airquality$Ozone)
#Simple Base Graphics : Scatterplot:
library(datasets)
with(airquality,plot(Wind,Ozone))
#Annotation -point and color:-
with(airquality,plot(Wind,Ozone,pch = 25))#pch is a point character(marker).
with(airquality,plot(Wind,Ozone,pch = 25 ,col = 'orange'))
#Simple Base Graphics: BOxplot:-
str(airquality)#check the structure of the data
library(datasets)
airquality <- transform(airquality,Month = factor(Month))#transform months to factor
boxplot(Ozone ~ Month,airquality,xlab = "Month",ylab = "Ozone(ppb)",main = 'Ozone Vs Wind')
#Some important Base graphics parameter(contd.)
par("lty")
par("pch")
par("col")
par("bg")
par("mfrow")
par("mar")
#########Base Plot with Annotation#######
library(datasets)
with(airquality,plot(Wind,Ozone))
title(main = "Ozone and Wind in New York City")##Add a title
#Base plot with Annotation (Contd.)
with(airquality,plot(Wind,Ozone,main = "Ozone and Wind in New York City"))
with(subset(airquality,Month == 5),points(Wind,Ozone,col = 'blue'))
#Another Contd.
with(airquality,plot(Wind,Ozone,main = "Ozone and Wind in New York City",type = 'n'))
with(subset(airquality,Month ==5),points(Wind,Ozone,col='blue'))
with(subset(airquality,Month !=5),points(Wind,Ozone,col= 'red'))
legend("topright",pch = 1,col = c('blue','red'),legend = c('May','Other Months'))
#Base Plot with Regression Line:-
with(airquality,plot(Wind,Ozone,main = "Ozone and Wind in New York City",pch = 20))
model <- lm(Ozone ~ Wind,airquality)#lm is a linear model(is a type of regression line)
model#Let's check the output of model#(cofficients)it gives the interception point and the relationship with wind.
abline(model,lwd = 2,col = 'red',lty = 25)
#######Multiple Base Plots########
par(mfrow=c(1,2))#mfrow is for setting columns and rows
with(airquality,{
     plot(Wind,Ozone,main='Ozone and Wind')
     plot(Solar.R,Ozone,main='Ozone and Solar Radiation')
})
#Multiple Base Plots (Contd.)
par(mfrow = c(1,3),mar = c(4,4,2,1), oma = c(0,0,2,0) )#mar=margin
with(airquality,{
     plot(Wind,Ozone,main = 'Ozone and Wind')
     plot(Solar.R,Ozone,main = 'Ozone and Solar Radiation')
     plot(Temp,Ozone,main = 'Ozone and Temperature')
     mtext("Ozone and Weather in New York City", outer = TRUE)
})
#####################Graph With Lattice########################
#Lattice_Plot:-
#Lattice Function (Contd.)
#xyplot(y ~ x | f * g, data).This is the formula of lattice plot.
#Simple Lattice Plot:-
library(lattice)
library(datasets)
#simple scatter plot:-
xyplot(Ozone ~ Wind, data = airquality)
#Simple Lattice Plot (Contd.)
##Convert Month to a factor variable
airquality <-transform(airquality,Month = factor(Month))
xyplot(Ozone ~ Wind | Month , data = airquality,layout = c(5,1))#in lattice we give first column then row.
#Lattice_Behavior:-
p <- xyplot(Ozone ~ Wind ,data = airquality)
print(p)
####Lattice _Panel_Function:-
#Lattice_Panel_Function(Contd.):-
set.seed(10)
x <- rnorm(100)
f <- rep(0:1,each = 50)
y <- x + f - f * x +rnorm(100,sd = 0.5)
f <- factor(f,labels = c('Group 1','Group 2'))
xyplot(y ~ x | f ,layout = c(2,1))##Plot with 2 panels.
###Custom Panel Function:-
xyplot(y ~ x | f ,panel = function(x,y,...){
        panel.xyplot(x , y , ...)## first call the default panel function for xyplot
        panel.abline(h = median(y),lty = 2) ## add a horizontal line at the median
})
#Lattice Panel Functions: Regression Line
#custom Panel Function:-
xyplot(y  ~ x | f ,panel = function(x ,y , ...) {
        panel.xyplot(x , y , ...) #first call default panel function
        panel.lmline(x , y, col = 2) #Overlay a simple regression line.
})
#########################Graph with Ggplot2###########################
library(ggplot2)
str(mpg)#Let's see the structure of the data
#qplot_scatterplot:-
qplot(displ,hwy,data = mpg)
#qplot_scatterplot_aesthetics:-
#Modifying Aesthetics:-
qplot(displ,hwy,data = mpg,color = drv)#color aesthetic
#qplot_scatterplot_geometric:-
#Adding a Geometric:-
qplot(displ,hwy,data = mpg,geom = c('point','smooth'))
qplot(displ,hwy,data = mpg,geom = c('point'))#this is not a good way
qplot(displ,hwy,data = mpg,geom = c('line'))#this is also not good
#qplot_histogram_aes:-
#Histograms:-
qplot(hwy,data = mpg, fill = drv)
#qplot_facets_scatter_and histogram:-
#Facets:-
qplot(displ,hwy,data = mpg,facets = . ~ drv)
#variations:-
qplot(displ,hwy,data = mpg,facets =  drv ~.)       
qplot(displ,hwy,data = mpg,facets = drv ~ fl)
qplot(displ,hwy,data = mpg,facets = fl ~ drv)
#Facets (Contd.)
qplot(hwy,data = mpg,facets = drv ~ . ,binwidth = 2)
qplot(hwy,data = mpg,facets = drv ~ fl ,binwidth = 2)
#####Maccs Plot Example:-
#EXAMPLE MAACS:-
setwd('C:/Users/ggggg/Desktop/Data')
load("C:/Users/ggggg/Desktop/Data/maacs-210103-130224.rda")
str(maacs)
#Histogram of Exhaled Nitric Oxide:-
qplot(log(eno),data = maacs)
#Histogram by Group:-
qplot(log(eno),data = maacs,fill = mopos)
#Density Smooth:-
qplot(log(eno),data = maacs,geom = "density")
#Density Smooth (Contd.)
qplot(log(eno),data = maacs,geom = 'density')
qplot(log(eno),data = maacs,geom = 'density',color = mopos)#this is better than fill
qplot(log(eno),data = maacs,geom = 'density',fill = mopos)
#Scatterplot eno vs pm25:-
qplot(log(pm25),log(eno),data = maacs)# log is used to keep the axis(scale) same.
#Scatterplot eno vs pm25(Contd.):-
qplot(log(pm25),log(eno),data = maacs,shape = mopos)
qplot(log(pm25),log(eno),data = maacs,color = mopos)
qplot(log(pm25),log(eno),data = maacs,color = mopos,geom = c('point','smooth'),method = 'lm')
qplot(log(pm25),log(eno),data = maacs,color = mopos,geom = c('point','smooth'),method = 'lm')      
qplot(log(pm25),log(eno),data = maacs,geom = c ("point","smooth"),method = 'lm',facets = . ~  mopos) #apply facets.we can add color = mopos,but this is not a good way.     
##########ggplot2_example###########
#Basic qplot:-
maacs_2 <- read.csv("./bmi_pm25_no2_sim-210103-151358.csv",header = TRUE)
head(maacs_2)
qplot(logpm25,NocturnalSympt,data = maacs_2,facets = . ~ bmicat, geom =
        c("point","smooth"),method = "lm")
#Building Up in Layer:-
g <- ggplot(maacs_2,aes(logpm25,NocturnalSympt))#aesthetics# initial all to ggplot
summary(g)#summary of ggplot object.
#No Plot Yet:-
g <- ggplot(maacs_2,aes(logpm25,NocturnalSympt))
print(g)
p <- g + geom_point()#explicitly save and print ggplot object.
print(p)
g + geom_point()#auto_print plot object without saving.
#First Plot with Point Layer:-
g <- ggplot(maacs_2,aes(logpm25,NocturnalSympt))
g + geom_point()
#Adding more layers : Smooth:-
g + geom_point() + geom_smooth()
#Adding more layers : Smooth(Contd.):-
g + geom_point() + geom_smooth(method = "lm")# method is used to draw a straight line.
#Adding more layers:facets:-
g + geom_point() + facet_grid(. ~ bmicat) + geom_smooth(method = "lm")
#################ggplot2_annotation_example###################
#Modifying Aesthetics(Constant values):-
g + geom_point(color = "steelblue",size = 4,alpha = 1/2)#alpha is for transparency in colored ball.
g + geom_point(color = "steelblue",size = 4)#Let's do without alpha
#Modifying Aesthetics (Contd.)- Data variables:-
g + geom_point(aes(color = bmicat),size = 4 ,alpha = 1/2)
#Modifying Labels:-
g + geom_point(aes(color = bmicat)) + labs(title = "MAACS Cohort") +#labs function for modifying titles and x and y labels. 
        labs(x = expression("log" * PM[2.5]),y = "Nocturnal Symptoms") 
#Customizing the Smooth:-
g + geom_point(aes(color = bmicat),size = 4 ,alpha = 1/2) + 
        geom_smooth(size = 2,linetype = 13 ,method = "lm",se = FALSE)
g + geom_point(aes(color = bmicat),size = 4 ,alpha = 1/2) + 
        geom_smooth(size = 2,linetype = 13 ,method = "lm",se =TRUE) #Se is for gray shade which shows interval
#Adding facets:-
g + geom_point(aes(color = bmicat),size = 4 ,alpha = 1/2) + 
        geom_smooth(size = 2,linetype = 13 ,method = "lm",se =TRUE) +
        facet_grid(. ~ bmicat)
g + geom_point(size = 4 ,alpha = 1/2) + 
        geom_smooth(size = 2,linetype = 13 ,method = "lm",se =TRUE) +
        facet_grid(. ~ bmicat)#Let's see without color
#Changing the theme:-
g + geom_point(aes(color = bmicat)) + theme_bw(base_family = "Times")
#ggplot2_axis_limits:-
#A Note about axis limits:-
testdat <- data.frame(x = 1:100,y = rnorm(100))
testdat[50,2] <- 100 #outlier!
plot(testdat$x,testdat$y,type = "l",ylim = c(-3,3))
#A Note about axis limits(Contd.):-
g <- ggplot(testdat,aes(x = x,y = y))
g + geom_line()
#Axis Limits:-
g + geom_line() + ylim(-3,3)#outlier missing
#Axis Limits(Contd.):-
g + geom_line() + coord_cartesian(ylim = c(-3,3))
#ggplot2_a_complex_example:-
#PREPROCESSING EXTRACT_NEW_VARIABLES:-
#Unlike our previous BMI variable,NO2(logno2) is continuous,and so we need to make NO2 categorical so we can condition on it
#in the plotting .We can use the cut function for this purpose.We will divide the NO2 variable into tertiles.
cutpoints <- quantile(maacs_2$logno2_new,seq(0,1,length = 4),na.rm = TRUE)#We need to calculate the tertile with the quartile function.                
#Divide the original logno2_new variable into the ranges defined by the cut points(Computed Above)
maacs_2$no2tert <- cut(maacs_2$logno2_new,cutpoints)
#Now no2tert variable is a categorical factor variable containing 3 levels,indicating the ranges of NO2(on the log scale)
levels(maacs_2$no2tert)#See the levels of newly created factor variable.
#####CODE FOR FINAL PLOT####
###setup ggplot with data frame:-
g <- ggplot(maacs_2,aes(logpm25,NocturnalSympt))
#Add layers:-
g + geom_point(alpha = 1/3) + #Add points
        facet_wrap(bmicat ~ no2tert,nrow = 2,ncol = 4) + #make panel
        geom_smooth(method = "lm",col = "steelblue",se = FALSE) + #add color 
        theme_bw(base_family = "Avenir",base_size = 10) + #change theme
        labs(x = expression("log" * PM[2.5])) + #add labels
        labs(y = "Nocturnal symptoms") + 
        labs(title = "MAACS Cohort") +
        theme(plot.title = element_text(hjust = 0.5)) # set the title in the center.
#####################################THe END########################################



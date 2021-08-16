# How to set and get directory
getwd()
file.exists('data_2')
setwd('C:/Users/ggggg/Desktop/learn')
file.exists('.git')
getwd()
setwd('../')
getwd()
if(!file.exists('Data')){
     dir.create('Data')
}
setwd('./Data')
getwd()
#How to download data online and read file
getwd()
fileurl <- "https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2020-financial-year-provisional/Download-data/annual-enterprise-survey-2020-financial-year-provisional-csv.csv"
download.file(fileurl, destfile = "annural_enterprise_survey.csv")

list.files('../Data')
surveydata <- read.csv( "annural_enterprise_survey.csv")
#structure of data
str(cameradata)
#see data downloaded date
dateDownloaded <-date()
dateDownloaded
#read.table
surveyData <- read.table('annural_enterprise_survey.csv',sep = ',',header = TRUE)
head(surveyData)
#read.csv
survey <- read.csv('annural_enterprise_survey.csv')
head(survey)
#read.csv2 is same as read.csv but it(read.csv2) is faster than read.csv.
# fread fast reading.
library(data.table)
?fread
#Reading Excel Files_1
install.packages('xlsx')
Sys.setenv(JAVA_HOME='C:/Program Files/Java/jdk-16.0.1')
library(xlsx)
market <-read.xlsx("../Data/markets (1).xlsx",sheetIndex = 1,header = TRUE)
head(market)
#Reading specific rows and columns
colIndex <- 2:3
rowIndex <- 1:4
marketdataSubset <- read.xlsx('../Data/markets (1).xlsx',sheetIndex = 1,colIndex = colIndex,rowIndex = rowIndex)
marketdataSubset
#Reading Excel Files_2
install.packages('readxl')
library('readxl')
readxl_example()
xlsx_example <- readxl_example( "datasets.xls" )
readxl_example("datasets.xls")
xlsx_example <- readxl_example( "type-me.xls" )
readxl_example("type-me.xls")
#read file
read_excel(xlsx_example)
diris <- read_excel(xlsx_example)
View(diris)
market <- read_excel('./Data/markets (1).xlsx')
head(market)
#Write Excel Files
# write function is use for saving files
install.packages("devtools", type = "win.binary")
devtools::install_github("ropensci/writexl")
library(writexl)
write_xlsx(survey,'annural_enterprise_survey.xlsx')
#EXERCISE(read packages)
?read_excel
install.packages('openxlsx')
??openxlsx
library('openxlsx')
#Read HTML webpage
install.packages('rvest')
library(rvest)
theurl <- "https://en.wikipedia.org/wiki/Brazil_national_football_team"
file <- read_html(theurl)
#Read table from the webpage
tables <- html_nodes(file,"table")
table1 <- html_table(tables[4],fill = TRUE)
table1 <-html_table(tables[3],fill=TRUE)
table1 <- html_table(tables[5],fill = TRUE)
View(table1)
print(table1)
?html_text
#examples rvest site
library(rvest)
lego_movie <- read_html("http://www.imdb.com/title/tt1490017/")
rating <- lego_movie 
movie <- html_nodes(lego_movie,"strong span")
html_text(movie) 
as.numeric()
rating
library(rvest)
lego_movie <- read_html("http://www.imdb.com/title/tt1490017/")
rating <- lego_movie %>% 
     html_nodes("strong span") %>%
     html_text() %>%
     as.numeric()
rating
# sqlite create_db_n_tables
#install package and load the RSQLite library
install.packages("RSQLite")
library(RSQLite)
#load the mt car as an R data frame and put the row names as column and print the header
mtcars$car_names <- rownames(mtcars)
rownames (mtcars)<-c()
head(mtcars)
#####Creating Databases and Tables#####
#create or connect to database
conn <- dbConnect(RSQLite::SQLite(),"carsDB.db")
conn
#write the mtcar dataset into a table names mtcars_dataset
dbWriteTable(conn,'cars_data',mtcars,append = TRUE)
#list all the tables available in the database
dbListTables(conn)
#quick access functions
dbListFields(conn,'cars_data')
dbReadTable(conn,'cars_data')
rdd <- dbReadTable(conn,'cars_data')
########Executing SQL Queries########
dbGetQuery(conn,"SELECT * FROM carS_data LIMIT 5")
#Get the car_names and horse power starting with M that have 6 ,8 cylinder
dbGetQuery(conn,"SELECT car_names,hp,cyl from carS_data
           WHERE car_names LIKE 'M%' AND cyl IN (6,8)")
#Get the average horsepower and mpg by number of cylinder groups
dbGetQuery(conn,"SELECT cyl,AVG(hp) AS 'average_hp',AVG(mpg) AS 'average_mpg' FROM cars_data
                GROUP BY cyl
                ORDER BY average_hp")
avg_HPcyl <- dbGetQuery(conn,"SELECT cyl,AVG(hp) AS 'average_hp' FROM cars_data
                        GROUP BY cyl
                        ORDER BY average_hp") 
avg_HPcyl
class(avg_HPcyl)
######Insert variable into Queries(Parameterised Queries)#######
#User is looking for cars that have over 18 miles per gallon(mpg) and more than 6 cylinders
mpg <- 18
cyl <- 6
Result <- dbGetQuery(conn,"SELECT car_names, mpg,cyl FROM cars_data WHERE mpg >= ? AND cyl >= ?",
                     params=c(mpg,cyl))
Result
#if i want the data of just 4 cylinders
mpg <- 18
cyl <- 4
Result <- dbGetQuery(conn,"SELECT car_names, mpg,cyl FROM cars_data WHERE mpg >= ? AND cyl == ?",
                     params=c(mpg,cyl))
Result
#####Statement that do not return Tabular Result#####
#visualize the table before deletion
dbGetQuery(conn,"SELECT * FROM cars_data LIMIT 10")
#Delete the column belonging to the Mazda RX4.You will see a 1 as output.
dbExecute(conn,"DELETE FROM cars_data WHERE car_names = 'Mazda RX4'")
#Visualize the new table after deletion
dbGetQuery(conn,"SELECT * FROM cars_data LIMIT 10")
#Insert the data for the Mazda RX4.This will also output 1.
dbExecute(conn,"INSERT INTO cars_data VALUES
          (21.0,6,160.0,110,3.90,2.620,16.46,0,1,4,4,'Mazda RX4')")
#See that we re-introduced Mazda RX4 successfully at the end
dbGetQuery(conn,"SELECT * FROM cars_data")
#####SQLite other functions#####
#you can fetch all results
res <- dbSendQuery(conn,"SELECT * FROM cars_data WHERE cyl = 6")
dbFetch(res)
#clear the results
dbClearResult(res)
#or a chunk at a time
res <- dbSendQuery(conn,"SELECT * FROM cars_data WHERE cyl = 8")
while (!dbHasCompleted(res)){
     chunk <- dbFetch(res,n = 5)
     print(nrow(chunk))
}
#clear the result
dbClearResult(res)
###At the end disconnect the db it's really really necessary!
dbDisconnect(conn)
###########Reading from MySQL################
#first of all install package and call library RMySQL
install.packages("RMySQL")
library(RMySQL)
sqldata <- dbConnect(MySQL(),user = "genome",host = "genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(sqldata,"show databases;");dbDisconnect(sqldata)
result
#######Connecting to a MySQL database######
hg19 <- dbConnect(MySQL(),user = 'genome', db = 'hg19',
                  host = 'genome-mysql.cse.ucsc.edu')
allTables <- dbListTables(hg19)
length(allTables)
allTables[1:5]
#Run a Query using dbGetQuery() command
dbListFields(hg19,"affyU133Plus2")
dbGetQuery(hg19,"SELECT count(*)from affyU133Plus2")#affyU133Plus2 is table name
#Read from table
aff_table <- dbReadTable(hg19,'affyU133Plus2')
head(aff_table)
#Select a specific subset
query <- dbSendQuery(hg19,"SELECT * FROM affyU133Plus2 WHERE MISmatches between 1 and 3 " )
aff_miss <- fetch(query)
quantile(aff_miss$MISmatches)
aff_miss_small <- fetch(query,n=10)
dbClearResult(query)
#let's see dimensions
dim(aff_miss_small)
#At the end we disconnect the data
dbDisconnect(hg19)
########Create data tables just like data frames########
library(data.table)
DF <- data.frame(x = rnorm(9),y = rep(c('a','b','c'),each = 3),
                 z = rnorm(9))
head(DF,3)
library(data.table)
DT <- data.table(x = rnorm(9),y = rep(c('a','b','c'),each = 3),
                 z = rnorm(9))
head(DT,3)
#see all the tables in memory
tables()
#Calculating values for variables with expressions
DT[,list(mean(x),sum(z))]
#both of them has same result below functions
table(DF$y)
DT[,table(y)]
table(DT$y)
#Adding new column
DT[,w:=z^2]
DT
#Logical operation for new variables
DT[,a:=x>0]
DT
#Merge data.table
DT1 <- data.table(x = c ('a','a','b','dt1'),y = 1:4)
DT2 <- data.table(x = c('a','b','dt2'),z = 5:7)
setkey(DT1 ,x);setkey(DT2 ,x)
merge(DT1,DT2)
#Data.table_sort_with_data.frame
class(market)
data.table::fsort(market$hd)
#Sub-setting and sorting
#consider the data frame
set.seed(13435)
x <- data.frame('var1'= sample(1:5),'var2' = sample(6:10),'var3' = sample(11:15))
x <- x[sample(1:5),];x$var2[c(1,3)] = NA
x
#Sub-setting and sorting(contd.)
x[,1]
x[,'var1']
x[1:2,'var2']
#Logical operation for sub-setting
#AND Operator 
x[(x$var1 <= 3 & x$var3 > 11),]
#OR Operator
x[(x$var1 <= 3 | x$var3 > 15),]
#sorting syntax
sort(x$var1)
sort(x$var1,decreasing = TRUE)# decreasing mean descending order=TRUE
sort(x$var2,na.last = TRUE)# na.last mean NA will be on the last place
#ordering in data frame
x[order(x$var1),]
x[order(x$var1,x$var3),]
#applying order in data frame
DT[order(DT$x),]
DT[order(DT$y),]
DT[order(-DT$y),]#now i want y in descending order
DT[order(-DT$y,DT$z),]
########Missing Values########
#Test for missing values
x <- c(1:4,NA,6:7,NA)
is.na(x)
#Data frame with missing Data
df <- data.frame(col1=c(1:3,NA),col2=c('this',NA,'is','text'),
                 col3=c(TRUE,FALSE,TRUE,FALSE),col4=c(2.5,4.2,3.2,NA),stringsAsFactors = FALSE)
#identify NAs in full data frame
is.na(df)
#identify NAs in specific Data frame column
is.na(df$col1)
#To identify the location or the number of NAs we can leverage the which() and sum() functions
#identify location of NAs in vector
which(is.na(x))
#identify counts of NAs in data frame
sum(is.na(df))
#For data frame ,a convenient shortcut to compute the total missing values in each column is to use colSums()
colSums(is.na(df))
#Recode/impute missing values
x <- c(1:4,NA,6:7,NA)
x[is.na(x)] <- mean(x,na.rm = TRUE)
x
round(x,2)
#Data frame that code missing value as 99
dataframe <- data.frame(col1=c(1:3,99),col2=c(2.5,4.2,99,3.2))
dataframe[dataframe == 99] <- NA #change 99s to NAs
dataframe
#Data frame with missing data
df <- data.frame(col1=c(1:3,NA),col2=c('this',NA,'is','text'),
                 col3=c(TRUE,FALSE,TRUE,FALSE),col4=c(2.5,4.2,3.2,NA),stringsAsFactors = FALSE)
df$col4[is.na(df$col4)] <- mean(df$col4,na.rm = TRUE)
df
#Exclude Missing Values
#a vector with missing values
x <- c(1:4,NA,6:7,NA)
#including NA values will produce an NA output
mean(x)
#excluding NA values will calculate the mathematical operations for all non missing values
mean(x,na.rm=TRUE)
# if we need a case from the data frame which is complete
complete.cases(df)
complete.cases(x)#we can apply this on vector
#subset with complete.cases to get complete cases
df[complete.cases(df),]
#or subset with ! to get incomplete cases
df[!complete.cases(df),]
# or use na.omit() to get the same as above
na.omit(df)
##############EXERCISE##########
#How many missing values are built-in dataset airquality (datasets::airquality)?
datasets::airquality
DS <- airquality
sum(is.na(DS))
#Which variables are the missing values concentrated in?
colSums(is.na(DS))
#How would you impute the mean or median in these values?
#Imputing in Ozone
DS$Ozone[is.na(DS$Ozone)] <- mean(DS$Ozone,na.rm = TRUE)
#Imputing in solar.R
DS$Solar.R[is.na(DS$Solar.R)] <- mean(DS$Solar.R,na.rm = TRUE)
DS
#How do you omit all rows containing missing values?
na.omit(DS)
#######Split and Apply Functions#####
#Sum/Mean by categorical values
head(InsectSprays)
tapply(InsectSprays$count, InsectSprays$spray,sum)#can be very useful for NA treatment
#split data into vectors given a variable
splns = split(InsectSprays$count,InsectSprays$spray)
splns
#Another way to apply sum
sprcount = lapply(splns,sum)
sprcount
#Another way to apply sum (contd.)
unlist(sprcount)
sapply(splns,sum)
################Merge/Join Data Frames##############
#combine two data frames by columns
#cbind in r - data for example
activity <- data.frame(opid = c('op01','op02','op03',
                                'op04','op05','op06','op07'),
                       units=c(23,43,221,32,13,12,32))
names <- data.frame(operator = c('Lary','Curly','Moe','Jack','Jill','Kim','Perry'))
blended <- cbind(activity,names)
blended
sourceofhire <- data.frame(found = c('Movie','Movie','Movie','Book','Book','TV','TV'))
blended <- cbind(activity,names,sourceofhire)
blended
#joining rows rbind
rblended <- rbind(blended,blended)
rblended
#Merge /Join Datasets
names(reviews) 
names(solutions)
mergedData <- merge(reviews,solutions,by.x = 'solution_id',by.y = 'id',all = TRUE)
head(mergedData)
#try and inspect the following code
#need some data to play with
df1 <- data.frame(LETTERS,dfindex = 1:26)
df2 <- data.frame(letters,dfindex = c(1:10,15,20,22:35))
#Inner joins:return rows when there is a match in both tables.
merge(df1,df2)#NATURAL JOIN
#Full(outro) join : all the records from both the tables and fill in null for missing matches on either side.
merge(df1,df2,all = TRUE)#FULL OUTER JOIN
merge(df1,df2,all.X = TRUE)#LEFT OUTER JOIN
merge(df1,df2,all.y = TRUE)#RIGHT OUTER JOIN
#what if columns names don't match?
names(df1) <- c('alpha','lotsaNumbers')
merge(df1,df2,by.x = 'lotsaNumbers',by.y = 'dfindex')
##############TIDYVERSE##############
install.packages('tidyverse')
install.packages('tidyr')
install.packages('ggplot2')
library(tidyr)
library(dplyr)
library(ggplot2)
library(tidyverse)
#read data
msleep <- read.csv("msleep-200908-125135.csv" )# in working directory
head(msleep)
#select()
sleeptime <- select(msleep, ?..name ,sleep_total)
head(sleeptime)
#filter()
filter(msleep,order == 'Carnivora')
#group_by()
grouping <- group_by (msleep,genus)
levels(grouping$genus)
#mutate()
avgsleep <- mutate(msleep,avg_sleep = sleep_total * 2)
head(avgsleep)
#########The pipeline function %>%###########
library(datasets)
head(mtcars)
mtcars %>%
     group_by(cyl) %>%
     summarise(mean=mean(disp),n=n())
#the power of pipeline
sub_m <- mtcars %>% 
     select(mpg,cyl,disp,hp,gear,carb) %>% 
     mutate(dispxhp = disp * hp)
names(sub_m)
table(mtcars$carb)
sub_m <- mtcars %>% select(mpg,cyl,disp,hp,gear,carb) %>% filter (carb %in% c(4,2,1))
table(sub_m$carb)
mtcars %>% 
     select(mpg,cyl,disp,hp,gear,carb) %>% 
     filter (carb %in% c(4,2,1)) %>%
     group_by (cyl) %>%
     summarize(hp_mean=mean(hp),disp_mean=mean(disp),n=n())
#Example for mutate ifelse:-
#In tandem: mutate() and ifelse() cont.
#Example
section <-c('Math111','Math111','Eng111')
grade <-c(78,93,56)
student <- c('omer','osman','hamza')
gradebook <- data.frame(section,grade,student)
mutate(gradebook,Pass.Fail = ifelse (grade > 60,'Pass','Fail'))
mutate(gradebook,Letter = ifelse(grade %in% 60:69,'D',ifelse
                                 (grade %in% 70:79 ,'C',ifelse
                                      (grade %in% 80:89 ,'B',ifelse
                                           (grade %in% 90:99,'A','F')))))
grepl("Math", gradebook$section)
mutate(gradebook,Department = ifelse(grepl('Math',section),'Math_Deparment',
                                     ifelse(grepl('Eng',section),'Eng_Department','other')))

mutate(gradebook,Department = ifelse(grepl('Math',section),'Math_Deparment',
                                     ifelse(grepl('Comp',section),'Comp_Department','other')))
############TIDYR##########
library(tidyr)
library(dplyr)
#SEPARATE()
#you can use a separate to split a single columns into multiples based on a separator.
df <- data.frame(x = c("a:1","a:2","c:4","d:4"))
df
df %>% separate(x , c("key","value"),":") %>% str
#SPREAD()
#spread can spread a categorical variable across other variables
data <- data.frame(variable1 = rep(LETTERS[1:3],each = 3),
                   variable2 = rep(paste0("Factor",c(1,2,3)),3),
                   num = 1:3)
head(data)
spread(data,variable2,num)
#gather()
#You can use gather() to group together data as key-value pairs.
head(iris)
mini_iris <- 
     iris %>%
     group_by(Species) %>%
     slice(1)
mini_iris
mini_iris %>% gather(key='flower_att',value = 'measurement',-Species)
#Unite()
#you can use unite to merge together columns in a dataset
head(mtcars)
merged <- unite(mtcars,"vs_am",c("vs","am"))
head(merged)
#####################Dealing with Text Data#########################
#tolower() Function
if(!file.exists("./Data"))
     fileurl <- "https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2020-financial-year-provisional/Download-data/annual-enterprise-survey-2020-financial-year-provisional-csv.csv"
download.file(fileurl,destfile ="./Data/annural_enterprise_survey_m.csv",method = "curl")
surveyData <- read.csv("./Data/annural_enterprise_survey_m.csv")
names(surveyData)
tolower(names(surveyData))
#strsplit()
#good for automatically splitting variable names
splitNames <- strsplit(names(surveyData),"\\_")#if there "." then put "."
splitNames[[5]]
splitNames[[6]]
#Fixing character vectors sapply()
#applies a function to each element in a vector or list
splitNames[6][1]
first_element <- function(x){x[1]}
sapply(splitNames,first_element)
#########tm(Text Mining)Library###########
install.packages('tm')
library(tm)
sentence <-c("this is my 1st example.","A person is nice.","WE CAN DIVIDE 10 by 2","Ahmed is a gentle man")
txt <- Corpus(VectorSource(sentence))
txt_data <- tm_map(txt,stripWhitespace)
txt_data <- tm_map(txt_data,tolower)
txt_data <- tm_map(txt_data,removeNumbers)
txt_data <- tm_map(txt_data,removePunctuation)
txt_data <- tm_map(txt_data,removeWords,stopwords("english"))
#user define words to remove
txt_data <- tm_map(txt_data,removeWords, c('this','is','by','a','my'))
df <- data.frame(cln_txt = unlist(txt_data),stringsAsFactors = F)
df$cln_txt
##############################WordCloud##########################
install.packages("wordcloud")
library(wordcloud)
#create a wordcloud visual
wordcloud(txt_data)
#from survey data
d <-read.csv("./msleep_ggplot2.csv")
names(d)
wd <- d$name
wordcloud(wd,scale=c(5,0.5),random.order=FALSE,
          rot.per=0.35,use.r.layout=FALSE,
          colors=brewer.pal(8,"Dark2"))

?split

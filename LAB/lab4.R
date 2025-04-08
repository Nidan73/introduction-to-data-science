#list

g <- "My first List"
h <- c(25,26,18,39)
j <- matrix(1:10, nrow=5)
k <- c("one","two","three")
mylist <- list(title=g , ages=h,j,k)
mylist

#user value input from readline 

var1 = readline(prompt = "enter any value : ")
var2 = as.integer(var2)

print(var1)
print(var2)

# using scan function 

x = scan()
print(x)

#using text editor

mydata <- data.frame(age=numeric(0), gender=character(0), weight=numeric(0))
mydata <- edit(mydata)
mydata

# Reading Data from a csv file

file_path <- "D:/iris.csv"
has_header <- TRUE
delimiter <- ","
a <- read.csv(file = file_path, header = has_header, sep = delimiter)


b <- read.csv("D:/iris.csv", header = TRUE, sep = ",")

print(b)

b[5:10,]

b$variety

subset(b,variety=="Versicolor")

install.packages("dplyr")

#loading dplyr library

library(dplyr)


#using filter function of dplyr

stats <- data.frame(
  player = c('A', 'B', 'C', 'D','A','A'),
  runs = c(100, 200, 408, 19 , 56 , 100),
  wickets = c(17, 20, NA, 5 , 2 ,17)
)

filter(stats, runs >= 100)

distinct(stats)

distinct(stats,player, .keep_all = TRUE )

arrange(stats,runs)

mutate(stats, avg = runs/4)

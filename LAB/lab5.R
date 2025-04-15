file_path <- "D:/iris.csv"
has_header <- TRUE
delimiter <- ","
a <- read.csv(file = file_path, header = has_header, sep = delimiter)


b <- read.csv("D:/iris.csv", header = TRUE, sep = ",")


print(b)

vars <- c("sepal.length","sepal.width","petal.length","petal.width")

head(b[vars])

summary(b[vars])

b$variety <- factor(b$variety,
                    levels = c("Setosa","Versicolor","Virginica"),
                    labels=c(1,2,3))

b$variety

s<- b$sepal.length
sd(s)


is.na(b)
colSums(is.na(b))
rowSums(is.na(b))
which(is.na(b$petal.width))

remove <- na.omit(b)

b

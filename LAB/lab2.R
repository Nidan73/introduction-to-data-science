switch (3,"Red","Green","Blue")


i <- 1

while(i<6) {
  print(i)
  i <- i+1
}

while(i<6) {
  print(i)
  i <- i+1
  if(i ==4){
    break
  }
}

y <- 0

while(y<6) {
  y <- y+1
  if(y == 3){
    next
  }
  print(y)
}

for (x in 1:10){
  print(x)
}

for (x in 1:10){
  
  for(y in 1:20){
  print(y)
  }
}


add_numbers <- function(a,b){
  sum <- a+b
  return(sum)
}
print(add_numbers(2,3))


a <- c(1,2,4,6,-10)
b <- c("Red","Green","Blue")
c <- c(TRUE,FALSE,FALSE,TRUE)

a
b
c

x <- c(10,4,5,7)
x+2

sort(x)
sort(b , decreasing = TRUE)

x[2]


  
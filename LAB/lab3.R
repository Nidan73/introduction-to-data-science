#..............Matrix.............


cells <- c(1:5)
rnames <- c("R1","R2","R3","R4","R5")
cnames <- c("C1","C2","C3","C4","C5")
mymatrix <- matrix(cells , nrow = 5 , ncol = 5 , byrow = TRUE , dimnames = list(rnames,cnames))

mymatrix



IDs <- as.character(c(101, 102, 103, 104, 105))
Names <- c("Alice", "Bob", "Charlie", "David", "Eve")


final_matrix <- matrix("", nrow = 5, ncol = 2, dimnames = list(rnames, c("ID", "Name")))

final_matrix[,1] <- IDs
final_matrix[,2] <- Names

print(final_matrix)

final_matrix [1,2]
final_matrix [2,1]

c(final_matrix[1,2], final_matrix[2,1])


#..............ARRAY.............


myarray <- array( 1:24 , c(2,3,4))
myarray

#..............DATA FRAMES.............


patientID <- c(1,2,3,4)
age <- c(25,34,29,32)
diabetes <- c("Type1","Type2","Type2","Type1")
status <- c("Poor","Improved","excellent","Poor")
patientData <- data.frame(patientID,age,diabetes,status)
patientData

patientData[,1]

patientData[c("diabetes","status")]


patientData <- cbind(patientData, BloodGroup = c("A", "B", "C", "D"))


patientData


newRow <- data.frame(patientID = 5, age = 40, diabetes = "Type1", status = "Good" , BloodGroup = "A-")

patientData <- rbind(patientData, newRow)
patientData



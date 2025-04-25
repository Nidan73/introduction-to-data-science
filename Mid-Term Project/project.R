
install.packages("naniar")
library(naniar)
library(readr)
library(dplyr)


AllData <- read.csv("/Users/islam/Downloads/Data_Science/Data science LAb/Dataset(Updated)_MIdterm_sectoin(F).csv", header = TRUE, sep = ",")
AllData


head(AllData)
tail(AllData)
summary(AllData)
sapply(AllData, function(x) sum(is.na(x)))



#replace empty row by NA in cetegorical column
AllData$gender[AllData$gender == ""] <- NA
AllData$smoking_history[AllData$smoking_history == ""] <- NA
AllData$gender
AllData$smoking_history



# used discard instances
Discard_Instances<- na.omit(AllData)
write.csv(Discard_Instances, "/Users/islam/Downloads/Data_Science/Data science LAb/Discard_instatnse.csv", row.names = FALSE)
Discard_Instances



#invalid value
AllData$blood_glucose_level <- parse_number(as.character(AllData$blood_glucose_level))
AllData
unique_values <- unique(AllData$gender)
unique_values
AllData$gender[AllData$gender %in% c("Malee")] <- "Male"
AllData$gender[AllData$gender %in% c("Femalee")] <- "Female"
AllData




#numeric empty column replace by mean value
numeric_columns <- sapply(AllData,is.numeric)
mean_data <- AllData
mean_data[numeric_columns] <- lapply(AllData[numeric_columns], abs)
mean_data[numeric_columns] <-lapply(mean_data[numeric_columns], function(x) ifelse(is.na(x),mean(x,na.rm=TRUE),x))
mean_data
write.csv(mean_data,"/Users/islam/Downloads/Data_Science/Data science LAb/replace_by_mean.csv",row.names = FALSE)




#numeric empty column replace by median value
median_data <- AllData
median_data[numeric_columns] <- lapply(AllData[numeric_columns], abs)
median_data[numeric_columns] <-lapply(median_data[numeric_columns], function(x) ifelse(is.na(x),median(x,na.rm=TRUE),x))
median_data
write.csv(median_data,"/Users/islam/Downloads/Data_Science/Data science LAb/replace_by_median.csv",row.names = FALSE)




#Find age feature average value
mean_data_age <- AllData
mean_data_age$age <- abs(mean_data_age$age)
age_mean <- round(mean(mean_data_age$age, na.rm = TRUE))
mean_data_age$age[is.na(mean_data_age$age)] <- age_mean
mean_data_age




#Find bmi feature average value
mean_data_bmi <- mean_data_age
mean_data_bmi$bmi <- abs(mean_data_bmi$bmi)
bmi_mean <- round(mean(mean_data_bmi$bmi, na.rm = TRUE))
mean_data_bmi$bmi[is.na(mean_data_bmi$bmi)] <- bmi_mean
mean_data_bmi




#Find gender feature most frequency
categorical_columns <- mean_data_bmi
gender_frequency <- table(mean_data_bmi$gender)
most_frequent_gender <- names(gender_frequency)[which.max(gender_frequency)]
categorical_columns$gender[is.na(mean_data_bmi$gender)] <- most_frequent_gender
categorical_columns




#Find smoking_history features most frequency
smoking_history_frequency <- table(mean_data_bmi$smoking_history)
most_frequent_smoking_history <- names(smoking_history_frequency)[which.max(smoking_history_frequency)]
categorical_columns$smoking_history[is.na(mean_data_bmi$smoking_history)] <- most_frequent_smoking_history
categorical_columns




#Find hypertension features most frequency
hypertension_frequency <- table(mean_data_bmi$hypertension)
most_frequent_hypertension <- names(hypertension_frequency)[which.max(hypertension_frequency)]
categorical_columns$hypertension[is.na(mean_data_bmi$hypertension)] <- most_frequent_hypertension
categorical_columns
write.csv(categorical_columns,"/Users/islam/Downloads/Data_Science/Data science LAb/replace_for_categorical.csv",row.names = FALSE)

cleaned_data <- categorical_columns



#missing value graph
gg_miss_var(AllData)




#outlier for age
outlier <- read.csv("/Users/islam/Downloads/Data_Science/Data science LAb/replace_for_categorical.csv", header = TRUE, sep = ",")
Q1_age <- quantile(outlier$age, 0.25)
Q3_age <- quantile(outlier$age, 0.75)
IQR_value_age <- Q3_age - Q1_age

lower_bound <- Q1_age - 1.5 * IQR_value_age
upper_bound <- Q3_age + 1.5 * IQR_value_age

outliers_age <- outlier[outlier$age < lower_bound | outlier$age > upper_bound, ]
outliers_age
removed_outliers_age <- outlier[outlier$age >= lower_bound & outlier$age <= upper_bound, ]
removed_outliers_age
write.csv(removed_outliers_age,"/Users/islam/Downloads/Data_Science/Data science LAb/after_remove_age_outliers.csv",row.names = FALSE)




#outlier for bmi
outlier_2 <- read.csv("/Users/islam/Downloads/Data_Science/Data science LAb/after_remove_age_outliers.csv", header = TRUE, sep = ",")
Q1_bmi <- quantile(outlier_2$bmi, 0.25)
Q3_bmi <- quantile(outlier_2$bmi, 0.75)
IQR_value_bmi <- Q3_bmi - Q1_bmi

lower_bound_bmi <- Q1_bmi - 1.5 * IQR_value_bmi
upper_bound_bmi <- Q3_bmi + 1.5 * IQR_value_bmi

outliers_bmi <- outlier_2[outlier_2$bmi < lower_bound_bmi | outlier_2$bmi > upper_bound_bmi, ]
outliers_bmi
removed_outliers_bmi <- outlier_2[outlier_2$bmi >= lower_bound_bmi & outlier_2$bmi <= upper_bound_bmi, ]
removed_outliers_bmi
write.csv(removed_outliers_bmi,"/Users/islam/Downloads/Data_Science/Data science LAb/after_remove_bmi_outliers.csv",row.names = FALSE)


#outlier for blood_glucose_level cloumn
outlier_3 <- read.csv("/Users/islam/Downloads/Data_Science/Data science LAb/after_remove_bmi_outliers.csv", header = TRUE, sep = ",")

Q1_blood_glucose_level <- quantile(outlier_3$blood_glucose_level, 0.25)
Q3_blood_glucose_level <- quantile(outlier_3$blood_glucose_level, 0.75)
IQR_value_blood_glucose_level <- Q3_blood_glucose_level - Q1_blood_glucose_level

lower_bound_blood_glucose_level <- Q1_blood_glucose_level - 1.5 * IQR_value_blood_glucose_level
upper_bound_blood_glucose_level <- Q3_blood_glucose_level + 1.5 * IQR_value_blood_glucose_level

outliers_blood_glucose_level <- outlier_3[outlier_3$blood_glucose_level < lower_bound_blood_glucose_level | 
                                            outlier_3$blood_glucose_level > upper_bound_blood_glucose_level, ]
outliers_blood_glucose_level

removed_outliers_blood_glucose_level <- outlier_3[outlier_3$blood_glucose_level >= lower_bound_blood_glucose_level &
                                                    outlier_3$blood_glucose_level <= upper_bound_blood_glucose_level, ]
removed_outliers_blood_glucose_level
write.csv(removed_outliers_blood_glucose_level, "/Users/islam/Downloads/Data_Science/Data science LAb/after_remove_blood_glucose_level_outliers.csv", row.names = FALSE)



# categorical to numerical or numerical to categorical
convert_atribute <- categorical_columns

convert_atribute$gender<- factor(categorical_columns$gender, levels = c("Male", "Female"), labels = c(1, 0))
convert_atribute$smoking_history <- factor(categorical_columns$smoking_history, levels = c("never", "current", "former", "not current", "ever", "No Info"), labels = c(1, 2, 3, 4, 5, 6))
convert_atribute$hypertension <- factor(categorical_columns$hypertension, levels = c(0, 1), labels = c("NO" , "YES"))
convert_atribute$diabetes <- factor(categorical_columns$diabetes, levels = c(0, 1), labels = c( "positive", "negative"))
convert_atribute
write.csv(convert_atribute, "/Users/islam/Downloads/Data_Science/Data science LAb/categorical_to_numerical_numerical_to_categorical.csv", row.names = FALSE)



# remove duplecate
duplicate <- categorical_columns

clean_duplicate <- duplicate[!duplicated(duplicate), ]
clean_duplicate
write.csv(clean_duplicate, "/Users/islam/Downloads/Data_Science/Data science LAb/remove_duplicate.csv", row.names = FALSE)







unique_values <- unique(AllData$gender)
unique_values

missing_gender <- filter(AllData, AllData$gender == "")

negetive_age <- filter(AllData, AllData$age < 0)
negetive_age


#--------------------------------------



library(dplyr)
library(readr)


data <- read.csv("C:/Users/Nidan Alam/Downloads/remove_duplicate.csv", header = TRUE)



data$gender <- as.factor(data$gender)


gender_age_stats <- data %>%
  group_by(gender) %>%
  summarise(
    Mean_Age = mean(age, na.rm = TRUE),
    Median_Age = median(age, na.rm = TRUE),
    Mode_Age = as.numeric(names(sort(table(age), decreasing = TRUE)[1]))
  )

print("Central Tendencies of Age by Gender:")
print(gender_age_stats)


data$hypertension <- as.factor(data$hypertension)

hypertension_age_stats <- data %>%
  group_by(hypertension) %>%
  summarise(
    Mean_Age = mean(age, na.rm = TRUE),
    Median_Age = median(age, na.rm = TRUE),
    Mode_Age = as.numeric(names(sort(table(age), decreasing = TRUE)[1]))
  )


print("Central Tendencies of Age by Hypertension:")
print(hypertension_age_stats)







data$gender <- as.factor(data$gender)


gender_age_spread <- data %>%
  group_by(gender) %>%
  summarise(
    Min_Age = min(age, na.rm = TRUE),
    Max_Age = max(age, na.rm = TRUE),
    Range_Age = max(age, na.rm = TRUE) - min(age, na.rm = TRUE),
    IQR_Age = IQR(age, na.rm = TRUE),
    Variance_Age = var(age, na.rm = TRUE),
    SD_Age = sd(age, na.rm = TRUE)
  )


print("Spread of Age by Gender:")
print(gender_age_spread)

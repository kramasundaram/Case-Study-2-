library(randomForest)
library(pROC)

# Read the data from file
BearingWear <- read.csv("C:\\Users\\KRamasundaram\\Documents\\MSDS 6306\\Case Study 2\\Data Set\\Bearing_Wear.csv")
head(BearingWear)
Cavitation <- read.csv("C:\\Users\\KRamasundaram\\Documents\\MSDS 6306\\Case Study 2\\Data Set\\Cavitation.csv")
ClosedPressure <- read.csv("C:\\Users\\KRamasundaram\\Documents\\MSDS 6306\\Case Study 2\\Data Set\\Closed_pressure_side.csv")
ClosedSuction <- read.csv("C:\\Users\\KRamasundaram\\Documents\\MSDS 6306\\Case Study 2\\Data Set\\Closed_Suction_Side.csv")
CouplingWear <- read.csv("C:\\Users\\KRamasundaram\\Documents\\MSDS 6306\\Case Study 2\\Data Set\\Coupling_Wear.csv")
Imbalance <- read.csv("C:\\Users\\KRamasundaram\\Documents\\MSDS 6306\\Case Study 2\\Data Set\\Imbalance.csv")
Misalignment <- read.csv("C:\\Users\\KRamasundaram\\Documents\\MSDS 6306\\Case Study 2\\Data Set\\Misalignment.csv")
Normal_Ops <- read.csv("C:\\Users\\KRamasundaram\\Documents\\MSDS 6306\\Case Study 2\\Data Set\\Normal_Operation.csv")

# Additional data received from the pumps in the field
field_cav <- read.csv("C:\\Users\\KRamasundaram\\Documents\\MSDS 6306\\Case Study 2\\Data Set\\Cavitation_2.csv")
field_coup <- read.csv("C:\\Users\\KRamasundaram\\Documents\\MSDS 6306\\Case Study 2\\Data Set\\Coupling_Wear_2.csv")
field_mis <- read.csv("C:\\Users\\KRamasundaram\\Documents\\MSDS 6306\\Case Study 2\\Data Set\\Misalignment_2.csv")

# Added a column for outcome
BearingWear$Outcome <- c("Bearing Wear")
Cavitation$Outcome <- c("Cavitation")
ClosedPressure$Outcome <- c("Closed Pressure Side")
ClosedSuction$Outcome <- c("Closed Suction Side")
CouplingWear$Outcome <- c("Coupling Wear")
Imbalance$Outcome <- c("Imbalance")
Misalignment$Outcome <- c("Misalignment")
Normal_Ops$Outcome <- c("Normal")
field_cav$Outcome <- c("Cavitation")
field_pump_data$Outcome <- c("Normal")
field_coup$Outcome <- c("Coupling Wear")
field_mis$Outcome <- c("Misalignment")
BearingWear$Outcome <- c(1)
Cavitation$Outcome <- c(2)
ClosedPressure$Outcome <- c(3)
ClosedSuction$Outcome <- c(4)
CouplingWear$Outcome <- c(5)
Imbalance$Outcome <- c(6)
Misalignment$Outcome <- c(7)
Normal_Ops$Outcome <- c(8)
field_pump_data$Outcome <- c(1)
field_cav$Outcome <- c(2)
field_coup$Outcome <- c(5)
field_mis$Outcome <- c(7)

# Splitting the data for validation and model building
Bearing_val_data <- BearingWear[c(1:as.integer(0.2*nrow(BearingWear))) ,]
Cavitation_val_data <- Cavitation[c(1:as.integer(0.2*nrow(Cavitation))) ,]
ClosedPressure_val_data <- ClosedPressure[c(1:as.integer(0.2*nrow(ClosedPressure))) ,]
ClosedSuction_val_data <- ClosedSuction[c(1:as.integer(0.2*nrow(ClosedSuction))) ,]
CouplingWear_val_data <- CouplingWear[c(1:as.integer(0.2*nrow(CouplingWear))) ,]
Imbalance_val_data <- Imbalance[c(1:as.integer(0.2*nrow(Imbalance))) ,]
Misalignment_val_data <- Misalignment[c(1:as.integer(0.2*nrow(Misalignment))) ,]
Normal_val_data <- Normal_Ops[c(1:as.integer(0.2*nrow(Normal_Ops))) ,]


# combine all validation data
validation_data <- rbind (Bearing_val_data, Cavitation_val_data)
validation_data <- rbind(validation_data, ClosedPressure_val_data)
validation_data <- rbind(validation_data, ClosedSuction_val_data)
validation_data <- rbind(validation_data, CouplingWear_val_data)
validation_data <- rbind(validation_data, Imbalance_val_data)
validation_data <- rbind(validation_data, Misalignment_val_data)
validation_data <- rbind(validation_data, Normal_val_data)

# Total number of cross validation data
dim(validation_data)

# Model data
Bearing_mod_data <- BearingWear[c(1:as.integer(0.8*nrow(BearingWear))) ,]
Cavitation_mod_data <- Cavitation[c(1:as.integer(0.8*nrow(Cavitation))) ,]
ClosedPressure_mod_data <- ClosedPressure[c(1:as.integer(0.8*nrow(ClosedPressure))) ,]
ClosedSuction_mod_data <- ClosedSuction[c(1:as.integer(0.8*nrow(ClosedSuction))) ,]
CouplingWear_mod_data <- CouplingWear[c(1:as.integer(0.8*nrow(CouplingWear))) ,]
Imbalance_mod_data <- Imbalance[c(1:as.integer(0.8*nrow(Imbalance))) ,]
Misalignment_mod_data <- Misalignment[c(1:as.integer(0.8*nrow(Misalignment))) ,]
Normal_mod_data <- Normal_Ops[c(1:as.integer(0.8*nrow(Normal_Ops))) ,]


# consolidate all lmodel data
model_data <- rbind (Bearing_mod_data, Cavitation_mod_data)
model_data <- rbind(model_data, ClosedPressure_mod_data)
model_data <- rbind(model_data, ClosedSuction_mod_data)
model_data <- rbind(model_data, CouplingWear_mod_data)
model_data <- rbind(model_data, Imbalance_mod_data)
model_data <- rbind(model_data, Misalignment_mod_data)
model_data <- rbind(model_data, Normal_mod_data)
model_data <- rbind(model_data, field_pump_data[c(1:1499) ,])
model_data <- rbind(model_data, field_cav[c(1:as.integer(0.2*nrow(field_cav))) ,])
head(model_data)

# Total number of model data
dim(model_data)

# Make the colunn names match the field data set
colnames(field_pump_data) <- colnames(validation_data)
colnames(field_coup) <- colnames(validation_data)

# Build the model using minimum number of sensors and exclude the outcomes
M <- model_data[, c(-1, -2, -c(3:16), -38)] 
L <- as.factor(model_data[, 38]) #labels, so select only target i.e. outcome

# trainig and testing
pump.rf <- randomForest(M, L, ntree = 10)

# evaluating the model
pump.rf
pump.rf$importance

# predicting on corss validataion data
pred <- as.data.frame(predict(pump.rf, validation_data[, c(-1, -2, -c(3:16) -38)]))


# plot the prediction
plot(validation_data[, 38], as.numeric(pred[,1]))



# predicitng caviation failure
pred_cav <- as.data.frame(predict(pump.rf, field_cav[c(2:14000), c(-1, -2, -(3:16),-38)]))
colnames(pred_field) <- c("Outcome")
plot(as.numeric(pred_field$Outcome))

# predicting misalignment failure
pred_misalignment <- as.data.frame(predict(pump.rf, field_mis[c(2:820), c(-1, -2, -(3:16),-38)]))
colnames(pred_misalignment) <- c("Outcome")
hist( as.numeric(pred_misalignment[,1]))

# predicitng coupling failure
pred_coup <- as.data.frame(predict(pump.rf, field_coup[c(2:21300), c(-1, -2, -(3:16),-(38: )]))
colnames(pred_field) <- c("Outcome")
hist(as.numeric(pred_field$Outcome))


pred_field$anamoly <- ifelse(as.numeric(pred_field$Outcome)<8, 1, 0)
pred_misalignment$anamoly <- ifelse(as.numeric(pred_misalignment$Outcome)<8, 1, 0)
plot(pred_misalignment$anamoly)
  


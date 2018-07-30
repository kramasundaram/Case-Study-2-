library(randomForest)

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

# Added a column for outcome
BearingWear$Outcome <- c("Bearing Wear")
Cavitation$Outcome <- c("Cavitation")
ClosedPressure$Outcome <- c("Closed Pressure Side")
ClosedSuction$Outcome <- c("Closed Suction Side")
CouplingWear$Outcome <- c("Coupling Wear")
Imbalance$Outcome <- c("Imbalance")
Misalignment$Outcome <- c("Misalignment")
Normal_Ops$Outcome <- c("Normal")

str(BearingWear)

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

dim(model_data)
dim(validation_data)

M <- model_data[, c(-1, -2, -38)] #Matrix, so remove target, i.e. outcome
L <- as.factor(model_data[, 38]) #labels, so select only target i.e. outcome

# trainig and testing
pump.rf <- randomForest(M, L)

# evaluating the model
pump.rf
pump.rf$importance

pred <- predict(pump.rf, validation_data[c(1:10), c(-1, -2, -38)])
pred

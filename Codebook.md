# Codebook for Pump Anamaly Detector & Failure Prediction
## Feature Selection
The data was captured in the lab using single axis accelerometer, inlet pressure transducer, outlet pressure transducer, flow meter and temperature sensor. The data was captured every 30 seconds. The device that has accelrometer does 3rd order octave processing.

The data was generated in a lab in Germany. It was saved in csv file and sent for analysis. We could not use the files as is. We had to re-import into Excel and save it as a different csv file. The variables were separated by semicolon rather than comma. And decimal point was represented by comma rather than period. These changes were done in Excel before reading into R.

## R-code to read the data from the files
BearingWear <- read.csv("C:\\Users\\KRamasundaram\\Documents\\MSDS 6306\\Case Study 2\\Data Set\\Bearing_Wear.csv")
head(BearingWear)
Cavitation <- read.csv("C:\\Users\\KRamasundaram\\Documents\\MSDS 6306\\Case Study 2\\Data Set\\Cavitation.csv")
ClosedPressure <- read.csv("C:\\Users\\KRamasundaram\\Documents\\MSDS 6306\\Case Study 2\\Data Set\\Closed_pressure_side.csv")
ClosedSuction <- read.csv("C:\\Users\\KRamasundaram\\Documents\\MSDS 6306\\Case Study 2\\Data Set\\Closed_Suction_Side.csv")
CouplingWear <- read.csv("C:\\Users\\KRamasundaram\\Documents\\MSDS 6306\\Case Study 2\\Data Set\\Coupling_Wear.csv")
Imbalance <- read.csv("C:\\Users\\KRamasundaram\\Documents\\MSDS 6306\\Case Study 2\\Data Set\\Imbalance.csv")
Misalignment <- read.csv("C:\\Users\\KRamasundaram\\Documents\\MSDS 6306\\Case Study 2\\Data Set\\Misalignment.csv")
Normal_Ops <- read.csv("C:\\Users\\KRamasundaram\\Documents\\MSDS 6306\\Case Study 2\\Data Set\\Normal_Operation.csv")
field_cav <- read.csv("C:\\Users\\KRamasundaram\\Documents\\MSDS 6306\\Case Study 2\\Data Set\\Cavitation_2.csv")
field_coup <- read.csv("C:\\Users\\KRamasundaram\\Documents\\MSDS 6306\\Case Study 2\\Data Set\\Coupling_Wear_4.csv")
field_mis <- read.csv("C:\\Users\\KRamasundaram\\Documents\\MSDS 6306\\Case Study 2\\Data Set\\Misalignment_2.csv")


The files have the following variables in them
* Date - Date when the data was captured
* Time  - Time when the data was captured
* Vibration mm/s - Vibration of the equipment in mm/sec
* Temp. - Bearing housing temperature measured by the sensor
* CM - Condition of the equipment. This is set by the sensor based on vibration threshold set by         the user
* HF_1-5kHz - Frequency data
* Flow - Flow of liquid being pumped
* Pin - Inlet pressure of the pump
* Pout - Outlet pressuree of the pump
* FlowTemp - Temperature of the liquid being pumped
* CF_13 - Vibration Amplitude at Center frequency between 10 and 13
* CF_16 - Vibration Amplitude at Center frequency between 13 and 16
* CF_20 - Vibration Amplitude at Center frequency between 16 and 20
* CF_25 - Vibration Amplitude at Center frequency between 20 and 25
* CF_32 - Vibration Amplitude at Center frequency between 25 and 32
* CF_40 - Vibration Amplitude at Center frequency between 32 and 40
* CF_50 - Vibration Amplitude at Center frequency between 40 and 50
* CF_63 - Vibration Amplitude at Center frequency between 50 and 63
* CF_80 - Vibration Amplitude at Center frequency between 63 and 80
* CF_100 - Vibration Amplitude at Center frequency between 80 and 100
* CF_125 - Vibration Amplitude at Center frequency between 100 and 125
* CF_160 - Vibration Amplitude at Center frequency between 125 and 160
* CF_200 - Vibration Amplitude at Center frequency between 160 and 200
* CF_250 - Vibration Amplitude at Center frequency between 200 and 250
* CF_316 - Vibration Amplitude at Center frequency between 250 and 316
* CF_400 - Vibration Amplitude at Center frequency between 316 and 400
* CF_500 - Vibration Amplitude at Center frequency between 400 and 500
* CF_630 - Vibration Amplitude at Center frequency between 500 and 630
* CF_800 - Vibration Amplitude at Center frequency between 630 and 800
* CF_1000 - Vibration Amplitude at Center frequency between 800 and 1000
* CF_1250 - Vibration Amplitude at Center frequency between 1000 and 1250
* CF_1600 - Vibration Amplitude at Center frequency between 1250 and 1600
* CF_2000 - Vibration Amplitude at Center frequency between 1600 and 2000
* CF_2500 - Vibration Amplitude at Center frequency between 2000 and 2500
* CF_3150 - Vibration Amplitude at Center frequency between 2500 and 3150
* CF_4000 - Vibration Amplitude at Center frequency between 3150 and 4000
* CF_5000 - Vibration Amplitude at Center frequency between 4000 and 5000

The data set did not have outcome in it. Instead the outcome was part of the file name. The following code adds the outcome to the data sets.
BearingWear$Outcome <- c(1)
Cavitation$Outcome <- c(2)
ClosedPressure$Outcome <- c(3)
ClosedSuction$Outcome <- c(4)
CouplingWear$Outcome <- c(5)
Imbalance$Outcome <- c(6)
Misalignment$Outcome <- c(7)
Normal_Ops$Outcome <- c(8)
field_cav$Outcome <- c(2)
field_mis$Outcome <- c(7)
field_coup$Outcome <- c(5)

## R code for combing the data sets for model buidlign and cross validation
We have now read all the data and they are in different data objects. We splitted the data into two groups - one for building model and other is for validation. We used 20% of the data for validation and the balance for building the model. 

### Validation data set
Bearing_val_data <- BearingWear[c(1:as.integer(0.2*nrow(BearingWear))) ,]
Cavitation_val_data <- Cavitation[c(1:as.integer(0.2*nrow(Cavitation))) ,]
ClosedPressure_val_data <- ClosedPressure[c(1:as.integer(0.2*nrow(ClosedPressure))) ,]
ClosedSuction_val_data <- ClosedSuction[c(1:as.integer(0.2*nrow(ClosedSuction))) ,]
CouplingWear_val_data <- CouplingWear[c(1:as.integer(0.2*nrow(CouplingWear))) ,]
Imbalance_val_data <- Imbalance[c(1:as.integer(0.2*nrow(Imbalance))) ,]
Misalignment_val_data <- Misalignment[c(1:as.integer(0.2*nrow(Misalignment))) ,]
Normal_val_data <- Normal_Ops[c(1:as.integer(0.2*nrow(Normal_Ops))) ,]

validation_data <- rbind (Bearing_val_data, Cavitation_val_data)
validation_data <- rbind(validation_data, ClosedPressure_val_data)
validation_data <- rbind(validation_data, ClosedSuction_val_data)
validation_data <- rbind(validation_data, CouplingWear_val_data)
validation_data <- rbind(validation_data, Imbalance_val_data)
validation_data <- rbind(validation_data, Misalignment_val_data)
validation_data <- rbind(validation_data, Normal_val_data)

### Model Training Data Set
The following code has the data that was used for building the model.
Bearing_mod_data <- BearingWear[c(1:as.integer(0.8*nrow(BearingWear))) ,]
Cavitation_mod_data <- Cavitation[c(1:as.integer(0.8*nrow(Cavitation))) ,]
ClosedPressure_mod_data <- ClosedPressure[c(1:as.integer(0.8*nrow(ClosedPressure))) ,]
ClosedSuction_mod_data <- ClosedSuction[c(1:as.integer(0.8*nrow(ClosedSuction))) ,]
CouplingWear_mod_data <- CouplingWear[c(1:as.integer(0.8*nrow(CouplingWear))) ,]
Imbalance_mod_data <- Imbalance[c(1:as.integer(0.8*nrow(Imbalance))) ,]
Misalignment_mod_data <- Misalignment[c(1:as.integer(0.8*nrow(Misalignment))) ,]
Normal_mod_data <- Normal_Ops[c(1:as.integer(0.8*nrow(Normal_Ops))) ,]
model_data <- rbind (Bearing_mod_data, Cavitation_mod_data)
model_data <- rbind(model_data, ClosedPressure_mod_data)
model_data <- rbind(model_data, ClosedSuction_mod_data)
model_data <- rbind(model_data, CouplingWear_mod_data)
model_data <- rbind(model_data, Imbalance_mod_data)
model_data <- rbind(model_data, Misalignment_mod_data)
model_data <- rbind(model_data, Normal_mod_data)



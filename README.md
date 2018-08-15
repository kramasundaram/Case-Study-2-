# Introduction
Rotating equipment is one of the critical equipments in oil & gas, power plant, petrochemical or refinery. In most of these plants, pump is the number one maintenance items. It is important to predict anamalies and failures accurately. In this project, we took the data that was generated from the lab pump, built predictive model, validated against cross validation data and data from pumps in the field. 

## Files
The data from the following files were used for building model and cross-validation.

### \Bearing_Wear.csv
### Cavitation.csv
### Closed_pressure_side.csv
### Closed_Suction_Side.csv
### Coupling_Wear.csv
### Imbalance.csv
### Misalignment.csv
### Normal_Operation.csv

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

### Validation Data from field
* Cavitation_2.csv
* Coupling_Wear_4.csv
* Misalignment_2.csv
Data from the field has the same set of variables as the data from the lab

## Libraries
In an effort to streamline the code repository we have selected a few libraries to help with the heavy lifting:

### ggplot2
[ggplot2](http://ggplot2.tidyverse.org) is a system for declaratively creating graphics, based on The Grammar of Graphics. You provide the data, tell ggplot2 how to map variables to aesthetics, what graphical primitives to use, and it takes care of the details.

### randomForest
[randomforest] #https://cran.r-project.org/web/packages/randomForest/randomForest.pdf is for building modle using random forest. 

## Objects created
As a result of assimilating the data in a meaningful way, various objects have been created to help ensure the results and summaries are as readable as possible.


### Data Objects for building model
The following objects were data objects were created for the data from lab.
* BearingWear - lab data for bearing wear 
* Cavitation - lab data for cavitation
* ClosedPressure - lab data for closed pressure
* ClosedSuction  - lab data for closed suction
* CouplingWear  - lab data for coupling wear
* Imbalance  - lab data for imbalance
* Misalignment - lab data for misalignment
* Normal_Ops - lab data for normal operation

### Data Objects for validation
The following objects were data objects were created for the data from the pumps in the field.
* field_cav - data from the pumps in the field that experienced cavitation 
* field_coup - data from the pumps in the field that had coupling issues
* field_mis - data from the pumps in the field that had misalignment

The following objects were used to buidling and validating the models respectively. There were other data objects created. Please refer to the codebook for details.
* model_data - data that was used for building model
* validation_data - corss validation data from the lab pump



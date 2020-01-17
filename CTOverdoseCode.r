# Will Clifford
# ECON403 Econometrics I

library(car)
library(lmtest)


# Overdose data from Data.gov and the State of Maryland (See https://data.ct.gov/Health-and-Human-Services/Accidental-Drug-Related-Deaths-2012-2018/rybz-nyjw)
ods_csv <- read.csv("~/GitHub/CT-Overdose-Analysis/data/Accidental_Drug_Related_Deaths_2012-2018.csv")


###  Create New Variables
ods_csv$Female <- ifelse(ods_csv$Sex == "Female", 1, 0)

ods_csv$Black <- ifelse(ods_csv$Race == "Black", 1, 0)
ods_csv$White <- ifelse(ods_csv$Race == "White", 1, 0)
ods_csv$Hispanic <- ifelse(ods_csv$Race == "Hispanic, White" | 
                              ods_csv$Race == "Hispanic, Black", 1, 0)
ods_csv$Unknown.Other <- ifelse(ods_csv$Race == "Asian Indian" | 
                                   ods_csv$Race == "Asian, Other" | 
                                   ods_csv$Race == "Chinese" | 
                                   ods_csv$Race == "Hawaiian" | 
                                   ods_csv$Race == "Native American, Other" | 
                                   ods_csv$Race == "Other" | 
                                   ods_csv$Race == "Unknown" | 
                                   ods_csv$Race == "", 1, 0)

ods_csv$Heroin           <- ifelse(ods_csv$Heroin == "Y", 1, 0)
ods_csv$Cocaine          <- ifelse(ods_csv$Cocaine == "Y", 1, 0)
ods_csv$Fentanyl         <- ifelse(ods_csv$Fentanyl == "Y", 1, 0)
ods_csv$FentanylAnalogue <- ifelse(ods_csv$FentanylAnalogue == "Y", 1, 0)
ods_csv$Oxycodone        <- ifelse(ods_csv$Oxycodone == "Y", 1, 0)
ods_csv$Oxymorphone      <- ifelse(ods_csv$Oxymorphone == "Y", 1, 0)
ods_csv$Ethanol          <- ifelse(ods_csv$Ethanol == "Y", 1, 0)
ods_csv$Hydrocodone      <- ifelse(ods_csv$Hydrocodone == "Y", 1, 0)
ods_csv$Benzodiazepine   <- ifelse(ods_csv$Benzodiazepine == "Y", 1, 0)
ods_csv$Methadone        <- ifelse(ods_csv$Methadone == "Y", 1, 0)
ods_csv$Amphet           <- ifelse(ods_csv$Amphet == "Y", 1, 0)
ods_csv$Tramad           <- ifelse(ods_csv$Tramad == "Y", 1, 0)
ods_csv$Morphine_NotHeroin <- ifelse(ods_csv$Morphine_NotHeroin == "Y", 1, 0)
ods_csv$Hydromorphone    <- ifelse(ods_csv$Hydromorphone == "Y", 1, 0)
ods_csv$OpiateNOS        <- ifelse(ods_csv$OpiateNOS == "Y", 1, 0)

ods_csv$NumDrugs <- ods_csv$Heroin + ods_csv$Cocaine + ods_csv$Fentanyl + 
  ods_csv$FentanylAnalogue + ods_csv$Oxycodone + ods_csv$Oxymorphone + 
  ods_csv$Ethanol + ods_csv$Benzodiazepine + ods_csv$Methadone +
  ods_csv$Amphet + ods_csv$Tramad + ods_csv$Morphine_NotHeroin +
  ods_csv$Hydromorphone + ods_csv$OpiateNOS


###  Display Tables
#    Gender:
table(ods_csv$Female)
#    Race:
table(ods_csv$Race)
#    Drug:
table(ods_csv$Heroin)
table(ods_csv$Cocaine)
table(ods_csv$Fentanyl)
table(ods_csv$FentanylAnalogue)
table(ods_csv$Oxycodone)
table(ods_csv$Oxymorphone)
table(ods_csv$Ethanol)
table(ods_csv$Hydrocodone)
table(ods_csv$Benzodiazepine)
table(ods_csv$Methadone)
table(ods_csv$Amphet)
table(ods_csv$Tramad)
table(ods_csv$Morphine_NotHeroin)
table(ods_csv$Hydromorphone)
table(ods_csv$OpiateNOS)
#    Number of drugs detected after overdose
table(ods_csv$NumDrugs)


###  Create Models
#   1.  Age, All Linear
ods_lm1 <- lm(Age~Female+Black+Hispanic+Unknown.Other+Cocaine+Fentanyl+FentanylAnalogue+Oxycodone+Oxymorphone
              +Ethanol+Hydrocodone+Benzodiazepine+Methadone+Amphet+Tramad+Morphine_NotHeroin+Hydromorphone+OpiateNOS, data=ods_csv)
#   1a. Age, Race/Gender Interaction
ods_lm1a <- lm(Age~Female+Black+Hispanic+Unknown.Other + Black*Female+Hispanic*Female+Unknown.Other*Female
              +Cocaine+Fentanyl+FentanylAnalogue+Oxycodone+Oxymorphone+Ethanol+Hydrocodone+Benzodiazepine+Methadone+Amphet+Tramad
              +Morphine_NotHeroin+Hydromorphone+OpiateNOS, data=ods_csv)
#   2.  Quadratic model
ods_quad <- lm(NumDrugs~Age+I(Age^2)+Female+Black+Hispanic+Unknown.Other, data=ods_csv)


###  Display Model Summaries
bptest(ods_lm1)
coeftest(ods_lm1, hccm(ods_lm1))

bptest(ods_quad)
coeftest(ods_quad, hccm(ods_quad))
tp <- coefficients(ods_quad)["Age"]/(-2*coefficients(ods_quad)["I(Age^2)"])
perc_tp <- ifelse(tp > 0, sum(ifelse(is.na(ods_csv$Age), 0, ods_csv$Age > tp)) / length(ods_csv$Age), "Negative Turning Point")
tp
perc_tp

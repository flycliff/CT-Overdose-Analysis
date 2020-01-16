# Will Clifford
# ECON403 Econometrics I

library(car)
library(lmtest)

# Overdose data from Data.gov and the State of Maryland.
# ( See https://data.ct.gov/Health-and-Human-Services/Accidental-Drug-Related-Deaths-2012-2018/rybz-nyjw )
ods_csv <- read.csv("~/GitHub/CT-Overdose-Analysis/data/ODDeaths.csv")


#####################################################################
#                               PART 1                              #          
#####################################################################
###      TOTALS IN DATA      ###
#    Gender:
table(ods_csv$Female) # more than 75% of overdose deaths are male
#    Race:
table(ods_csv$Black)
table(ods_csv$White)
table(ods_csv$Hispanic)
table(ods_csv$Unknown.Other)
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


###          MODELS          ###
#   1.  - Age, All Linear
ods_lm1 <- lm(Age~Female+Black+Hispanic+Unknown.Other+Cocaine+Fentanyl+FentanylAnalogue+Oxycodone+Oxymorphone
              +Ethanol+Hydrocodone+Benzodiazepine+Methadone+Amphet+Tramad+Morphine_NotHeroin+Hydromorphone+OpiateNOS, data=ods_csv)
#   1a. - Age, Race/Gender Interaction
ods_lm1a <- lm(Age~Female+Black+Hispanic+Unknown.Other + Black*Female+Hispanic*Female+Unknown.Other*Female
              +Cocaine+Fentanyl+FentanylAnalogue+Oxycodone+Oxymorphone+Ethanol+Hydrocodone+Benzodiazepine+Methadone+Amphet+Tramad
              +Morphine_NotHeroin+Hydromorphone+OpiateNOS, data=ods_csv)

#   2.  - Number of Drugs by Race/Gender
ods_lm2 <- lm(NumDrugs~Age+Female+Black+Hispanic+Unknown.Other, data=ods_csv)
#   2a. - Number of drugs, Race/Gender interaction.
ods_lm2a <- lm(NumDrugs~Age+Female+Black+Hispanic+Unknown.Other+Black*Female+Hispanic*Female+Unknown.Other*Female, data=ods_csv)

###         SUMMARIES        ###
summary(ods_lm1 )
summary(ods_lm1a)
summary(ods_lm2 )
summary(ods_lm2a)


#####################################################################
#                               PART 2                              #          
#####################################################################
#   1. Test of Joint Significance
jnt_sig <- linearHypothesis(ods_lm1, c("FentanylAnalogue=0", "Oxymorphone=0", "OpiateNOS=0"))
jnt_sig

#   2. Quadratic Model
ods_quad <- lm(NumDrugs~Age+I(Age^2)+Female+Black+Hispanic+Unknown.Other, data=ods_csv)
summary(ods_quad)

tp <- coefficients(ods_quad)["Age"]/(-2*coefficients(ods_quad)["I(Age^2)"])
tp
perc_tp <- ifelse(tp > 0, sum(ods_csv$Age > tp) / length(ods_csv$Age), "Negative Turning Point")
perc_tp

##  3. Group Drugs - from part 1
summary(ods_lm1)

#   4. Test for Homoskedasticity, Interpret, and Correct (if necessary)
bptest(ods_lm1)
coeftest(ods_lm1, hccm(ods_lm1))

bptest(ods_quad)
coeftest(ods_quad, hccm(ods_quad))

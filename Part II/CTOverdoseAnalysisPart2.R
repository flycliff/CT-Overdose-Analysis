# Will Clifford
# ECON403 Econometrics I

library(car)
library(lmtest)

ods_csv <- read.csv("ODDeaths.csv")

#   1. Test of Joint Significance
ods_lm1 <- lm(Age~Female+Black+Hispanic+Unknown.Other+Cocaine+Fentanyl+FentanylAnalogue+Oxycodone+Oxymorphone+Ethanol
              +Hydrocodone+Benzodiazepine+Methadone+Amphet+Tramad+Morphine_NotHeroin+Hydromorphone+OpiateNOS, data=ods_csv)
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

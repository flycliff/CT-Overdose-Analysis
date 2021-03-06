# State of Connecticut Overdose Statistics Analysis
An econometric survey examining the interactions between race, gender, age, and overdose. Data provided by the State of Connecticut Department of Health, and accessed via Data.gov on October 15, 2019. This paper was a cumulative project over the course of a semester for RIT's course ECON403 - Econometrics I. This is my first serious attempt at a data science project.

## Results
- In determining age of death, race and drug of choice are statistically significant, while gender is not. White victims are predicted to overdose slightly earlier in life than Black and Hispanic victims. Asian victims are predicted to overdose several years earlier in life than white victims. Similar econometric studies of overdose in Connecticut have suggested that more affluent communities (which tend to have higher white populations) have better access to prescription drugs that poorer communities may not have access to. The poverty rate by race in Connecticut does not necessarily support these suggestions, however, without access to socio-economic data this study can neither confirm or deny them.

- There appears to be a correlation between the lethality of a drug and the rate of that drug's use. With that in mind, I grouped the drugs in the survey by increasing lethality and increasing rate of use:
  - Hydromorphone, Tramadol, Hydrocodone, Morphine, Oxycodone, Methadone
  - Ethanol (Alcohol), Cocaine, Benzos
  - Heroin, Fentanyl
  - Amphetamines

- In determining the number of drugs that a victim overdosed on, race and age are significant. White victims are predicted to overdose on more drugs than any other race. Between 0 and 45 years old, increased age is correlated with increased number of drugs. From 45 years old on, increased age is correlated with decreased number of drugs.

## Replicating Output
Output will be saved to a text file named "CTOverdoseCode.Rout"

Make sure you have R installed and added to your PATH. In a terminal of your choice, run the following commands:
```
git clone https://github.com/flycliff/CT-Overdose-Analysis.git
cd CT-Overdose-Analysis
R CMD BATCH CTOverdoseCode.R
```

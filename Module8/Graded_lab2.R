# 1) load data set into r 
df <- read.csv("/Users/user/Desktop/School/2021/Spring2021/BTM-6000/Module8/Module 8 - Graded Lab 2 - NHANES subset.csv")

# 2) Inspect and describe the dataset and the included parameters.
summary(df)
summary(df$SBP)
summary(df$DBP)
hist(df$SBP) 
# separate by gender df%Male ==1 is male and ==0 is female 
df$MALE<-ifelse(df$gender==1,1,0)
df$gender_factor<-factor(df$gender,levels=c(1,2),labels=c("male","female"))
hist(df$SBP[df$MALE ==1])
hist(df$SBP[df$MALE ==0])
hist(df$DBP[df$MALE ==1])
hist(df$DBP[df$MALE ==0])
summary(df$SBP[df$MALE ==1])
summary(df$DBP[df$MALE ==1])


# 3) What are the confidence intervals of all continuous variables in the overall population, males (coded as '1') and females (coded as '2')?

# All
Ttest_SBP_all <- t.test(df$SBP,mu=120,alternative= "two.sided")
paste("All",round(Ttest_SBP_all$estimate,1),"(95% CI ",round(Ttest_SBP_all$conf.int[1],1), "to", round(Ttest_SBP_all$conf.int[2],1),")")
Ttest_DBP_all <- t.test(df$DBP,mu=120)
paste("All",round(Ttest_SBP_all$estimate,1),"(95% CI ",round(Ttest_DBP_all$conf.int[1],1), "to", round(Ttest_DBP_all$conf.int[2],1),")")

# Males
Ttest_SBP_Male <- t.test(df$SBP[df$MALE == 1],mu=120)
paste("Male",round(Ttest_SBP_Male$estimate,1),"(95% CI ",round(Ttest_SBP_Male$conf.int[1],1), "to", round(Ttest_SBP_Male$conf.int[2],1),")")
Ttest_DBP_Male <- t.test(df$DBP[df$MALE ==1],mu=120)
paste("Male",round(Ttest_DBP_Male$estimate,1),"(95% CI ",round(Ttest_DBP_Male$conf.int[1],1), "to", round(Ttest_DBP_Male$conf.int[2],1),")")

# Females
Ttest_SBP_Female <- t.test(df$SBP[df$MALE == 0],mu=120)
paste("Female",round(Ttest_SBP_Female$estimate,1),"(95% CI ",round(Ttest_SBP_Female$conf.int[1],1), "to", round(Ttest_SBP_Female$conf.int[2],1),")")
Ttest_DBP_Female <- t.test(df$DBP[df$MALE ==0],mu=120)
paste("female",round(Ttest_DBP_Female$estimate,1),"(95% CI ",round(Ttest_DBP_Female$conf.int[1],1), "to", round(Ttest_DBP_Female$conf.int[2],1),")")


# 4) Compare males and females in terms blood pressures from the blood pressure of 120/80 mmHg (SBP/DBP) – are they significantly different?

# State the null-hypothesis.
#   The null hypothesis is that blood pressure is 120/80 mmHg (SBP/DBP)  for both men and woman. 
#   alternative: there is a difference in men and woman blood pressure.
t.test(df$SBP[df$gender==2],df$SBP[df$gender==1],mu=120,alternative= "two.sided")
t.test(df$DBP[df$gender==2],df$DBP[df$gender==1],mu=120,alternative= "two.sided")
# conclusion: The result of  the 2-sided t-test indicate a statistically signafcent difference between blood pressure of males and females.

# 5)  Compare the blood pressures in those older than 60 (males and females separately) from the blood pressure of 120/80 mmHg (SBP/DBP) – do they significantly differ in these sample populations?

# State the null-hypothesis.
#   The null hypothesis is that blood pressure is 120/80 mmHg (SBP/DBP) for both men and woman over the age of 60.  
#   alternative: there is a difference in men and woman blood pressure.
df$advanced_age<-ifelse(df$age>60,1,0)
df$advanced_age_factor<-factor(df$advanced_age,levels=c(0,1),labels=c("not advanced age","advanced age"))
summary(df$advanced_age_factor)
t.test(df$SBP[df$gender==2 & df$advanced_age ==1],df$SBP[df$gender==1 & df$advanced_age ==1],mu=120,alternative= "two.sided")
t.test(df$DBP[df$gender== 2 & df$advanced_age ==1],df$DBP[df$gender==1 & df$advanced_age ==1],mu=120,alternative= "two.sided")
# conclusion: The null hypotheses is rejected due to the result of the t-test. Thus we accept the alternative hypothesis there is a statistical difference between the blood pressure of men and woman over the age of 60. 


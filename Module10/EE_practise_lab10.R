#  Evan Edelstein 
# practise lab 10

library(pwr)
library(dplyr)
library(doBy)
# 1)Researchers want to compare for a planned RCT the sample sizes needed (sig level of 0.05; type =two- sided) to detect a difference with a power of 90% under the assumption of 
# 1A) a small effect size (0.2)

test <- pwr.t.test(power = 0.9,d = 0.2, sig.level = 0.05)
test$n 
# 1B) a medium effect size (0.5)
test <- pwr.t.test(power = 0.9,d = 0.5, sig.level = 0.05)
test$n
# 1C)a large effect size (0.8).
test <- pwr.t.test(power = 0.9,d = 0.8, sig.level = 0.05)
test$n
# 1D) What is the power at large effect size when 36 subjects are enrolled?
test <-pwr.t.test(n=36,d = 0.2, sig.level = 0.05)
test$power
# 2)Researchers want to compare the sample sizes needed within each group 
# when comparing 5 groups using a one-way ANOVA in a planned RCT (sig level of 0.05)'
# aiming for a power of 90% with

# 2A) a small effect size (0.2)
test <-pwr.anova.test(k=5,sig.level = 0.05,power = 0.9,f=0.2)
test$n
# 2B) a medium effect size (0.5)
test <-pwr.anova.test(k=5,sig.level = 0.05,power = 0.9,f=0.5)
test$n
# 2C) a large effect size (0.8).
test <-pwr.anova.test(k=5,sig.level = 0.05,power = 0.9,f=0.8)
test$n
# 2D) What is the power when 40 subjects are enrolled?
test <-pwr.anova.test(k=5,n=8,sig.level = 0.05,f=0.2)
test$power


# 3)NOVA: Load the dataset download into your R environment. 
df <- read.csv("/Users/user/Desktop/School/2021/Spring2021/BTM-6000/Module10/Module 10 - Practice Lab - NHANES subset.csv")

# 3A) Stratify the sample population in SBP tertiles. 
df$SBP_tertiles <- ntile(df$SBP,3)
df$SBP_tertiles_factor <- factor(df$SBP_tertiles,levels=c(1:3),labels = c("Tertile 1","Tertile 2","Tertile 3"))

# 3B) compare the age of subjects in the respective tertiles. 
summaryBy(age~SBP_tertiles_factor,data = df , FUN = c(mean,sd,min, max))
# 3C) compare the age of subjects applying Bonferroni correction
# anova test 
anova_test <- aov(df$age~df$SBP_tertiles_factor)
summary(anova_test)
# bonferroni
test <- pairwise.t.test(df$age,df$SBP_tertiles_factor,p.adjust.method = "bonferroni")
test
# Tukey
TukeyHSD(anova_test)



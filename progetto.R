
library(dplyr) #data manipulation
library(corrgram) #correlation diagram
library(patchwork) #data visualization
library(ggplot2) #data visualization
library(GGally) #correlation plot
library(gridExtra)
heart <- read.csv("C:/Users/danyb/Desktop/Daniele/Università/magistrale/DA FARE/statistical data analysis/modulo sala/progetto/heart.csv")
head(heart)

#data raw statistic for correction

summary(heart$Age)
summary(heart$RestingBP)
summary(heart$Cholesterol)
summary(heart$MaxHR)
summary(heart$Oldpeak)


#data plot distribution


ggplot(data = heart, aes(heart$Age)) + geom_density(fill = "blue") + labs(x="",title = "Age") + theme_minimal()
ggplot(data = heart,aes(heart$Sex[heart$HeartDisease=="Yes"])) + geom_bar(aes(fill = Sex)) + labs(x="",title = "Sex") + theme_minimal()
ggplot(data = heart,aes(heart$ChestPainType)) + geom_bar(aes(fill = ChestPainType)) + labs(x="",title = "Chest Pain Type") + theme_minimal()
ggplot(data = heart,aes(heart$RestingBP)) + geom_histogram(colour = "black",fill = "green") + labs(x="",title = "Resting Blood Pressure") + theme_minimal()
ggplot(data = heart,aes(heart$Cholesterol)) + geom_histogram(colour = "black",fill = "yellow") + labs(x="",title = "Cholesterol Level") + theme_minimal()
ggplot(data = heart,aes(heart$FastingBS)) + geom_bar(fill = "maroon4") + labs(x="",title = "Blood Sugar after Fasting over 120") + theme_minimal()
ggplot(data = heart,aes(heart$RestingECG)) + geom_bar(aes(fill = RestingECG)) + labs(x="",title = "Resting ECG Levels") + theme_minimal()
ggplot(data = heart,aes(heart$MaxHR)) + geom_density(fill = "brown") + labs(x="",title = "Max Heart Rate") + theme_minimal()
ggplot(data = heart,aes(heart$ExerciseAngina)) + geom_bar(aes(fill = ExerciseAngina)) + labs(x="",title = "Exercise-induced angina") + theme_minimal()
ggplot(data = heart,aes(heart$Oldpeak)) + geom_histogram(color = "black", fill = "turquoise") + labs(x="",title = "Oldpeak") + theme_minimal()
ggplot(data = heart,aes(heart$ST_Slope)) + geom_bar(aes(fill = ST_Slope)) + labs(x="",title = "ST Slope") + theme_minimal()
ggplot(data = heart,aes(heart$HeartDisease)) + geom_bar(fill = "purple") + labs(x="",title = "Heart Disease (Y/N)") + theme_minimal()
#(p1 + p2 + p3) / (p4 + p5 + p6) / (p7 + p8 + p9) / (p10 + p11 + p12) + plot_annotation(title = "Heart Disease Features")


#correction for the 0 values

#resting BP
heart$RestingBP[heart$RestingBP == 0]<- heart %>% summarise( median(RestingBP)) %>% as.numeric()

#cholesterol with mean
heart$Cholesterol[heart$Cholesterol == 0] <- heart %>% summarise( median(Cholesterol)) %>% as.numeric()

#oldpeak with mean

heart$Oldpeak[heart$Oldpeak <= 0] <- heart %>% summarise( median(Oldpeak)) %>% as.numeric()

#Plot the distribution against the Heart failure

heart %>%ggplot(aes(Age)) + geom_histogram(aes(fill = factor(HeartDisease))) + theme(legend.position='none')
heart %>% ggplot(aes(Sex)) + geom_bar(aes(fill = factor(HeartDisease))) + theme(legend.position='none')
heart %>% ggplot(aes(ChestPainType)) + geom_bar(aes(fill = factor(HeartDisease))) + theme(legend.position='none')
heart %>% ggplot(aes(RestingBP)) + geom_histogram(aes(fill = factor(HeartDisease))) + theme(legend.position='none')
heart %>% ggplot(aes(Cholesterol)) + geom_histogram(aes(fill = factor(HeartDisease))) + theme(legend.position='none')
heart %>% ggplot(aes(FastingBS)) + geom_bar(aes(fill = factor(HeartDisease))) + theme(legend.position='none')
heart %>% ggplot(aes(RestingECG)) + geom_bar(aes(fill = factor(HeartDisease))) + theme(legend.position='none')
heart %>% ggplot(aes(MaxHR)) + geom_histogram(aes(fill = factor(HeartDisease))) + theme(legend.position='none')
heart %>% ggplot(aes(ExerciseAngina)) + geom_bar(aes(fill = factor(HeartDisease))) + theme(legend.position='none')
heart %>% ggplot(aes(Oldpeak)) + geom_histogram(aes(fill = factor(HeartDisease))) + theme(legend.position='none')
heart %>% ggplot(aes(ST_Slope)) + geom_bar(aes(fill = factor(HeartDisease))) + theme(legend.position='none')

(hd1 + (hd2 + hd3)) / (hd4 + hd5 + hd6) / (hd7 + hd8 + hd9) / (hd10 + hd11) + plot_annotation(title = "HeartDisease vs other variables")

#distribution divided for healthy or non healthy
heart$HeartDisease[heart$HeartDisease==0]<-"No"
heart$HeartDisease[heart$HeartDisease==1]<-"Yes"
#Age
ggplot( data = heart, aes( x = HeartDisease, y = Age, fill = HeartDisease) ) +
  geom_boxplot()
mean(heart$Age[heart$HeartDisease=="Yes"])
sd(heart$Age[heart$HeartDisease=="Yes"])
mean(heart$Age[heart$HeartDisease=="No"])
sd(heart$Age[heart$HeartDisease=="No"])

#welch 2 sample t-test age
heart

x1 <- heart$Age[heart$HeartDisease=="No"]
x2 <- heart$Age[heart$HeartDisease=="Yes"]
t.test(x1, x2)
 




#MaxHR
ggplot( data = heart, aes( x = HeartDisease, y = MaxHR, fill = HeartDisease) ) +
  geom_boxplot()
mean(heart$MaxHR[heart$HeartDisease=="Yes"])
sd(heart$MaxHR[heart$HeartDisease=="Yes"])
mean(heart$MaxHR[heart$HeartDisease=="No"])
sd(heart$MaxHR[heart$HeartDisease=="No"])

#welch 2 sample t-test MaxHR
heart

x1 <- heart$MaxHR[heart$HeartDisease=="No"]
x2 <- heart$MaxHR[heart$HeartDisease=="Yes"]
t.test(x1, x2)


#Sex

sex_table <- table(heart$HeartDisease, heart$Sex)
sex_table

survey_data <- data.frame(sex_table)
survey_data

ggplot(data = survey_data, aes(x =Var1, y = Freq, fill = Var2)) + 
  geom_bar(stat = "identity", position = "dodge", colour = "black") + 
  scale_fill_brewer(palette = "Pastel1") +
  labs(x = "Heart Failure", y = "Counts \n", 
       title = "",
       fill = "Sex") +
  theme(plot.title = element_text(hjust = 0.5),
        axis.title.x = element_text(face="bold", colour="blue", size = 12),
        axis.title.y = element_text(face="bold", colour="blue", size = 12),
        legend.position = "bottom")

#pearson chisquare sex

chisq.test(sex_table)


#exercise angina

#pearson chi square ea
ea_table <- table(heart$HeartDisease, heart$ExerciseAngina)
ea_table


survey_data <- data.frame(ea_table)
survey_data

ggplot(data = survey_data, aes(x =Var1, y = Freq, fill = Var2)) + 
  geom_bar(stat = "identity", position = "dodge", colour = "black") + 
  scale_fill_brewer(palette = "Pastel1") +
  labs(x = "Heart Failure", y = "Counts \n", 
       title = "",
       fill = "Exercise Angina") +
  theme(plot.title = element_text(hjust = 0.5),
        axis.title.x = element_text(face="bold", colour="blue", size = 12),
        axis.title.y = element_text(face="bold", colour="blue", size = 12),
        legend.position = "bottom")




chisq.test(ea_table)




#St slope

#Person chi square sts

sts_table <- table(heart$HeartDisease, heart$ST_Slope)
sts_table


survey_data <- data.frame(sts_table)
survey_data

ggplot(data = survey_data, aes(x =Var1, y = Freq, fill = Var2)) + 
  geom_bar(stat = "identity", position = "dodge", colour = "black") + 
  scale_fill_brewer(palette = "Pastel1") +
  labs(x = "Heart Failure", y = "Counts \n", 
       title = "",
       fill = "St_slope") +
  theme(plot.title = element_text(hjust = 0.5),
        axis.title.x = element_text(face="bold", colour="blue", size = 12),
        axis.title.y = element_text(face="bold", colour="blue", size = 12),
        legend.position = "bottom")


chisq.test(sts_table)

#Chest Pain type

#Person chi square cpt

cpt_table <- table(heart$HeartDisease, heart$ChestPainType)
cpt_table


survey_data <- data.frame(cpt_table)
survey_data

ggplot(data = survey_data, aes(x =Var1, y = Freq, fill = Var2)) + 
  geom_bar(stat = "identity", position = "dodge", colour = "black") + 
  scale_fill_brewer(palette = "Pastel1") +
  labs(x = "Heart Failure", y = "Counts \n", 
       title = "",
       fill = "ChestPainType") +
  theme(plot.title = element_text(hjust = 0.5),
        axis.title.x = element_text(face="bold", colour="blue", size = 12),
        axis.title.y = element_text(face="bold", colour="blue", size = 12),
        legend.position = "bottom")


chisq.test(cpt_table)



#Fasting BS

#Person chi square fbs

fbs_table <- table(heart$HeartDisease, heart$FastingBS)
fbs_table



survey_data <- data.frame(fbs_table)
survey_data

ggplot(data = survey_data, aes(x =Var1, y = Freq, fill = Var2)) + 
  geom_bar(stat = "identity", position = "dodge", colour = "black") + 
  scale_fill_brewer(palette = "Pastel1") +
  labs(x = "Heart Failure", y = "Counts \n", 
       title = "",
       fill = "FastingBS") +
  theme(plot.title = element_text(hjust = 0.5),
        axis.title.x = element_text(face="bold", colour="blue", size = 12),
        axis.title.y = element_text(face="bold", colour="blue", size = 12),
        legend.position = "bottom")
chisq.test(fbs_table)


#glm model
heart$HeartDisease[heart$HeartDisease=="No"]<-0
heart$HeartDisease[heart$HeartDisease=="Yes"]<-1

head(heart)

model_glm <- glm( HeartDisease ~ ., data = heart, family = binomial( link = logit ) )
summary( model_glm )

#model_restricted<-glm( HeartDisease ~ Sex + ChestPainType + MaxHR + ST_Slope, data = heart, family = binomial( link = logit ) )
#summary( model_restricted )
#anova
anova(model_glm, test="Chisq")

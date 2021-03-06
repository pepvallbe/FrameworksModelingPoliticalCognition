##############################################################################################################
#TITLE: FRAMEWORKS FOR MODELING COGNITION AND DECISIONS IN INSTITUTIONAL ENVIRONMENTS: A DATA-DRIVEN APPROACH
#AUTHOR: JOAN-JOSEP VALLBÉ
#REPLICATION MATERIALS
#CHAPTER 4: EMPIRICAL CONTEXT 
#SEPTEMBER 18, 2014
##############################################################################################################

library(HH)
library(foreign)
library(sjPlot)
library(stargazer)

#The document assumes you have the data stored in a subdirectory called data/
#The document assumes you have a subdirectory named graphs/
#If you install the ProjectTemplate R package it will create all the subdirectories you need 

#####################################
#LOAD THE SURVEY and DEMOGRAPHIC DATA
#####################################

data <- read.csv("data/data_judges.csv",
                 sep=",",
                 na.strings=c("NA","n/a"))


dem <- read.csv("data/demographics.csv")


########################
#FIG. 4.4: DEMOGRAPHICS
########################

year <- dem$year

pdf("graphs/demographics.pdf",width=10)
par(mfrow=c(2,3))
plot(dem$year,dem$total,
     type="l",
     ylim=c(20,80),
     xaxt="n",
     ylab="Percentage",
     xlab="",
     main="Total")
lines(dem$year,(100-dem$total),type="l",lty=2)
axis(1,at=dem$year,labels=seq(2005,2013,1))
legend("topright",legend=c("Male","Female"),lty=c(2,1))
plot(year,100-dem[,3],type="l",
     lty=2,
     ylim=c(0,100),
     ylab="Percentage",
     xlab="",
     main="20-30 years old")
lines(year,dem[,3],lty=1)
legend("topright",legend=c("Male","Female"),lty=c(2,1))
plot(year,100-dem[,4],type="l",
     lty=2,
     ylim=c(0,100),
     ylab="Percentage",
     xlab="",
     main="30-40 years old")
lines(year,dem[,4],lty=1)
legend("topright",legend=c("Male","Female"),lty=c(2,1))
plot(year,100-dem[,5],type="l",
     lty=2,
     ylim=c(0,100),
     ylab="Percentage",
     xlab="",
     main="40-50 years old")
lines(year,dem[,5],lty=1)
legend("topright",legend=c("Male","Female"),lty=c(2,1))
plot(year,100-dem[,6],type="l",
     lty=2,
     ylim=c(0,100),
     ylab="Percentage",
     xlab="",
     main="50-60 years old")
lines(year,dem[,6],lty=1)
legend("topright",legend=c("Male","Female"),lty=c(2,1))
plot(year,100-dem[,7],type="l",
     lty=2,
     ylim=c(0,110),
     ylab="Percentage",
     xlab="",
     main="60-70 years old")
lines(year,dem[,7],lty=1)
legend("topright",legend=c("Male","Female"),lty=c(2,1))
dev.off()


#########################
#TABLE 4.2: CIVIL STATUS
#########################

table(data$v197,data$v198)

round(prop.table(table(data$v197,data$v198),1)*100,2)


###########################
#TABLE 4.3: CHILDREN
###########################

table(data$v198,data$v199)

round(prop.table(table(data$v198,data$v199),1)*100,2)


########################################################
#TABLE 4.4: POSTGRADUATE STUDIES AND LEGAL PROFESSIONS
########################################################

#POSTGRADUATE

prop.table(table(data$v016))*100

#LEGAL PROFESSIONS

prop.table(table(data$v008))*100


########################################################
#FISHER TEST FOR POSTGRADUATE AND LEGAL PROFESSIONS
########################################################

fisher.test(table(data$v008,data$v016))


##############################################
#TABLE 4.5: POSTGRADUATE VS. LEGAL PROFESSION
##############################################

prop.table(table(data$v008,data$v016),1)*100

######################################
#TABLE 4.7: PROFESSIONAL AFFILIATIONS
######################################

prof <- data[data$v028==1,] #Filter those who are affiliated

prop.table(table(prof$v029))*100


################################
#4.4.3 PROFESSIONAL INTEGRATION
################################

###################################
#FIG. 4.5: CONTACT WITH PEER JUDGES
###################################

likert_int <- data[,c("v118","v120")]


likert_int$v118 <- as.factor(likert_int$v118)
likert_int$v120 <- as.factor(likert_int$v120)

table(likert_int[,1])

likert_int$within[likert_int$v118==7] <- "0"
likert_int$within[likert_int$v118==1] <- "1"
likert_int$within[likert_int$v118==2] <- "2"
likert_int$within[likert_int$v118==3] <- "3"
likert_int$within[likert_int$v118==4] <- "4"
likert_int$within[likert_int$v118==5] <- "5"
likert_int$within[likert_int$v118==6] <- "NA"

likert_int$without[likert_int$v120==7] <- "0"
likert_int$without[likert_int$v120==1] <- "1"
likert_int$without[likert_int$v120==2] <- "2"
likert_int$without[likert_int$v120==3] <- "3"
likert_int$without[likert_int$v120==4] <- "4"
likert_int$without[likert_int$v120==5] <- "5"
likert_int$without[likert_int$v120==6] <- "NA"



levels_int <- list(c("Never","Sporadically", "Sometimes", "Regularly", "Frequently", "Very frequently", "NA"))

items <- list(c("Contact within class", "Contact with other classes"))


pdf("graphs/likert_contact.pdf",width=16)
sjp.likert(likert_int[,c(3,4)],legendLabels=levels_int,
           axisLabels.y=items,
          # orderBy="neg",
           barColor="brewer")
dev.off()


#######################################
#FIG 4.6: INTERPROFESSIONAL INTERACTION
#######################################


rela <- data[,c("v112", "v113", "v114", "v115")]

rela[,1] <- factor(rela[,1],levels=c(1:5))
rela[,2] <- factor(rela[,2],levels=c(1:5))
rela[,3] <- factor(rela[,3],levels=c(1:5))
rela[,4] <- factor(rela[,4],levels=c(1:5))



levels_rela <- list(c("Very negative", "Negative", "Regular", "Positive", "Very positive"))

items <- list(c("Prosecutors", "Lawyers", "Clerks", "Staff"))


pdf("graphs/likert_relation.pdf",width=16)
sjp.stackfrq(rela,legendLabels=levels_rela,
             axisLabels.y=items,
             barColor="brewer")
dev.off()



################################################
#FIG 4.7: RELATIONSHIP WITH OTHER PROFESSIONALS
################################################


rela2 <- data[,c("v135", "v136", "v137",
                 "v138","v139","v140",
                 "v141", "v142", "v143",
                 "v144", "v145", "v146",
                 "v147", "v148", "v149",
                 "v150", "v151", "v152",
                 "v153", "v154")]


rela2[,1] <- factor(rela2[,1],levels=c(1:6))
rela2[,2] <- factor(rela2[,2],levels=c(1:6))
rela2[,3] <- factor(rela2[,3],levels=c(1:6))
rela2[,4] <- factor(rela2[,4],levels=c(1:6))
rela2[,5] <- factor(rela2[,5],levels=c(1:6))
rela2[,6] <- factor(rela2[,6],levels=c(1:6))
rela2[,7] <- factor(rela2[,7],levels=c(1:6))
rela2[,8] <- factor(rela2[,8],levels=c(1:6))
rela2[,9] <- factor(rela2[,9],levels=c(1:6))
rela2[,10] <- factor(rela2[,10],levels=c(1:6))
rela2[,11] <- factor(rela2[,11],levels=c(1:6))
rela2[,12] <- factor(rela2[,12],levels=c(1:6))
rela2[,13] <- factor(rela2[,13],levels=c(1:6))
rela2[,14] <- factor(rela2[,14],levels=c(1:6))
rela2[,15] <- factor(rela2[,15],levels=c(1:6))
rela2[,16] <- factor(rela2[,16],levels=c(1:6))
rela2[,17] <- factor(rela2[,17],levels=c(1:6))
rela2[,18] <- factor(rela2[,18],levels=c(1:6))
rela2[,19] <- factor(rela2[,19],levels=c(1:6))
rela2[,20] <- factor(rela2[,20],levels=c(1:6))


levels_rela2 <- list(c("No relation", "Very bad",
                       "Bad", "Regular",
                       "Good", "Very good"))


items <- list(c("Judicial School",
                "Lawyers Prof. Assoc.",
                "Prison staff",
                "National Police",
                "Civil Guard",
                "Regional Police",
                "Local Police",
                "Medical Examiners",
                "Psychiatrists",
                "Prison evaluators",
                "Social workers",
                "Foreign interpreters",
                "Regional interpreters",
                "Other experts",
                "Local gov't",
                "Regional gov't",
                "Detox centers",
                "Women protection centers",
                "Immigrant protect. centers",
                "NGO"))


pdf("graphs/likert_relation2.pdf",width=20,height=12)
sjp.stackfrq(rela2,legendLabels=levels_rela2,
             axisLabels.y=items,
             barColor="brewer",
             includeN=FALSE,
             showValueLabels=FALSE)
dev.off()



####################################
#TABLE 4.8: FRIENDS
####################################

#friend 1
round(prop.table(table(data$v121))*100,2)
#friend 2
round(prop.table(table(data$v122))*100,2)
#friend 3
round(prop.table(table(data$v123))*100,2)


####################################
#TABLE 4.9: FATHER, MOTHER, PARTNER
####################################

#FATHER
round(prop.table(table(data$v202))*100,2)
#MOTHER
round(prop.table(table(data$v203))*100,2)
#PARTNER
round(prop.table(table(data$v204))*100,2)


##############################################
#TABLE 4.10: WORK AT HOME AND DURING WEEKENDS
##############################################

#home
round(prop.table(table(data$v191))*100,2)
#weekends
round(prop.table(table(data$v192))*100,2)


############################################
#TABLE 4.11: NUMBER OF EXTRA HOURS
############################################

round(prop.table(table(data$v193))*100,2)


#############################################
#TABLE 4.12: PRESSURE FELT AT WORK
#############################################

round(prop.table(table(data$v195))*100,2)


#############################################
#TABLE 4.13: LEVEL OF SATISFACTION AT WORK
#############################################

round(prop.table(table(data$v214))*100,2)


#############################################
#TABLE 4.14: PEER CONSULTATION (FREQUENCY)
#############################################

round(prop.table(table(data$v066))*100,2)



###################################################
#TABLE 4.15: REGRESSION ON HAVING TO ASK ON DOUBTS
###################################################

#Binary response comment/no comment
data$doubt <-  ifelse(data$v066==1,
                      c("1"),c("0"))

data$doubt <- as.factor(data$doubt)


data$hours[data$v193==1] <- '<=10'
data$hours[data$v193==2] <- '>10 and <=20'
data$hours[data$v193==3] <- '>20 and <=30'
data$hours[data$v193==4] <- '>30 and <=40'
data$hours[data$v193==5] <- '>40 and <=50'
data$hours[data$v193==6] <- NA

data$v195 <- as.factor(data$v195)
data$juzg.unico <- as.factor(data$juzg.unico)
data$hours <- as.factor(data$hours)

#Model with only contextual variables
mod <- glm(doubt~log(poblacion) + log(densidad) + juzg.unico ,data=data,family="binomial")

#Add pressure (v195) and number of extra hours
mod2 <- update(mod,.~. + v195 + hours)

#Add postgraduate studies
mod3 <- update(mod2,.~. + as.factor(v016))

#Add legal profession and number of years until becoming a judge
mod4 <- update(mod3,.~. + as.factor(v008)+years.judge)

#results in ascii characters
stargazer(mod,mod4,type="text")

#export results to LaTeX
stargazer(mod,mod4,type="latex")

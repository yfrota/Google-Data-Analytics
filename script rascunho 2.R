
#ANALISE COMPLETA, E PASSO A PASSO

#intalando os pacotes 'tidyverse', e 'sqldf' 
install.packages("tidyverse")
install.packages("sqldf")
install.packages("gridExtra")

library(gridExtra)
library(readr)
library(tidyverse)
library(sqldf)
library(ggplot2)


#IMPORTANDO OS DADOS 
sleepDay_merged <-read_csv("C:/Users/Yuri/Documents/capstone project/fitbit_fitnesstrack_data/sleepDay_merged.csv")
weightLogInfo_merged <- read_csv("C:/Users/Yuri/Documents/capstone project/fitbit_fitnesstrack_data/weightLogInfo_merged.csv")
minuteSleep_merged <- read_csv("C:/Users/Yuri/Documents/capstone project/fitbit_fitnesstrack_data/minuteSleep_merged.csv")
minuteStepsNarrow_merged <- read_csv("C:/Users/Yuri/Documents/capstone project/fitbit_fitnesstrack_data/minuteStepsNarrow_merged.csv")
minuteIntensitiesWide_merged <- read_csv("C:/Users/Yuri/Documents/capstone project/fitbit_fitnesstrack_data/minuteIntensitiesWide_merged.csv")
minuteMETsNarrow_merged <- read_csv("C:/Users/Yuri/Documents/capstone project/fitbit_fitnesstrack_data/minuteMETsNarrow_merged.csv")
minuteCaloriesWide_merged <- read_csv("C:/Users/Yuri/Documents/capstone project/fitbit_fitnesstrack_data/minuteCaloriesWide_merged.csv")
minuteIntensitiesNarrow_merged <- read_csv("C:/Users/Yuri/Documents/capstone project/fitbit_fitnesstrack_data/minuteIntensitiesNarrow_merged.csv")
hourlyCalories_merged <- read_csv("C:/Users/Yuri/Documents/capstone project/fitbit_fitnesstrack_data/hourlyCalories_merged.csv")
hourlyIntensities_merged <- read_csv("C:/Users/Yuri/Documents/capstone project/fitbit_fitnesstrack_data/hourlyIntensities_merged.csv")
hourlySteps_merged <-read_csv("C:/Users/Yuri/Documents/capstone project/fitbit_fitnesstrack_data/hourlySteps_merged.csv")
minuteCaloriesNarrow_merged <- read_csv("C:/Users/Yuri/Documents/capstone project/fitbit_fitnesstrack_data/minuteCaloriesNarrow_merged.csv")
dailyactivity_merged <-read_csv("C:/Users/Yuri/Documents/capstone project/fitbit_fitnesstrack_data/dailyActivity_merged.csv")
dailyCalories_merged <-read_csv("C:/Users/Yuri/Documents/capstone project/fitbit_fitnesstrack_data/dailyCalories_merged.csv")
dailyIntensities_merged <-read_csv("C:/Users/Yuri/Documents/capstone project/fitbit_fitnesstrack_data/dailyIntensities_merged.csv")
dailySteps_merged <-read_csv("C:/Users/Yuri/Documents/capstone project/fitbit_fitnesstrack_data/dailySteps_merged.csv")
heartrate_seconds_merged <-read_csv("C:/Users/Yuri/Documents/capstone project/fitbit_fitnesstrack_data/heartrate_seconds_merged.csv")


data()

#CHECANDO OS DADOS E LIMPEZA (Vamos dar uma olhada nos atributos diarios)

#Atividade diaria(dailyactivity_merged)
colnames(dailyactivity_merged)
head(dailyactivity_merged)
str(dailyactivity_merged)
nrow(dailyactivity_merged)
glimpse(dailyactivity_merged)

#Dias de sono(sleepDay_merged)
colnames(sleepDay_merged)
head(sleepDay_merged)
str (sleepDay_merged)
nrow(sleepDay_merged)
glimpse(sleepDay_merged)

#Intensidade diaria(dailyIntensities_merged)
colnames(dailyIntensities_merged)
head(dailyIntensities_merged)
str (dailyIntensities_merged)
nrow(dailyIntensities_merged)
glimpse(dailyIntensities_merged)

#Calorias diárias(dailyCalories_merged)
colnames(dailyCalories_merged)
head(dailyCalories_merged)
str (dailyCalories_merged)
nrow(dailyCalories_merged)
glimpse(dailyCalories_merged)

#Registro de peso(weightLogInfo_merged)
colnames(weightLogInfo_merged)
head(weightLogInfo_merged)
str (weightLogInfo_merged)
nrow(weightLogInfo_merged)
glimpse(weightLogInfo_merged)

#Passos diarios(dailySteps_merged)
colnames(dailySteps_merged)
head(dailySteps_merged)
str (dailySteps_merged)
nrow(dailySteps_merged)
glimpse(dailySteps_merged)

# Podemos conferir a qualidade do banco de dados utilizando o metodo ROCCC.
# Do inglês, ROCCC : Reliability, Originality, Comprehensiveness, Current, Cited

# Confiabilidade (Reliability): 
# Devido a pequena amostragem (30 participantes), e a falta de outras variaveis estatísticas, restringem a possibilidade de análises mais aprofundadas.

# Originalidade (Originality):
# Estes dados nao foram coletados originalmente pelo fabricante, e sim pela Amazon Mechanical Murk.

# Abrangência (Comprehensiveness):
# Os dados não informam sexo, idade, e outras condições que poderiam gerar resultados mais precisos. Para esta análise, Não levar em conta essas características pode tornar o resutlado enviesado.

# Atualidade (Current):
# Os dados foram coletados em 2016, e podem gerar informações desatualizadas.

# Citação (Cited):
# Dados coletados pela Amazon Mechanical Murk

# Apos esta breve análise referente a qualidade dos dados, podemos considerar uma escassez de informações para análises mais precisas.
# Desta forma, iremos tomar a análise obtida com os resultados como um ponto inicial para próximas análises.


# VERIFICANDO INTEGRIDADE DOS DADOS, E O NUMERO DE IDS POR TABELA
teste1 <- sqldf ('SELECT DISTINCT Id FROM "dailyCalories_merged"')
nrow(teste1)

teste2 <- sqldf ('SELECT DISTINCT Id FROM "dailyactivity_merged"')
nrow(teste2)

teste3 <- sqldf ('SELECT DISTINCT Id FROM "dailyIntensities_merged"')
nrow(teste3)

teste4 <- sqldf ('SELECT DISTINCT Id FROM "dailySteps_merged"')
nrow(teste4)

teste5 <- sqldf ('SELECT DISTINCT Id FROM "sleepDay_merged"')
nrow(teste5)

teste6 <- sqldf ('SELECT DISTINCT Id FROM "weightLogInfo_merged"')
nrow(teste6)

# Verificando a quantidade de dias dos dados registrados.
n_distinct(dailyactivity_merged$ActivityDate)

#Durante a checagem, observou-se que ambas tabelas abaixo possuem uma quantidade de registros inferior aos registros das outras tabelas diarias.
nrow(weightLogInfo_merged)
nrow(sleepDay_merged)

n_distinct(weightLogInfo_merged$Id)
n_distinct(sleepDay_merged$Id)


#A tabela referente a peso, e indices de massa corporal ('weightLogInfo_merged'), e a tabela referente ao sono diario ('sleepDay_merged'),
#se apresentam incompletas, com menos registros que as demais, portanto nao vamos considera-la na análise dos dados.
#Constatou-se tambem, que nem todos os ids estao registrados nestas duas tabelas, e para manter a conformidade dos dados, não vamos utiliza-las

#Vamos tomar como referência as tabelas de dados diários acumulados ('daily...')

#Apos analise inicial dos dados contidos na tabela 'dailyactivity_merges', foram observadas colunas de mesmo atributo que as tabelas:
#('dailyCalories_merged' , 'dailyIntensities_merged', 'dailySteps_merged', e 'sleepDay_merged')

#Vamos verificar se a tabela de atividade diaria('dailyactivity_merges') possui o mesmo numero de registros 
#das outras tabelas diarias ('dailyCalories_merged' , 'dailyIntensities_merged', 'dailySteps_merged', e 'sleepDay_merged'),
#para confirmar a hipotese de que as colunas de mesmo atributo possuem dados correspondentes às outras tabelas(dados iguais). 

#Para isso, iremos criar data frames ('daily_activity...') da 'dailyactivity_merges', incluindo apenas as colunas de correspondencia das tabelas em questao.

#check1 é a nova tabela, que consiste da intersecção entre o data frame (daily_activity...) criado e a outra tabela em questao.('daily...')
#O SELECT foi utilizado apenas nas colunas que serao utilizadas para a verificação cruzada.(As mesmas colunas da tabela que sera feita a checagem)

#Data frame da 'dailyActivity_merged' ??? 'dailyCalories_merged'
daily_activity1 <- dailyactivity_merged %>% select(Id, ActivityDate, Calories)
check1 <- sqldf ('SELECT * FROM daily_activity1 INTERSECT SELECT * FROM dailyCalories_merged')
nrow(daily_activity1)
head (daily_activity1)
nrow(check1)
head (check1)

#Data frame da 'dailyActivity_merged' ??? 'dailyIntensities_merged'
daily_activity2 <- dailyactivity_merged %>% select(Id, ActivityDate, SedentaryMinutes, LightlyActiveMinutes, FairlyActiveMinutes, VeryActiveMinutes, SedentaryActiveDistance, LightActiveDistance, ModeratelyActiveDistance, VeryActiveDistance)
check2 <- sqldf('SELECT * FROM daily_activity2 INTERSECT SELECT * FROM dailyIntensities_merged')
nrow(daily_activity2)
head (daily_activity2)
nrow(check2)
head (check2)

#Data frame da 'dailyActivity_merged' ??? 'dailySteps_merged'
daily_activity3 <- dailyactivity_merged %>%  select(Id, ActivityDate, TotalSteps)
check3 <- sqldf('SELECT * FROM daily_activity3 INTERSECT SELECT * FROM dailySteps_merged')
nrow(daily_activity3)
head (daily_activity3)
nrow(check3)
head (check3)

#as 940 linhas encontradas em suas intersecções (check1, check2, e check3), evidenciam que suas referencias sao devidamente correspondentes(dados iguais).


#Checando o numero de linhas, e o numero de Ids diferentes
nrow(check1)
head(check1)
str(check1)
n_distinct(check1$Id)

nrow(check2)
head(check2)
str(check2)
n_distinct(check2$Id)

nrow(check3)
head(check3)
str(check3)
n_distinct(check3$Id)

#Sendo confirmado que a tabela dailyactivity_merged é a consolidação das outras tabelas de resumos diario, vamos utiliza-la como base para nossa analise.


#Criação dos visuais e Análise dos dados

#Vamos agora observar um sumário das caracteristicas gerais dos habitos diários para iniciar nossa análise.

dailyActivity_merged %>%  summary()
sleepDay_merged %>%  summary ()

#Importantes dados diários obtidos
#TotalSteps Mean   : 7638
#TotalSteps Max.   :36019
#TotalDistance Mean   : 5.490
#TotalDistance Max.   :28.030
#Calories Mean   :2304
#Calories Max.   :4900
#SedentaryMinutes Mean   : 991.2
#SedentaryMinutes Max.   :1440.0
#TotalMinutesAsleep Mean   :419.5
#TotalMinutesAsleep Max.   :796.0

#pouco tempo de exercicio
#media de consumo calorico
#Muito tempo sedentarios
#Comparar as medias obtidas com os indices ideais.Com fonte


#Perfil agrupado por dia (elaborar mais)
teste11 <- sqldf('SELECT ActivityDate, Id, MIN(TotalSteps) AS min_steps, AVG(TotalSteps) AS avg_steps, MAX(TotalSteps) AS max_steps FROM "dailyactivity_merged" GROUP BY ActivityDate')
teste11
teste11 <- sqldf('SELECT ActivityDate, Id, MIN(TotalSteps) AS min_steps, AVG(TotalSteps) AS avg_steps, MAX(TotalSteps) AS max_steps FROM "dailyactivity_merged" GROUP BY ActivityDate')



#grafico X , Y, com variavel cor para identificar outros padroes de outra variavel

ggplot(data=dailyactivity_merged, aes(x=SedentaryMinutes, y=TotalDistance, color = Calories)) + geom_point()
ggplot(data=dailyactivity_merged, aes(x=LightlyActiveMinutes, y=TotalDistance, color = Calories)) + geom_point()
ggplot(data=dailyactivity_merged, aes(x=FairlyActiveMinutes, y=TotalDistance, color = Calories)) + geom_point()
ggplot(data=dailyactivity_merged, aes(x=VeryActiveMinutes, y=TotalDistance, color = Calories)) + geom_point()

ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=TotalSteps, y=Calories, color = LightActiveDistance))
ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=TotalSteps, y=Calories, color = SedentaryActiveDistance))
ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=TotalSteps, y=Calories, color = FairlyActiveMinutes))
ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=TotalSteps, y=Calories, color = VeryActiveMinutes))



#Observe as relações


#Vamos tomar como referência a queima de calorias, e associando com outros atributos para obtermos correlações.

ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=TotalSteps, y=Calories ))
ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=TotalDistance, y= Calories ))
ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=LightActiveDistance, y= Calories ))
ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=ModeratelyActiveDistance, y= Calories ))
ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=SedentaryActiveDistance, y= Calories ))
ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=VeryActiveDistance, y= Calories ))

ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=TotalSteps, y=Calories ))  + geom_smooth(mapping = aes (x=TotalSteps, y= Calories ))
ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=TotalDistance, y= Calories ))  + geom_smooth(mapping = aes (x=TotalDistance, y= Calories ))
ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=LightActiveDistance, y= Calories ))  + geom_smooth(mapping = aes (x=LightActiveDistance, y= Calories ))
ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=ModeratelyActiveDistance, y= Calories ))  + geom_smooth(mapping = aes (x=ModeratelyActiveDistance, y= Calories ))
ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=SedentaryActiveDistance, y= Calories ))  + geom_smooth(mapping = aes (x=SedentaryActiveDistance, y= Calories ))
ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=VeryActiveDistance, y= Calories ))  + geom_smooth(mapping = aes (x=VeryActiveDistance, y= Calories ))


ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=SedentaryMinutes, y= Calories )) 
ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=LightlyActiveMinutes, y= Calories ))
ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=FairlyActiveMinutes, y= Calories ))
ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=VeryActiveMinutes, y= Calories ))

ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=SedentaryMinutes, y= Calories )) + geom_smooth(mapping = aes (x=SedentaryMinutes, y= Calories ))
ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=LightlyActiveMinutes, y= Calories )) + geom_smooth(mapping = aes (x=LightlyActiveMinutes, y= Calories ))
ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=FairlyActiveMinutes, y= Calories )) + geom_smooth(mapping = aes (x=FairlyActiveMinutes, y= Calories ))
ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=VeryActiveMinutes, y= Calories )) + geom_smooth(mapping = aes (x=VeryActiveMinutes, y= Calories ))

merge_1 <- merge(dailyActivity_merged, dailyCalories_merged, by = c("Id","Calories"))
nrow(merge_1)

#GRAFICOS DEMONSTRATIVOS
#CORRELAÇÃO PERDA CALORICA COM DISTANCIA MAXIMA PERCORRIDA.
ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=TotalDistance, y= Calories))
ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=TotalDistance, y= Calories ))  + geom_smooth(mapping = aes (x=TotalDistance, y= Calories ))

#CORRELAÇÃO PERDA CALORICA COM TEMPO DE ATIVIDADE LEVE.                                               
ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=LightlyActiveMinutes, y= Calories ))
ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=LightlyActiveMinutes, y= Calories )) + geom_smooth(mapping = aes (x=LightlyActiveMinutes, y= Calories ))

#CORRELAÇÃO PERDA CALORICA COM TEMPO DE ATIVIDADE INTENSA.   
ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=VeryActiveMinutes, y= Calories ))
ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=VeryActiveMinutes, y= Calories )) + geom_smooth(mapping = aes (x=VeryActiveMinutes, y= Calories ))

#CORRELAÇÃO PERDA CALORICA COM TEMPO DE ATIVIDADE SEDENTARIA.   
ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=SedentaryMinutes, y= Calories )) 
ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=SedentaryMinutes, y= Calories )) + geom_smooth(mapping = aes (x=SedentaryMinutes, y= Calories ))


#Agora faremos uma relação mais detalhada da queima de calorias relacionada ao tipo de atividade diaria, Comparando o gasto calorico com a soma total das distancias percorridas, e os minutos em atividade.
#Em seguida faremos um outro comparativo, comparando o gasto calorico com a distancia percorrida com atividade sedentaria, e tambem com o tempo sedentario.


daily_activity4 <- sqldf ('SELECT Id, ActivityDate,Calories, TotalSteps, TotalDistance, TrackerDistance, LoggedActivitiesDistance, (VeryActiveDistance+ModeratelyActiveDistance+LightActiveDistance) AS ActiveDistanceTotal,SedentaryActiveDistance, (VeryActiveMinutes+FairlyActiveMinutes+LightlyActiveMinutes) AS ActiveMinutesTotal, SedentaryMinutes FROM "dailyactivity_merged"')

colnames(daily_activity4)
nrow(daily_activity4)

ggplot(data=daily_activity4) + geom_point(mapping = aes (x=ActiveMinutesTotal, y=Calories ))
ggplot(data=daily_activity4) + geom_point(mapping = aes (x=ActiveDistanceTotal, y=Calories ))
ggplot(data=daily_activity4) + geom_point(mapping = aes (x=ActiveMinutesTotal, y=Calories )) + geom_smooth(mapping = aes (x=ActiveMinutesTotal, y= Calories ))
ggplot(data=daily_activity4) + geom_point(mapping = aes (x=ActiveDistanceTotal, y=Calories )) + geom_smooth(mapping = aes (x=ActiveDistanceTotal, y= Calories ))

ggplot(data=daily_activity4) + geom_point(mapping = aes (x=SedentaryMinutes, y=Calories ))
ggplot(data=daily_activity4) + geom_point(mapping = aes (x=SedentaryActiveDistance, y=Calories ))
ggplot(data=daily_activity4) + geom_point(mapping = aes (x=SedentaryMinutes, y=Calories )) + geom_smooth(mapping = aes (x=SedentaryMinutes, y= Calories ))
ggplot(data=daily_activity4) + geom_point(mapping = aes (x=SedentaryActiveDistance, y=Calories )) + geom_smooth(mapping = aes (x=SedentaryActiveDistance, y= Calories ))

ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=VeryActiveMinutes, y=Calories ))
ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=VeryActiveDistance, y=Calories ))
ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=VeryActiveMinutes, y=Calories )) + geom_smooth(mapping = aes (x=VeryActiveMinutes, y= Calories ))
ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=VeryActiveDistance, y=Calories )) + geom_smooth(mapping = aes (x=VeryActiveDistance, y= Calories ))

ggplot(data=dailyactivity_merged) +
  geom_point(mapping=aes(x=TotalDistance, y= Calories, color = 'Orange'))+
  labs (title = "CORRELAÇÃO PERDA CALORICA COM DISTANCIA MAXIMA PERCORRIDA", subtitle = "de usuários de relógio smart ", 
        caption= "Data criada por Yuri Faria Frota")+
  annotate("text", x=20, y=2500, label ="check correlation", color = "Gray") + theme(legend.position = "none")




#GRAFICOS FINAIS
#CORRELAÇÃO PERDA CALORICA COM DISTANCIA MAXIMA PERCORRIDA(editando).


distanciamaximaplot<- ggplot(data=dailyactivity_merged) +
  geom_point(mapping=aes(x=TotalDistance, y= Calories, color = 'Orange'))+
  labs (title = "DISTÂNCIA TOTAL", subtitle = "em km ", 
         x = "Distância Total (km)", y = "Perda Calórica")+ 
  theme(legend.position = "none") +
  geom_smooth(method=lm,mapping = aes (x=TotalDistance, y= Calories ))


#CORRELAÇÃO PERDA CALORICA COM TEMPO DE ATIVIDADE LEVE(editando).
tempoleveplot <- ggplot(data=dailyactivity_merged) +
  geom_point(mapping=aes(x=LightlyActiveMinutes, y= Calories, color = 'Orange'))+
  labs (title = "ATIVIDADE LEVE", subtitle = "em min ", x = "Atividade leve (min)", y = "Perda Calórica") +
  theme(legend.position = "none") +
  geom_smooth(method=lm, mapping = aes (x=LightlyActiveMinutes, y= Calories ))


#CORRELAÇÃO PERDA CALORICA COM TEMPO DE ATIVIDADE INTENSA.(editando).
tempointensoplot <-ggplot(data=dailyactivity_merged) +
  geom_point(mapping=aes(x=VeryActiveMinutes, y= Calories, color = 'Orange'))+
  labs (title = "ATIVIDADE INTENSA", subtitle = "em min ", x = "atividade intensa (min)", y = "Perda Calórica") + 
  theme(legend.position = "none") +
  geom_smooth(method=lm,mapping = aes (x=VeryActiveMinutes, y= Calories ))


#CORRELAÇÃO PERDA CALORICA COM TEMPO DE ATIVIDADE SEDENTARIA.(editando).
tempoesedentarioplot<-ggplot(data=dailyactivity_merged) +
  geom_point(mapping=aes(x=SedentaryMinutes, y= Calories, color = 'Orange'))+
  labs (title = "ATIVIDADE SEDENTARIA", subtitle = "em min ", x = "Atividade sedentária (min)", y = "Perda Calórica") +
  theme(legend.position = "none") +
  geom_smooth(method=lm, mapping = aes (x=SedentaryMinutes, y= Calories ))

#CORRELAÇÃO PERDA CALORICA COM TEMPO TOTAL DE ATIVIDADE.(editando).
tempototalplot<-ggplot(data=daily_activity4) +
  geom_point(mapping=aes(x=ActiveMinutesTotal, y= Calories, color = 'Orange'))+
  labs (title = "ATIVIDADE TOTAL", subtitle = "em min ", 
        caption= "Criado por Yuri Faria Frota", x = "Atividade total (min)", y = "Perda Calórica") +
  theme(legend.position = "none") +
  geom_smooth(method=lm, mapping = aes (x=ActiveMinutesTotal, y= Calories ))

grid.arrange(tempoesedentarioplot, tempoleveplot, tempointensoplot, tempototalplot, nrow = 2)
grid.arrange(distanciamaximaplot, tempototalplot, nrow = 1)
####



####
distanciamaximaplot
tempoleveplot
tempointensoplot
tempoesedentarioplot
tempototalplot


#O fato das pessoas nao coletarem os dados sobre sono, e peso, pode ter um motivo por tras, mas sao dados importantes que levariam para informações ainda mais valiosas.
#O importante é se exercitar.


install.packages("rmarkdown")
daily_activity4 <- sqldf ('SELECT Id, ActivityDate,Calories, TotalSteps, TotalDistance, TrackerDistance, LoggedActivitiesDistance, (VeryActiveDistance+ModeratelyActiveDistance+LightActiveDistance) AS ActiveDistanceTotal,SedentaryActiveDistance, (VeryActiveMinutes+FairlyActiveMinutes+LightlyActiveMinutes) AS ActiveMinutesTotal, SedentaryMinutes FROM "dailyactivity_merged"')



daily_activity5 <- sqldf ('SELECT Id, ActivityDate,Calories, TotalSteps, TotalDistance, TrackerDistance, LoggedActivitiesDistance, (VeryActiveDistance+ModeratelyActiveDistance+LightActiveDistance) AS ActiveDistanceTotal,SedentaryActiveDistance, (VeryActiveMinutes+FairlyActiveMinutes+LightlyActiveMinutes) AS ActiveMinutesTotal, SedentaryMinutes FROM "dailyactivity_merged"')

sqldf 

#4/12/2016 terca
#4/13/2016 quarta "4/13/2016" "4/20/2016" "4/27/2016" "5/4/2016"
#4/14/2016 quinta "4/14/2016" "4/21/2016" "4/28/2016" "5/5/2016"
#4/15/2016 sexta "4/15/2016" "4/22/2016" "4/29/2016" "5/6/2016"
#4/16/2016 sabado "4/16/2016" "4/23/2016" "4/30/2016" "5/7/2016"
#4/17/2016 domingo "4/17/2016" "4/24/2016" "5/1/2016" "5/8/2016"
#4/18/2016 segunda "4/18/2016" "4/25/2016" "5/2/2016" "5/9/2016"
#4/19/2016 terca
#4/20/2016 quarta
#4/21/2016 quinta
#4/22/2016 sexta
#4/23/2016 sabado
#4/24/2016 domingo
#4/25/2016 segunda
#4/26/2016 terca
#4/27/2016 quarta
#4/28/2016 quinta
#4/29/2016 sexta
#4/30/2016 sabado
#5/1/2016 domingo
#5/2/2016 segunda
#5/3/2016 terca
#5/4/2016 quarta
#5/5/2016 quinta
#5/6/2016 sexta
#5/7/2016 sabado
#5/8/2016 domingo
#5/9/2016 segunda

#segunda ActivityDate = "4/18/2016" OR ActivityDate = "4/25/2016" OR ActivityDate = "5/2/2016" OR ActivityDate = "5/9/2016"
#terca ActivityDate = "4/12/2016" OR ActivityDate = "4/19/2016" OR ActivityDate = "4/26/2016" OR ActivityDate = "5/3/2016"
#quarta ActivityDate = "4/13/2016" OR ActivityDate = "4/20/2016" OR ActivityDate = "4/27/2016" OR ActivityDate = "5/4/2016"
#quinta ActivityDate = "4/14/2016" OR ActivityDate = "4/21/2016" OR ActivityDate = "4/28/2016" OR ActivityDate = "5/5/2016"
#sexta ActivityDate = "4/15/2016" OR ActivityDate = "4/22/2016" OR ActivityDate = "4/29/2016" OR ActivityDate = "5/6/2016"
#sabado ActivityDate = "4/16/2016" OR ActivityDate = "4/23/2016" OR ActivityDate = "4/30/2016" OR ActivityDate = "5/7/2016"
#domingo ActivityDate = "4/17/2016" OR ActivityDate = "4/24/2016" OR ActivityDate = "5/1/2016" OR ActivityDate = "5/8/2016"


novogeral <- sqldf ('SELECT * from "dailyactivity_merged"') 
colnames(novogeral)

segunda <- sqldf('SELECT Id,ActivityDate,TotalDistance,Calories FROM "novogeral" WHERE ActivityDate = "4/18/2016" OR ActivityDate = "4/25/2016" OR ActivityDate = "5/2/2016" OR ActivityDate = "5/9/2016" ')
terca <- sqldf('SELECT Id,ActivityDate,TotalDistance,Calories FROM "novogeral" WHERE ActivityDate = "4/12/2016" OR ActivityDate = "4/19/2016" OR ActivityDate = "4/26/2016" OR ActivityDate = "5/3/2016" ')
quarta <- sqldf('SELECT Id,ActivityDate,TotalDistance,Calories FROM "novogeral" WHERE ActivityDate = "4/13/2016" OR ActivityDate = "4/20/2016" OR ActivityDate = "4/27/2016" OR ActivityDate = "5/4/2016" ')
quinta <- sqldf('SELECT Id,ActivityDate,TotalDistance,Calories FROM "novogeral" WHERE ActivityDate = "4/14/2016" OR ActivityDate = "4/21/2016" OR ActivityDate = "4/28/2016" OR ActivityDate = "5/5/2016" ')
sexta <- sqldf('SELECT Id,ActivityDate,TotalDistance,Calories FROM "novogeral" WHERE ActivityDate = "4/15/2016" OR ActivityDate = "4/22/2016" OR ActivityDate = "4/29/2016" OR ActivityDate = "5/6/2016" ')
sabado <- sqldf('SELECT Id,ActivityDate,TotalDistance,Calories FROM "novogeral" WHERE ActivityDate = "4/16/2016" OR ActivityDate = "4/23/2016" OR ActivityDate = "4/30/2016" OR ActivityDate = "5/7/2016" ')
domingo <- sqldf('SELECT Id,ActivityDate,TotalDistance,Calories FROM "novogeral" WHERE ActivityDate = "4/17/2016" OR ActivityDate = "4/24/2016" OR ActivityDate = "5/1/2016" OR ActivityDate = "5/8/2016" ')

nrow(terca)

semana <- sqldf ('SELECT Id,ActivityDate,TotalDistance, Calories, CASE WHEN 
       ActivityDate = "4/18/2016" OR ActivityDate = "4/25/2016" OR ActivityDate = "5/2/2016" OR ActivityDate = "5/9/2016" THEN "segunda"
       WHEN ActivityDate = "4/12/2016" OR ActivityDate = "4/19/2016" OR ActivityDate = "4/26/2016" OR ActivityDate = "5/3/2016" OR ActivityDate = "5/10/2016" THEN "terca" 
       WHEN ActivityDate = "4/13/2016" OR ActivityDate = "4/20/2016" OR ActivityDate = "4/27/2016" OR ActivityDate = "5/4/2016" OR ActivityDate = "5/11/2016" THEN "quarta" 
       WHEN ActivityDate = "4/14/2016" OR ActivityDate = "4/21/2016" OR ActivityDate = "4/28/2016" OR ActivityDate = "5/5/2016" OR ActivityDate = "5/12/2016" THEN "quinta" 
       WHEN ActivityDate = "4/15/2016" OR ActivityDate = "4/22/2016" OR ActivityDate = "4/29/2016" OR ActivityDate = "5/6/2016" THEN "sexta" 
       WHEN ActivityDate = "4/16/2016" OR ActivityDate = "4/23/2016" OR ActivityDate = "4/30/2016" OR ActivityDate = "5/7/2016" THEN "sabado" 
       WHEN ActivityDate = "4/17/2016" OR ActivityDate = "4/24/2016" OR ActivityDate = "5/1/2016" OR ActivityDate = "5/8/2016" THEN "domingo" 
       ELSE 0 end as diadasemana FROM "novogeral" ')
nrow(semana)
head (semana)
semanaordem <- sqldf(' SELECT * FROM "semana" ORDER BY ActivityDate ASC ')
head (semanaordem)


#POUCA OU QUSE NENHUMA DIFERENÇA NO GASTO CALORICO POR DIA DE SEMANA
ggplot(data=semana1) +
  geom_point(mapping=aes(x=TotalDistance, y= Calories, color = diadasemana ))+
  labs (title = "PERDA CALORICA vs DISTANCIA TOTAL ", subtitle = "por dia da semana", 
        caption= "Data criada por Yuri Faria Frota", x = "Distância Total (km)", y = "Perda Calórica")
#Melhor visualização   
ggplot(data=semana1) +
  geom_boxplot(mapping=aes(x=diadasemana, y= Calories, fill = diadasemana ))+
  labs (title = "PERDA CALORICA vs DIA DA SEMANA ", subtitle = "de usuários de smart devices", 
        caption= "Data criada por Yuri Faria Frota", x = "Dia da semana", y = "Perda Calórica")


semanasono <- sqldf ('SELECT Id, SleepDay , TotalMinutesAsleep, CASE WHEN 
       SleepDay = "4/18/2016 12:00:00 AM" OR SleepDay = "4/25/2016 12:00:00 AM" OR SleepDay = "5/2/2016 12:00:00 AM" OR SleepDay = "5/9/2016 12:00:00 AM" THEN "2-segunda"
       WHEN SleepDay = "4/12/2016 12:00:00 AM" OR SleepDay = "4/19/2016 12:00:00 AM" OR SleepDay = "4/26/2016 12:00:00 AM" OR SleepDay = "5/3/2016 12:00:00 AM" OR SleepDay = "5/10/2016 12:00:00 AM" THEN "3-terca" 
       WHEN SleepDay = "4/13/2016 12:00:00 AM" OR SleepDay = "4/20/2016 12:00:00 AM" OR SleepDay = "4/27/2016 12:00:00 AM" OR SleepDay = "5/4/2016 12:00:00 AM" OR SleepDay = "5/11/2016 12:00:00 AM" THEN "4-quarta" 
       WHEN SleepDay = "4/14/2016 12:00:00 AM" OR SleepDay = "4/21/2016 12:00:00 AM" OR SleepDay = "4/28/2016 12:00:00 AM" OR SleepDay = "5/5/2016 12:00:00 AM" OR SleepDay = "5/12/2016 12:00:00 AM" THEN "5-quinta" 
       WHEN SleepDay = "4/15/2016 12:00:00 AM" OR SleepDay = "4/22/2016 12:00:00 AM" OR SleepDay = "4/29/2016 12:00:00 AM" OR SleepDay = "5/6/2016 12:00:00 AM" THEN "6-sexta" 
       WHEN SleepDay = "4/16/2016 12:00:00 AM" OR SleepDay = "4/23/2016 12:00:00 AM" OR SleepDay = "4/30/2016 12:00:00 AM" OR SleepDay = "5/7/2016 12:00:00 AM" THEN "7-sabado" 
       WHEN SleepDay = "4/17/2016 12:00:00 AM" OR SleepDay = "4/24/2016 12:00:00 AM" OR SleepDay = "5/1/2016 12:00:00 AM" OR SleepDay = "5/8/2016 12:00:00 AM" THEN "1-domingo" 
       ELSE 0 end as diadasemana FROM "sleepDay_merged" ')


semanasono1 <- sqldf ('SELECT diadasemana, SUM(TotalMinutesAsleep) AS total FROM "semanasono" GROUP BY diadasemana ')

ggplot(data=semanasono1) + geom_bar(mapping = aes (x = diadasemana))

# TESTANDO

semana1 <- sqldf ('SELECT *, CASE WHEN 
       ActivityDate = "4/18/2016" OR ActivityDate = "4/25/2016" OR ActivityDate = "5/2/2016" OR ActivityDate = "5/9/2016" THEN "2-segunda"
       WHEN ActivityDate = "4/12/2016" OR ActivityDate = "4/19/2016" OR ActivityDate = "4/26/2016" OR ActivityDate = "5/3/2016" OR ActivityDate = "5/10/2016" THEN "3-terca" 
       WHEN ActivityDate = "4/13/2016" OR ActivityDate = "4/20/2016" OR ActivityDate = "4/27/2016" OR ActivityDate = "5/4/2016" OR ActivityDate = "5/11/2016" THEN "4-quarta" 
       WHEN ActivityDate = "4/14/2016" OR ActivityDate = "4/21/2016" OR ActivityDate = "4/28/2016" OR ActivityDate = "5/5/2016" OR ActivityDate = "5/12/2016" THEN "5-quinta" 
       WHEN ActivityDate = "4/15/2016" OR ActivityDate = "4/22/2016" OR ActivityDate = "4/29/2016" OR ActivityDate = "5/6/2016" THEN "6-sexta" 
       WHEN ActivityDate = "4/16/2016" OR ActivityDate = "4/23/2016" OR ActivityDate = "4/30/2016" OR ActivityDate = "5/7/2016" THEN "7-sabado" 
       WHEN ActivityDate = "4/17/2016" OR ActivityDate = "4/24/2016" OR ActivityDate = "5/1/2016" OR ActivityDate = "5/8/2016" THEN "1-domingo" 
       ELSE 0 end as diadasemana FROM "novogeral" ')


semanasono <- sqldf ('SELECT Id, SleepDay , TotalMinutesAsleep, CASE WHEN 
       SleepDay = "4/18/2016 12:00:00 AM" OR SleepDay = "4/25/2016 12:00:00 AM" OR SleepDay = "5/2/2016 12:00:00 AM" OR SleepDay = "5/9/2016 12:00:00 AM" THEN "2-segunda"
       WHEN SleepDay = "4/12/2016 12:00:00 AM" OR SleepDay = "4/19/2016 12:00:00 AM" OR SleepDay = "4/26/2016 12:00:00 AM" OR SleepDay = "5/3/2016 12:00:00 AM" OR SleepDay = "5/10/2016 12:00:00 AM" THEN "3-terca" 
       WHEN SleepDay = "4/13/2016 12:00:00 AM" OR SleepDay = "4/20/2016 12:00:00 AM" OR SleepDay = "4/27/2016 12:00:00 AM" OR SleepDay = "5/4/2016 12:00:00 AM" OR SleepDay = "5/11/2016 12:00:00 AM" THEN "4-quarta" 
       WHEN SleepDay = "4/14/2016 12:00:00 AM" OR SleepDay = "4/21/2016 12:00:00 AM" OR SleepDay = "4/28/2016 12:00:00 AM" OR SleepDay = "5/5/2016 12:00:00 AM" OR SleepDay = "5/12/2016 12:00:00 AM" THEN "5-quinta" 
       WHEN SleepDay = "4/15/2016 12:00:00 AM" OR SleepDay = "4/22/2016 12:00:00 AM" OR SleepDay = "4/29/2016 12:00:00 AM" OR SleepDay = "5/6/2016 12:00:00 AM" THEN "6-sexta" 
       WHEN SleepDay = "4/16/2016 12:00:00 AM" OR SleepDay = "4/23/2016 12:00:00 AM" OR SleepDay = "4/30/2016 12:00:00 AM" OR SleepDay = "5/7/2016 12:00:00 AM" THEN "7-sabado" 
       WHEN SleepDay = "4/17/2016 12:00:00 AM" OR SleepDay = "4/24/2016 12:00:00 AM" OR SleepDay = "5/1/2016 12:00:00 AM" OR SleepDay = "5/8/2016 12:00:00 AM" THEN "1-domingo" 
       ELSE 0 end as diadasemana FROM "sleepDay_merged" ')

#POUCA OU QUSE NENHUMA DIFERENÇA NO GASTO CALORICO POR DIA DE SEMANA
ggplot(data=semana1) +
  geom_point(mapping=aes(x=TotalDistance, y= Calories, color = diadasemana ))+
  labs (title = "PERDA CALORICA vs DISTANCIA TOTAL ", subtitle = "por dia da semana", 
        caption= "Data criada por Yuri Faria Frota", x = "Distância Total (km)", y = "Perda Calórica")
#Melhor visualização   
ggplot(data=semana1) +
  geom_boxplot(mapping=aes(x=diadasemana, y= Calories, fill = diadasemana ))+
  labs (title = "PERDA CALORICA vs DIA DA SEMANA ", subtitle = "de usuários de smart devices", 
        caption= "Data criada por Yuri Faria Frota", x = "Dia da semana", y = "Perda Calórica")


#Impacto de uma noite mal dormida
#Média de horas sedentárias vs. Dia da semana

semana1 %>% 
  group_by(diadasemana) %>% 
  summarise( totalsedentaryminutes= sum(SedentaryMinutes) ) %>% 
  ggplot(aes(x = diadasemana, y = (totalsedentaryminutes/12600), fill = diadasemana)) +
  geom_col() +
  labs (title = "Média de horas sedentárias vs. Dia da semana", subtitle = "de usuários de relógio smart", 
        caption= "criado por Yuri Faria Frota", x = "Dias da semana", y = "Tempo sedentário") + theme(legend.position = "none") 

#Horas de sono, por dia da semana
#NOTA-SE QUE SEGUNDA FEIRA É O DIA COM MENOS HORAS DE SONO
semanasono %>% 
  group_by(diadasemana) %>% 
  summarise(totalsono = sum(TotalMinutesAsleep)) %>% 
  ggplot(aes(x = diadasemana, y = totalsono/2880, fill = diadasemana)) +
  geom_col() +
  labs (title = "Horas de sono vs. Dia da semana", subtitle = "de usuários de relógio smart ", 
        caption= "criado por Yuri Faria Frota", x = "Dias da semana", y = "Horas de sono") + theme(legend.position = "none") 


nrow(semanasono)
head(semanasono) 
n_distinct(semanasono$Id)


ggplot(data=dailyactivity_merged) + geom_point(mapping = aes (x=TotalSteps, y=Calories, color = 
                                                                LightlyActiveMinutes))

colnames(novogeral)
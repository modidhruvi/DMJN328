#setwd("C:/Users/dhruv/OneDrive/Desktop/Data")

#Import my data
Travel <- read.csv(file="Travel.csv",stringsAsFactors = FALSE)
View(Travel)
names(Travel)<-c("date", "International", "Non-resident", "Canadian", "Other")
names(Travel)
#work on making variable 1 a date
# convert date info in format 'mm/dd/yyyy'
str(Travel)
#paste command added day with -01
library(lubridate)
Travel$date2 <-paste(Travel$date,"-01",sep="")
str(Travel)
#ymd truns into a date
ymd(Travel$date2)
#saves the date
Travel$date2 <- ymd(Travel$date2)
str(Travel)
library(tidyverse)
Travel %>% gather(key="type", value="number",2:5)-> Travel2
str(Travel2)

Travel2 %>% 
mutate(Travelling=as.numeric(str_replace_all(number, ",","")))-> Travel3
str(Travel3)

options(scipen = 999)

library(ggplot2)
#colors <- c("red", "blue", "yellow", "green")
ggplot(data=Travel3, aes(fill=type, x=date2, y=Travelling, col=type))+
 geom_line()+
  geom_point()+
  theme(plot.title = element_text(hjust =0.5)) +
  theme(plot.subtitle = element_text(hjust=0.5))+
  xlab('Months')+
  ylab('Number of people travelling')+
  labs (title = "Types of Travellers traveling in Canada",
    subtitle = "July - November 2019")+
labs(tag = "Statistics from StatsCan")+
  coord_cartesian(clip = "off")+
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(t= 10, r= 10, b= 40, l= 10),
        plot.tag.position = c(0.8,0.0)
  )


#Installing Cancensus
#install.packages('cancensus')
install.packages('sf')
library(cancensus)

#permanent API in R
#file.edit(file.path('~/.Rprofile'))
#
options(cancensus.api_key='CensusMapper_2486d77226424f2e990a57a75c729034')
options(cancensus.cancensus.cache_path="~")

brampton <- get_census(dataset='CA16', regions=list(CSD="3521010"), vectors=c(), labels="detailed", geo_format="sf", level='DA')

library(tidyverse)
glimpse(brampton)

library(ggplot2)
ggsave("population.jpg")
ggplot(brampton, aes(geometry=geometry))+geom_sf()
ggplot(brampton, aes=5+
         (geometry=geometry+
            fill=population))+geom_sf()
brampton2 <- get_census(dataset="CA16",regions=list(CSD = 3521010),vectors = c("v_CA16_2606", "V_CA16_2605", "V_CA16_2604"),
                          labels = "detailed", geo_format = "sf", level = "DA")

glimpse(brampton2)
names(brampton2)

brampton2 %>%
  rename("Languages"= `v_CA16_2606: Official languages`)-> brampton3

names(brampton3)

ggplot(brampton3, aes(geometry=geometry, fill=Languages))+geom_sf()

names(brampton3)

brampton3 %>%
  mutate(percent=(Languages/Population)*100)->brampton4

ggplot(brampton4) + geom_sf(aes(fill = percent)) + scale_fill_gradient(low = "#56B1F7", high = "#132B43")+ 
  theme(plot.title = element_text(hjust=0.5))+
  labs(title="Official Languages spoken in Brampton")+
  labs(tag = "Census Mapper")+
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(t= 20, r= 20, b= 40, l= 20),
        plot.tag.position = c(0.8,-0.05))


brampton5 <- get_census(dataset = "CA16", regions = list(CSD= 3521010), vectors = c("v_CA16_2605","v_CA16_2604"), 
                        labels = "detailed", geo_format = "sf", level = "DA")
glimpse(brampton5)
names(brampton5)
brampton5 %>%
  rename(Females=15, Males=14)->brampton6
names(brampton6)
brampton6 %>%
  gather(Sex, n, Females, Males)-> brampton7
glimpse(brampton7)

ggplot(brampton7, aes(geometry=geometry, fill=n))+
  geom_sf()+
  facet_wrap(~Sex)+
  scale_fill_gradient(low = "#56B1F7", high = "#132B43")+
  theme(plot.title = element_text(hjust=0.5))+
  labs(title="Official Languages spoken in Brampton by Gender")+
  labs(tag = "Census Mapper")+
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(t= 20, r= 20, b= 40, l= 20),
        plot.tag.position = c(0.8,-0.05))

names(brampton8)

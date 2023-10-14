
library(gsheet)
library(tidyverse)
library(arules)
library(arulesViz)
library(viridis)

# Importar el DF ----

DF <- read.csv(
  text = gsheet2text(url = "https://docs.google.com/spreadsheets/d/1NTjA8nrmcWltvZn4oq5KJK7-R4Mb-_is_5vVsoBDCv0/edit?usp=sharing",
                     format = "csv"),
  stringsAsFactors = F
)



# Crear las canastas ----

## Asignar un ID de canasta

DF1 <- DF %>% 
  mutate(basket.id = paste(Member_number, Date, sep = "_")) %>% 
  select(basket.id, itemDescription)



## Crear una lista

DF.list <- split(x = DF1$itemDescription,
                 f = DF1$basket.id)



## Formato transaction

DF.trans <- as(object = DF.list,
               Class = "transactions")

class(DF.trans)



# Análisis de lo más vendido

itemFrequencyPlot(x = DF.trans,
                  topN = 15,
                  horiz = T,
                  col = viridis(15))



# Reglas

rules <- apriori(data = DF.trans,
                 parameter = list(supp = 0.0005,
                                  conf = 0.15,
                                  minlen = 2,
                                  maxlen = 2))

















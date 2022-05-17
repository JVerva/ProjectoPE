excelFilePath <- "/home/verva/Downloads/ResiduosPerCapita.xlsx"

library(readxl)
Paises <- read_excel(excelFilePath,"Quadro","A13:A43", col_types = "text")
Paises <- as.vector(unlist(Paises))

PaisesReq <- c("DK - Dinamarca", "GR - Grécia", "FR - França")
Indexes <- match(PaisesReq, Paises)
Indexes <- Indexes + 13 -1
Indexes <- as.character(Indexes)

i = integer()
for (i in 1:length(Indexes)){
  Indexes[i] <- paste("B", Indexes[i], ":C", Indexes[i], sep = "")
}

for(i in 1:length(Indexes)){
  if(i == 1){
    ResiduosPerCapita = names(read_excel(excelFilePath,"Quadro",Indexes[i]))
  }else{
    ResiduosPerCapita = append(ResiduosPerCapita, names(read_excel(excelFilePath, "Quadro", Indexes[i])))
  }
}
rm(i)
rm(excelFilePath)

Paises <- vector(class(PaisesReq), length(rep(PaisesReq,2)))
Paises[c(TRUE,FALSE)]<-PaisesReq
Paises[c(FALSE,TRUE)]<-PaisesReq
rm(PaisesReq)

Anos = as.factor(c("2004","2018"))

data <- data.frame(as.factor(Paises), as.factor(as.double(ResiduosPerCapita)),Anos)

library(tidyverse)
ggplot(data, aes(x=Paises, y=ResiduosPerCapita, fill = Anos)) + geom_bar(position = "dodge", stat = "identity")

rm(list = ls())


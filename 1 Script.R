excelFilePath <- "C:\\Users\\joaog\\Downloads\\ResiduosPerCapita(1).xlsx"

library(readxl)
data <- read_excel(excelFilePath,"Quadro","A13:C43")

Paises1 = as.vector(as.character(unlist(data[1])))
Ano1 = as.vector(as.double(unlist(data[2])))
Ano2 = as.vector(as.double(unlist(data[3])))

ResiduosPerCapita <- vector(class(Ano1), length(c(Ano1,Ano2)))
ResiduosPerCapita[c(TRUE,FALSE)]<-Ano1
ResiduosPerCapita[c(FALSE,TRUE)]<-Ano2

Paises <- vector(class(Paises1), length(c(Paises1,Paises1)))
Paises[c(TRUE,FALSE)]<-Paises1
Paises[c(FALSE,TRUE)]<-Paises1
Paises <- substr(Paises,1,2)

Anos = as.factor(c("2004","2018"))
data <- data.frame(as.factor(Paises), as.factor(ResiduosPerCapita),Anos)

library(tidyverse)
ggplot(data, aes(x=Paises, y=ResiduosPerCapita, fill= Anos)) + geom_bar(position = "dodge", stat = "identity")


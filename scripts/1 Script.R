#path do ficheiro, sendo que não consegui automatizar o download devido ao login do tecnico
excelFilePath <- "C:\\Users\\joaog\\Downloads\\ResiduosPerCapita.xlsx"

#ler o quadro inteiro
library(readxl)
Paises <- read_excel(excelFilePath,"Quadro","A13:A43", col_types = "text")
Paises <- as.vector(unlist(Paises))

#paises que procuro
PaisesReq <- c("DK - Dinamarca", "GR - Grécia", "FR - França")

#buscar data dos paises
Indexes <- match(PaisesReq, Paises)
Indexes <- Indexes + 13
Indexes <- as.character(Indexes)
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

#fazer a data frame
Paises <- vector(class(PaisesReq), length(rep(PaisesReq,2)))
Paises[c(TRUE,FALSE)]<-PaisesReq
Paises[c(FALSE,TRUE)]<-PaisesReq
Anos = c("2004","2018")
ResiduosPerCapita <- as.double(ResiduosPerCapita)

data <- data.frame(Paises, ResiduosPerCapita ,Anos)

#plot do gráfico
library(ggplot2)
ggplot(data, aes(x=Paises, y=ResiduosPerCapita, fill = Anos)) + 
geom_bar(position = "dodge", stat = "identity") + 
labs(x = "Paises", y = "Residuos per capita (toneladas)")

#limpar os dados
rm(list = ls())


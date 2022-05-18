excelFilePath <- "/home/verva/Downloads/EsperancaVida.xlsx"

library(readxl)
Paises <- names(read_excel(excelFilePath,"Quadro","B9:CY9", col_types = "text", .name_repair = "minimal"))
Paises <- as.vector(unlist(Paises))
Anos <- read_excel(excelFilePath,"Quadro","A51:A69", col_types = "text")

PaisesReq <- c("NL - Países Baixos", "BG - Bulgária", "IT - Itália")
for (j in 1:3) {
  for(i in 1:3){
    if(i==1 && j==1){
    Indexes <- match(PaisesReq[j], Paises)
    }
    else{
      Indexes <- append(Indexes, match(PaisesReq[j], Paises))
    }
    Paises[Indexes[i+(j-1)*3]]="Found"
  }
}
Indexes <- Indexes + 1
library(openxlsx)
Indexes <- int2col(Indexes)
for (i in 1:length(Indexes)){
  Indexes[i] <- paste(Indexes[i], "51:", Indexes[i], "69", sep = "")
}

for(i in 1:length(PaisesReq)){
  if(i == 1){
    Paises <- rep(PaisesReq[i],18*length(PaisesReq))
  }else{
  Paises <- append(Paises,rep(PaisesReq[i],18*length(PaisesReq)))
  }
}

Categoria <- rep(c(rep("Total",18), rep("Homens",18), rep("Mulheres",18)),3)

for(i in 1:length(Indexes)){
  if(i == 1){
    EsperancaDeVida = read_excel(excelFilePath,"Quadro",Indexes[i])
  }else{
    EsperancaDeVida = append(EsperancaDeVida, read_excel(excelFilePath, "Quadro", Indexes[i]))
  }
}

Anos<- rep(Anos, 3*length(PaisesReq))
Anos <- unlist(Anos)
EsperancaDeVida <- as.factor(as.vector(as.double(unlist(EsperancaDeVida))))
Paises <- as.factor(Paises)
Anos <- as.factor(Anos)
Categoria <- as.factor(Categoria)

data <- data.frame(Paises,EsperancaDeVida,Anos,Categoria)
datar <- subset(data, Categoria == "Homens" | Categoria == "Mulheres")

library(tidyverse)
ggplot(data = datar, aes(x=Anos, y=EsperancaDeVida, group = Paises, colour = Paises, fill = Categoria)) + geom_line() + facet_wrap(facets = vars(Categoria))
rm(list = ls())


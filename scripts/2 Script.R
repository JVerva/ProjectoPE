#path do ficheiro, sendo que não consegui automatizar o download devido ao login do técnico
excelFilePath <- "C:\\Users\\joaog\\Downloads\\EsperancaVida.xlsx"

#ler a linha com os nomes dos países e anos
library(readxl)
Paises <- names(read_excel(excelFilePath,"Quadro","B9:CY9", col_types = "text", .name_repair = "minimal"))
Paises <- as.vector(unlist(Paises))
Anos <- read_excel(excelFilePath,"Quadro","A51:A69", col_types = "text")

#definir os países requeridos
PaisesReq <- c("NL - Países Baixos", "BG - Bulgária", "IT - Itália")

#encontrar os países requeridos e ler os seus dados
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

for(i in 1:length(Indexes)){
  if(i == 1){
    EsperancaDeVida = read_excel(excelFilePath,"Quadro",Indexes[i])
  }else{
    EsperancaDeVida = append(EsperancaDeVida, read_excel(excelFilePath, "Quadro", Indexes[i]))
  }
}

#definir a data frame
for(i in 1:length(PaisesReq)){
  if(i == 1){
    Paises <- rep(PaisesReq[i],18*length(PaisesReq))
  }else{
    Paises <- append(Paises,rep(PaisesReq[i],18*length(PaisesReq)))
  }
}

Categoria <- rep(c(rep("Total",18), rep("Homens",18), rep("Mulheres",18)),3)
Anos<- rep(Anos, 3*length(PaisesReq))
Anos <- as.double(unlist(Anos))
EsperancaDeVida <- as.double(unlist(EsperancaDeVida))

data <- data.frame(Paises,EsperancaDeVida,Anos,Categoria)
datar <- subset(data, Categoria == "Homens" | Categoria == "Mulheres")

#plot do gráfico
library(ggplot2)
ggplot(data = datar, aes(x=Anos, y=EsperancaDeVida, group = Paises, colour = Paises)) + 
  geom_line() + 
  facet_wrap(facets = vars(Categoria)) + 
  geom_point() + 
  labs(x = "Anos", y = "Esperança de vida (Anos)") +
  scale_x_continuous(breaks = round(seq(min(Anos), max(Anos), by = 2),1)) +
  scale_y_continuous(breaks = round(seq(min(EsperancaDeVida)-0.8, max(EsperancaDeVida)+1, by = 1),1))

#limpar dados
rm(list = ls())

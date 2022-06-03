#path do ficheiro, sendo que não consegui automatizar o download devido ao login do tecnico
excelFilePath <- "C:\\Users\\joaog\\Downloads\\QualidadeARO3.xlsx"

#ler a linha com os nomes das regiões
library(readxl)
Estacoes <- names(read_excel(excelFilePath,"Sheet1","A1:J1", col_types = "text", .name_repair = "minimal"))
Estacoes <- as.vector(unlist(Estacoes))

#definir as regiões requeridas
EstacoesReq <- c("Restelo", "Entrecampos")

#encontrar as regiões requeridas e ler os seus dados
Indexes <- match(EstacoesReq, Estacoes)
library(openxlsx)
Indexes <- int2col(Indexes)
for (i in 1:length(Indexes)){
  Indexes[i] <- paste(Indexes[i], "1:", Indexes[i], "8785", sep = "")
}
for (i in 1:length(Indexes)){
  if(i==1){
    nozono <- read_excel(excelFilePath,"Sheet1",Indexes[i], col_types = "text")
  }else{
    nozono <- append(nozono,read_excel(excelFilePath,"Sheet1",Indexes[i], col_types = "text"))
  }
}

#construir a data frame
nozono <- as.double(unlist(nozono))

for(i in 1:length(EstacoesReq)){
  if(i == 1){
    Estacoes <- rep(EstacoesReq[i],8784)
  }else{
   Estacoes <- append(Estacoes, rep(EstacoesReq[i],8784)) 
  }
}
data <- data.frame(Estacoes,as.factor(nozono))

#plot do gráfico
library(ggplot2)
ggplot(data , aes(x = nozono)) + 
  geom_histogram(colour = "black", fill = "green",bins = 20) + 
  facet_wrap(facets = vars(Estacoes)) +
  labs(x = expression(paste("Nivel de ozono (",mu,g/m^3,")")), y = "Contagem", sep="") +
  scale_x_continuous(breaks = round(seq(min(nozono), max(nozono), by = 25),1)) +
  scale_y_continuous(breaks = round(seq(0, 1600, by = 250),1))

#limpar os dados
rm(list = ls())
